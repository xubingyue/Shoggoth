#include "cinder/Camera.h"
#include "cinder/Quaternion.h"
#include "cinder/gl/Vbo.h"
#include "cinder/gl/Light.h"
#include "cinder/BSpline.h"

#include "src/Graphics/ShAvatar.h"
#include "src/ShGlobals.h"
#include "src/Resources.h"
#include "src/Graphics/ShSeqPath.h"

using namespace cinder;
using namespace gl;
bool redOn = false;


///////////////
// ShAvatarMap
///////////////

ShAvatarMap::ShAvatarMap()
{

}

ShAvatarMap::~ShAvatarMap()
{
    boost::shared_lock<boost::shared_mutex> lock(mMutex);
    clear();
}

void ShAvatarMap::add(std::string avatar, cinder::Vec3f pos)
{
    boost::shared_lock<boost::shared_mutex> lock(mMutex);
    mAvatarMap[avatar] = new ShAvatar(avatar, pos, mAvatarMap.size());
}

void ShAvatarMap::move(std::string avatar, cinder::Vec3f pos)
{
    boost::shared_lock<boost::shared_mutex> lock(mMutex);
    mAvatarMap[avatar]->setPos(pos);
}

void ShAvatarMap::rotate(std::string avatar, cinder::Quatf rot)
{
    boost::shared_lock<boost::shared_mutex> lock(mMutex);
    mAvatarMap[avatar]->setRot(rot);
}

void ShAvatarMap::setPosX(std::string avatar, float x)
{
    boost::shared_lock<boost::shared_mutex> lock(mMutex);
    mAvatarMap[avatar]->setPosX(x);
}

void ShAvatarMap::setPosY(std::string avatar, float y)
{
    boost::shared_lock<boost::shared_mutex> lock(mMutex);
    mAvatarMap[avatar]->setPosY(y);
}

void ShAvatarMap::setPosZ(std::string avatar, float z)
{
    boost::shared_lock<boost::shared_mutex> lock(mMutex);
    mAvatarMap[avatar]->setPosZ(z);
}

void ShAvatarMap::setRotX(std::string avatar, float x)
{
    boost::shared_lock<boost::shared_mutex> lock(mMutex);
    mAvatarMap[avatar]->setRotX(x);
}

void ShAvatarMap::setRotY(std::string avatar, float y)
{
    boost::shared_lock<boost::shared_mutex> lock(mMutex);
    mAvatarMap[avatar]->setRotY(y);
}

void ShAvatarMap::setRotZ(std::string avatar, float z)
{
    boost::shared_lock<boost::shared_mutex> lock(mMutex);
    mAvatarMap[avatar]->setRotZ(z);
}

void ShAvatarMap::setRotW(std::string avatar, float w)
{
    boost::shared_lock<boost::shared_mutex> lock(mMutex);
    mAvatarMap[avatar]->setRotW(w);
}

void ShAvatarMap::remove(std::string avatar)
{
    boost::shared_lock<boost::shared_mutex> lock(mMutex);
    deletionQueue.push_back(avatar);
}

bool ShAvatarMap::contains(std::string avatar)
{
    boost::shared_lock<boost::shared_mutex> lock(mMutex);
    avatarIter find = mAvatarMap.find(avatar);
    return find != mAvatarMap.end();
}

void ShAvatarMap::update()
{
    boost::shared_lock<boost::shared_mutex> lock(mMutex);

    if(deletionQueue.size() > 0)
    {
        std::deque<std::string>::iterator deleteIter = deletionQueue.begin();
        while(deleteIter != deletionQueue.end())
        {
            std::string avatarName = *deleteIter;
            ShAvatar* avatar = mAvatarMap[avatarName];
            mAvatarMap[avatarName] = 0;
            mAvatarMap.erase(avatarName);
            delete avatar;
            ++deleteIter;
        }

        deletionQueue.clear();
    }

    avatarIter iter = mAvatarMap.begin();

    while(iter != mAvatarMap.end())
    {
        if(iter->second->mUserName.compare(ShGlobals::USER_NAME) != 0)
            iter->second->update();
        ++iter;
    }
}

void ShAvatarMap::draw()
{
    boost::shared_lock<boost::shared_mutex> lock(mMutex);
    ShAvatar::material.apply();
    avatarIter iter = mAvatarMap.begin();

    while(iter != mAvatarMap.end())
    {
        if(iter->second->mUserName.compare(ShGlobals::USER_NAME) != 0)
            iter->second->draw();

        ++iter;
    }
}

void ShAvatarMap::drawName()
{
    boost::shared_lock<boost::shared_mutex> lock(mMutex);
    avatarIter iter = mAvatarMap.begin();

    while(iter != mAvatarMap.end())
    {
        if(iter->second->mUserName.compare(ShGlobals::USER_NAME) != 0)
            iter->second->drawName();
        ++iter;
    }
}

void ShAvatarMap::clear()
{
    boost::shared_lock<boost::shared_mutex> lock(mMutex);
    avatarIter iter = mAvatarMap.begin();

    while(iter != mAvatarMap.end())
    {
        delete iter->second;
        ++iter;
    }

    mAvatarMap.clear();
}

////////////
// ShAvatar
////////////

ShAvatarMap ShAvatar::avatarMap;
cinder::gl::VboMesh ShAvatar::mesh;
Material ShAvatar::material = Material(
            cinder::Color(1, 1, 1),
            cinder::Color(1, 1, 1),
            cinder::Color(1, 1, 1),
            60.0f,
            cinder::Color(60, 60, 60)
);

cinder::gl::VboMesh ShAvatar::MESH[ShAvatar::NUM_SEGMENTS];
std::vector<cinder::Vec3f> ShAvatar::positions[ShAvatar::NUM_SEGMENTS];
std::vector<cinder::Vec3f> ShAvatar::normals[ShAvatar::NUM_SEGMENTS];
std::vector<cinder::ColorA> ShAvatar::colors[ShAvatar::NUM_SEGMENTS];

void ShAvatar::createMesh()
{
    for(int i = 0; i < ShAvatar::NUM_SEGMENTS; ++i)
    {
        ShAvatar::positions[i] = std::vector<cinder::Vec3f>();
        ShAvatar::normals[i] = std::vector<cinder::Vec3f>();
        ShAvatar::colors[i] = std::vector<cinder::ColorA>();
    }

    Vec3f pyramid[18] = {
        // Face 1
        Vec3f(0, 1, 0),
        Vec3f(-0.5, 0, 0.5),
        Vec3f(0.5, 0, 0.5),
        // Face 2
        Vec3f(0, 1, 0),
        Vec3f(0.5, 0, 0.5),
        Vec3f(0.5, 0, -0.5),
        // Face 3
        Vec3f(0, 1, 0),
        Vec3f(0.5, 0, -0.5),
        Vec3f(-0.5, 0, -0.5),
        // Face 4
        Vec3f(0, 1, 0),
        Vec3f(-0.5, 0, -0.5),
        Vec3f(-0.5, 0, 0.5),
        // Face 5
        Vec3f(-0.5, 0, -0.5),
        Vec3f(-0.5, 0, 0.5),
        Vec3f(0.5, 0, -0.5),
        // Face 6
        Vec3f(-0.5, 0, 0.5),
        Vec3f(0.5, 0, 0.5),
        Vec3f(0.5, 0, -0.5)
    };

    for(unsigned int i = 0; i < ShAvatar::NUM_SEGMENTS; ++i)
    {
        uint16_t vertexCount = 18;
        float segmentSize = i / 4.0;

        VboMesh::Layout layout;
        layout.setStaticIndices();
        layout.setStaticColorsRGBA();
        layout.setStaticPositions();
        layout.setStaticNormals();

        ShAvatar::MESH[i] = VboMesh(vertexCount, vertexCount, layout, GL_TRIANGLES);

        for(int j = 0; j < vertexCount; ++j)
        {
            ShAvatar::positions[i].push_back(pyramid[j] * segmentSize);
        }

        ShAvatar::MESH[i].bufferPositions(ShAvatar::positions[i]);

        for(int j = 0; j < vertexCount; ++j)
        {
            ShAvatar::colors[i].push_back(ColorA(1, 0, 0, 1));
        }

        ShAvatar::MESH[i].bufferColorsRGBA(ShAvatar::colors[i]);

        ShTri tri;
        for(int j = 0; j < vertexCount; j += 3)
        {
            tri.fill(ShAvatar::positions[i][j], ShAvatar::positions[i][j + 1], ShAvatar::positions[i][j + 2]);

            ShAvatar::normals[i].push_back(tri.normal());
            ShAvatar::normals[i].push_back(tri.normal());
            ShAvatar::normals[i].push_back(tri.normal());
        }

        ShAvatar::MESH[i].bufferNormals(ShAvatar::normals[i]);

        std::vector<uint32_t> surfaceIndices;

        for(int j = 0; j < vertexCount; ++j)
        {
            surfaceIndices.push_back(j);
        }

        ShAvatar::MESH[i].bufferIndices(surfaceIndices);
    }
}

/*
void ShAvatar::createMesh()
{
    std::vector<cinder::Vec3f> positions;
    std::vector<cinder::Vec3f> normals;
    std::vector<cinder::ColorA> colors;

    uint16_t vertexCount = 18;
    float segmentSize = 10;

    VboMesh::Layout layout;
    layout.setStaticIndices();
    layout.setStaticColorsRGBA();
    layout.setStaticPositions();
    layout.setStaticNormals();

    ShAvatar::mesh = VboMesh(vertexCount, vertexCount, layout, GL_TRIANGLES);

    Vec3f pyramid[18] = {
        // Face 1
        Vec3f(0, 0, -2),
        Vec3f(0.5, -0.5, 0),
        Vec3f(0.5, 0.5, 0),
        // Face 2
        Vec3f(0, 0, -2),
        Vec3f(0.5, 0.5, 0),
        Vec3f(-0.5, 0.5, 0),
        // Face 3
        Vec3f(0, 0, -2),
        Vec3f(-0.5, 0.5, 0),
        Vec3f(-0.5, -0.5, 0),
        // Face 4
        Vec3f(0, 0, -2),
        Vec3f(-0.5, -0.5, 0),
        Vec3f(0.5, -0.5, 0),
        // Face 5
        Vec3f(-0.5, -0.5, 0),
        Vec3f(0.5, -0.5, 0),
        Vec3f(-0.5, 0.5, 0),
        // Face 6
        Vec3f(0.5, -0.5, 0),
        Vec3f(0.5, 0.5, 0),
        Vec3f(-0.5, 0.5, 0)
    };

    for(int j = 0; j < vertexCount; ++j)
    {
        positions.push_back(pyramid[j] * segmentSize);
    }

    ShAvatar::mesh.bufferPositions(positions);

    for(int j = 0; j < vertexCount; ++j)
    {
        if(j == 0 || j == 3 || j == 6 || j == 8)
            colors.push_back(ColorA(0.25, 0.25, 0.25, 1));
        else
            colors.push_back(ColorA(0.0, 0.0, 0.0, 1));
    }

    ShAvatar::mesh.bufferColorsRGBA(colors);

    ShTri tri;
    for(int j = 0; j < vertexCount; j += 3)
    {
        tri.fill(positions[j], positions[j + 1], positions[j + 2]);

        normals.push_back(tri.normal());
        normals.push_back(tri.normal());
        normals.push_back(tri.normal());
    }

    ShAvatar::mesh.bufferNormals(normals);

    std::vector<uint32_t> indices;

    for(int j = 0; j < vertexCount; ++j)
    {
        indices.push_back(j);
    }

    ShAvatar::mesh.bufferIndices(indices);
}
*/

ShAvatar::ShAvatar(std::string userName, cinder::Vec3f pos, int id) :
    mUserName(userName),
    mPos(pos),
    mID(id),
    colorMode(BLACK_AVATAR)
{
    mCubeSize = cinder::Vec3f(25, 25, 25);
    nameTextureGenerated = false;

    for(unsigned int i = 0; i < ShAvatar::NUM_SEGMENTS; ++i)
    {
        mPositions.push_back(cinder::Vec3f::zero());
    }
}

void ShAvatar::setPos(cinder::Vec3f pos)
{
    boost::shared_lock<boost::shared_mutex> lock(mMutex);
    mPos = pos;

    if(pos != mPositions.back())
    {
        mPositions.pop_front();
        mPositions.push_back(pos);
    }
}


void ShAvatar::setRot(cinder::Quatf rot)
{
    boost::shared_lock<boost::shared_mutex> lock(mMutex);
    mRot = rot;
}

void ShAvatar::setPosX(float x)
{
    boost::shared_lock<boost::shared_mutex> lock(mMutex);
    mPos.x = x;
}

void ShAvatar::setPosY(float y)
{
    boost::shared_lock<boost::shared_mutex> lock(mMutex);
    mPos.y = y;
}

void ShAvatar::setPosZ(float z)
{
    boost::shared_lock<boost::shared_mutex> lock(mMutex);
    mPos.z = z;
}

void ShAvatar::setRotX(float x)
{
    boost::shared_lock<boost::shared_mutex> lock(mMutex);
    mRot.v.x = x;
}

void ShAvatar::setRotY(float y)
{
    boost::shared_lock<boost::shared_mutex> lock(mMutex);
    mRot.v.y = y;
}

void ShAvatar::setRotZ(float z)
{
    boost::shared_lock<boost::shared_mutex> lock(mMutex);
    mRot.v.z = z;
}

void ShAvatar::setRotW(float w)
{
    boost::shared_lock<boost::shared_mutex> lock(mMutex);
    mRot.w = w;
    // ShGlobals::DATA->queueAvatarPosition(mUserName, mPos, mRot);
}

cinder::Vec3f ShAvatar::getPos()
{
    boost::shared_lock<boost::shared_mutex> lock(mMutex);
    return mPos;
}

void ShAvatar::update()
{
    boost::shared_lock<boost::shared_mutex> lock(mMutex);
    if(!nameTextureGenerated)
        createNameTexture();
}

void ShAvatar::draw()
{
    boost::shared_lock<boost::shared_mutex> lock(mMutex);

    /*
    float random = rand() % RAND_MAX / (float) RAND_MAX;

    if(random < 0.5)
        glColor3f(0, 0, 0);
    else
        glColor3f(1, 0, 0);

    unsigned int index =  0;*/

    if(redOn)
        cinder::gl::color(cinder::Color(1, 0, 0));
    else
        cinder::gl::color(cinder::Color(0, 0, 0));


    /*
    switch(rand() % 2)
    {
    case BLACK_AVATAR:
        cinder::gl::color(cinder::Color(0, 0, 0));
        colorMode = RED_AVATAR;
        break;

    case RED_AVATAR:
        cinder::gl::color(cinder::Color(1, 0, 0));
        colorMode = WHITE_AVATAR;
        break;

    case WHITE_AVATAR:
        cinder::gl::color(cinder::Color(1, 1, 1));
        colorMode = BLACK_AVATAR;
        break;
    }*/


    for(unsigned int i = 0; i < ShAvatar::NUM_SEGMENTS ; ++i)
    {
        // cinder::Vec3f position = mPositions.at(i);
        // glPushMatrix();
        // glTranslatef(position.x, position.y, position.z);


        /*
        if(i > 0)
        {
            cinder::gl::drawLine(mPositions.at(i - 1), mPositions.at(i));

        }*/

        /*
        cinder::Vec3f head = mPositions.at(ShAvatar::NUM_SEGMENTS - 1);
        // cinder::Vec3f penultimate = mPositions.at(ShAvatar::NUM_SEGMENTS - 2);
        cinder::gl::pushMatrices();
        glTranslatef(head.x, head.y, head.z);
        cinder::gl::rotate(mRot);
        // cinder::gl::drawCube(cinder::Vec3f::zero(), cinder::Vec3f(9, 9, 9));
        cinder::gl::draw(ShAvatar::MESH[ShAvatar::NUM_SEGMENTS - 1]);
        cinder::gl::popMatrices();
        */

        cinder::Vec3f position = mPositions.at(i);
        glPushMatrix();
        glTranslatef(position.x, position.y, position.z);

        cinder::gl::draw(ShAvatar::MESH[i]);
        glPopMatrix();

        /*
        if(i > 0)
        {
            cinder::Vec3f rotation = mPositions.at(i).cross(mPositions.at(i - 1));
            cinder::gl::rotate(rotation.normalized());
        }*/

        // unsigned int size = (i + 1) / 4.0;
        // cinder::gl::drawStrokedCube(mPositions.at(i), cinder::Vec3f(size, size, size));
        // glPopMatrix();
    }

    redOn = !redOn;

    /*
    glBegin(GL_TRIANGLE_STRIP);

    std::deque<cinder::Vec3f>::iterator iter = mPositions.begin();
    while(iter != mPositions.end())
    {
        if(redOn)
            glColor3f(1, 0, 0);
        else
            glColor3f(0, 0, 0);

        glVertex3f(iter->x, iter->y, iter->z);
        ++iter;
        //++index;
    }

    redOn = !redOn;*/

    // glEnd();

    // glBegin(GL_TRIANGLE_FAN);

    /*
    for(unsigned int i = 0; i < 9; ++i)
    {
        cinder::Vec3i randomPos = cinder::Vec3i(
                    (rand() % RAND_MAX / (float) RAND_MAX) * 10 - 5,
                    (rand() % RAND_MAX / (float) RAND_MAX) * 10 - 5,
                    (rand() % RAND_MAX / (float) RAND_MAX) * 10 - 5
        );

        // cinder::Vec3f randomSegment = mPositions.at((rand() % 3) + (NUM_SEGMENTS - 3));
        glColor3f(random, 0, 0);
        glVertex3f(mPositions.at(NUM_SEGMENTS - 2).x + randomPos.x, mPositions.at(NUM_SEGMENTS - 2).y + randomPos.y, mPositions.at(NUM_SEGMENTS - 2).z + randomPos.z);
        // glVertex3f(randomSegment.x, randomSegment.y, randomSegment.z);
        // glVertex3f(mPositions.back().x + randomPos.x, mPositions.back().y, mPositions.back().z);
    }*/

    glEnd();

    // glPushMatrix();

    // cinder::gl::translate(mPos);
    // cinder::gl::rotate(mRot);
    // cinder::gl::draw(ShAvatar::mesh);

    /*
    cinder::gl::Light light(cinder::gl::Light::POINT, 1 + mID);
    light.setAmbient(Color(0.5f, 0.5f, 0.5f));
    light.setDiffuse(cinder::Color::white());
    light.setSpecular(cinder::Color::white());
    light.setPosition(cinder::Vec3f::zero());*/

    // glPopMatrix();
}

void ShAvatar::drawName()
{
    boost::shared_lock<boost::shared_mutex> lock(mMutex);
    if(nameTextureGenerated && ShGlobals::CAMERA->canView(mPos))
    {
        //glEnable(GL_BLEND);
        //glBlendFunc(GL_ONE_MINUS_DST_COLOR,GL_ONE_MINUS_SRC_COLOR);

        cinder::gl::draw(nameTexture, ShGlobals::CAMERA->getCam().worldToScreen(
                               mPos+cinder::Vec3f(0, 10, 0),
                               ShGlobals::SCREEN_SIZE.x,
                               ShGlobals::SCREEN_SIZE.y));

        //glDisable(GL_BLEND);
    }
}

void ShAvatar::createNameTexture()
{
    boost::shared_lock<boost::shared_mutex> lock(mMutex);
    cinder::TextLayout layout;
    layout.clear(cinder::ColorA(0, 0, 0, 1));
    layout.setColor(cinder::ColorA(1, 1, 1, 1));
#ifdef __APPLE__
    layout.setFont(cinder::Font(cinder::app::loadResource(TEXT_TEXTURE), 12));
#else
    // layout.setFont(cinder::Font(cinder::app::loadResource("./resources/OCRAEXT.ttf", 134, "TTF"), 12));
    layout.setFont(cinder::Font("Ubuntu", 12));
#endif
    layout.addLine(mUserName);

    cinder::Surface8u rendered = layout.render(true);

    nameTexture = cinder::gl::Texture(rendered);
    nameTextureGenerated = true;
}

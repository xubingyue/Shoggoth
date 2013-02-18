#include "cinder/Camera.h"
#include "cinder/Quaternion.h"
#include "cinder/gl/Vbo.h"
#include "cinder/gl/Light.h"

#include "src/Graphics/ShAvatar.h"
#include "src/ShGlobals.h"
#include "src/Resources.h"
#include "src/Graphics/ShSeqPath.h"

using namespace cinder;
using namespace gl;

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
            cinder::Color(0.95, 0.95, 0.95),
            cinder::Color(0.95, 0.95, 0.95),
            cinder::Color(0.95, 0.95, 0.95),
            20.0f,
            cinder::Color(20, 20, 20)
);

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

ShAvatar::ShAvatar(std::string userName, cinder::Vec3f pos, int id) :
    mUserName(userName),
    mPos(pos),
    mID(id)
{
    mCubeSize = cinder::Vec3f(25, 25, 25);
    nameTextureGenerated = false;
}

void ShAvatar::setPos(cinder::Vec3f pos)
{
    boost::shared_lock<boost::shared_mutex> lock(mMutex);
    mPos = pos;
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
    ShGlobals::DATA->queueAvatarPosition(mUserName, mPos, mRot);
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
    glPushMatrix();

    cinder::gl::translate(mPos);
    cinder::gl::rotate(mRot);
    cinder::gl::draw(ShAvatar::mesh);

    /*
    cinder::gl::Light light(cinder::gl::Light::POINT, 1 + mID);
    light.setAmbient(Color(0.5f, 0.5f, 0.5f));
    light.setDiffuse(cinder::Color::white());
    light.setSpecular(cinder::Color::white());
    light.setPosition(cinder::Vec3f::zero());*/

    glPopMatrix();
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

// System includes
#include <cmath>

// libsc++ includes
#include "Node.h"

// Shoggoth includes
#include "ShSnakeRange.h"
#include "src/Graphics/ShIsland.h"
#include "src/Graphics/shaders.h"
#include "src/Graphics/ShColor.h"
#include "src/ShGlobals.h"

using namespace std;
using namespace sc;

ShSnakeRange::ShSnakeRange(snake_range_id_t id, string synthName, cinder::Vec2i corner1, cinder::Vec2i corner2, cinder::Color color,
                           ShIsland *island, bool queueChange) :
    id(id),
    size(size),
    color(color),
    island(island),
    minHeight(0),
    maxHeight(0),
    synthName(synthName),
    beatPointer(0),
    synthNameTexture(0),
    synth(synthName, sc::ARGS("bufnum", island->getWaveTerrainBufferNumber()), 1)
{
    boost::upgrade_lock<boost::shared_mutex> lock(mutex);
    boost::upgrade_to_unique_lock<boost::shared_mutex> writeLock(lock);

    islandPosition = island->getPos();
    islandID = island->mID;

    if(corner1.x % 2 == 1)
        corner1.x -= 1;
    if(corner1.y % 2 == 1)
        corner1.y -= 1;

    if(corner2.x % 2 == 1)
        corner2.x -= 1;
    if(corner2.y % 2 == 1)
        corner2.y -= 1;

    this->corner1 = corner1;
    this->corner2 = corner2;

    fourCorners.resize(4, cinder::Vec3f::zero());
    corners.resize(4, cinder::Vec2i::zero());
    meshPositions.resize(vertexCount, cinder::Vec3f::zero());
    resetPositionAndSize();

    if(queueChange)
    {
        changeQueued = true;
    }

    else
    {
        changeQueued = false;
        populateRangeVector(true);
    }
}

ShSnakeRange::~ShSnakeRange()
{
    boost::upgrade_lock<boost::shared_mutex> lock(mutex);
    boost::upgrade_to_unique_lock<boost::shared_mutex> writeLock(lock);

    if(synthNameTexture)
        delete synthNameTexture;
}

void ShSnakeRange::increment()
{
    boost::upgrade_lock<boost::shared_mutex> lock(mutex);
    boost::upgrade_to_unique_lock<boost::shared_mutex> writeLock(lock);

    if(rangeVector.size() > 0)
    {
        beatPointer = (beatPointer + 1) % rangeVector.size();

        GridTri* tri = rangeVector[beatPointer];

        if(tri->getValue())
        {
            cinder::Vec3f centroid = tri->getCentroid();

            node_arg_list argList;
            argList.push_back(arg_pair("x", centroid.x - islandPosition.x));
            argList.push_back(arg_pair("y", centroid.y));
            argList.push_back(arg_pair("z", centroid.z - islandPosition.z));
            argList.push_back(arg_pair("island", islandID));
            synth.trigger(argList);

            /*
            Synth::grain(
                synthName.c_str(),
                argList
            );*/
        }
    }
}

void ShSnakeRange::draw(bool drawActive)
{
    boost::upgrade_lock<boost::shared_mutex> lock(mutex);
    boost::upgrade_to_unique_lock<boost::shared_mutex> writeLock(lock);

    if(island->isAnimating())
    {
        minAndMaxHeights();
        rebuildPositions();
        bufferPositions();
        //populateRangeVector(false);
    }

    if(changeQueued)
    {
        resetPositionAndSize();
        populateRangeVector(true);
        changeQueued = false;
    }

    if(mesh.getNumIndices() > 0)
    {
        // Draw range
        cinder::gl::draw(mesh);

        if(beatPointer < rangeVector.size() && drawActive)
        {
            // Draw current beat
            cinder::Vec3f bottomTri0 = rangeVector[beatPointer]->getv0();
            cinder::Vec3f bottomTri1 = rangeVector[beatPointer]->getv1();
            cinder::Vec3f bottomTri2 = rangeVector[beatPointer]->getv2();

            cinder::Vec3f topTri0 = rangeVector[beatPointer]->getv0();
            cinder::Vec3f topTri1 = rangeVector[beatPointer]->getv1();
            cinder::Vec3f topTri2 = rangeVector[beatPointer]->getv2();

            if(rangeVector[beatPointer]->getValue())
            {
                cinder::gl::color(color * 4);
                topTri0.y = maxHeight + 5;
                topTri1.y = maxHeight + 5;
                topTri2.y = maxHeight + 5;
            }

            else
            {
                topTri0.y = maxHeight;
                topTri1.y = maxHeight;
                topTri2.y = maxHeight;
            }



            glBegin(GL_TRIANGLES);
            // Bottom
            glVertex3f(bottomTri0.x, bottomTri0.y + 1, bottomTri0.z);
            glVertex3f(bottomTri1.x, bottomTri1.y + 1, bottomTri1.z);
            glVertex3f(bottomTri2.x, bottomTri2.y + 1, bottomTri2.z);
            // Top
            glVertex3f(topTri0.x, topTri0.y, topTri0.z);
            glVertex3f(topTri1.x, topTri1.y, topTri1.z);
            glVertex3f(topTri2.x, topTri2.y, topTri2.z);

            // Side1 bottom
            glVertex3f(bottomTri1.x, bottomTri1.y, bottomTri1.z);
            glVertex3f(bottomTri2.x, bottomTri2.y, bottomTri2.z);
            glVertex3f(topTri2.x, topTri2.y, topTri2.z);
            // Side1 top
            glVertex3f(topTri1.x, topTri1.y, topTri1.z);
            glVertex3f(bottomTri1.x, bottomTri1.y, bottomTri1.z);
            glVertex3f(topTri2.x, topTri2.y, topTri2.z);
            // Side2 bottom
            glVertex3f(bottomTri2.x, bottomTri2.y, bottomTri2.z);
            glVertex3f(bottomTri0.x, bottomTri0.y, bottomTri0.z);
            glVertex3f(topTri0.x, topTri0.y, topTri0.z);
            // Side2 top
            glVertex3f(topTri2.x, topTri2.y, topTri2.z);
            glVertex3f(bottomTri2.x, bottomTri2.y, bottomTri2.z);
            glVertex3f(topTri0.x, topTri0.y, topTri0.z);
            // Side3 bottom
            glVertex3f(bottomTri0.x, bottomTri0.y, bottomTri0.z);
            glVertex3f(bottomTri1.x, bottomTri1.y, bottomTri1.z);
            glVertex3f(topTri1.x, topTri1.y, topTri1.z);
            // Side3 top
            glVertex3f(topTri0.x, topTri0.y, topTri0.z);
            glVertex3f(bottomTri0.x, bottomTri0.y, bottomTri0.z);
            glVertex3f(topTri1.x, topTri1.y, topTri1.z);
            glEnd();
        }
    }
}

void ShSnakeRange::drawHighlight()
{
    boost::upgrade_lock<boost::shared_mutex> lock(mutex);

    cinder::gl::color(color * 10);

    glBegin(GL_LINE_LOOP);
    glVertex3f(fourCorners[0].x, maxHeight, fourCorners[0].z);
    glVertex3f(fourCorners[1].x, maxHeight, fourCorners[1].z);
    glVertex3f(fourCorners[2].x, maxHeight, fourCorners[2].z);
    glVertex3f(fourCorners[3].x, maxHeight, fourCorners[3].z);
    glEnd();

    glBegin(GL_LINES);
    glVertex3f(fourCorners[0].x, maxHeight, fourCorners[0].z);
    glVertex3f(fourCorners[0].x, minHeight, fourCorners[0].z);
    glVertex3f(fourCorners[1].x, maxHeight, fourCorners[1].z);
    glVertex3f(fourCorners[1].x, minHeight, fourCorners[1].z);
    glVertex3f(fourCorners[2].x, maxHeight, fourCorners[2].z);
    glVertex3f(fourCorners[2].x, minHeight, fourCorners[2].z);
    glVertex3f(fourCorners[3].x, maxHeight, fourCorners[2].z);
    glVertex3f(fourCorners[3].x, minHeight, fourCorners[2].z);
    glEnd();
}

void ShSnakeRange::drawName()
{
    boost::upgrade_lock<boost::shared_mutex> lock(mutex);

    if(synthNameTexture)
    {
        cinder::Vec3f pos = rangeVector[0]->getCentroid();
        pos.y = maxHeight;
        cinder::gl::color(cinder::Color::white());

        cinder::Vec2f texturePos = ShGlobals::CAMERA->getCam().worldToScreen(
                    pos,
                    ShGlobals::SCREEN_SIZE.x,
                    ShGlobals::SCREEN_SIZE.y
        );

        if(texturePos.x > 0 && texturePos.y > 0)
        {
            cinder::gl::draw(*synthNameTexture, texturePos);
        }
    }

    else
    {
        boost::upgrade_to_unique_lock<boost::shared_mutex> writeLock(lock);
        createSynthNameTexture();
    }
}

void ShSnakeRange::move(cinder::Vec2i position, bool queueChange)
{
    boost::upgrade_lock<boost::shared_mutex> lock(mutex);
    boost::upgrade_to_unique_lock<boost::shared_mutex> writeLock(lock);

    if(corner1.x > corner2.x)
    {
        if(position.x % 2 != 0)
            position.x += 1;

        if(position.x == corner2.x)
            position.x = corner2.x + 2;
    }

    else if(corner1.x < corner2.x)
    {
        if(position.x % 2 != 0)
            position.x -= 1;

        if(position.x == corner2.x)
            position.x = corner2.x - 2;
    }

    if(corner1.y > corner2.y)
    {
        if(position.y % 2 != 0)
            position.y += 1;

        if(position.y == corner2.y)
            position.y = corner2.y - 1;
    }

    else if(corner1.y < corner2.y)
    {
        if(position.y % 2 != 0)
            position.y -= 1;

        if(position.y == corner2.y)
            position.y = corner2.y + 1;
    }


    position = cinder::Vec2i(
                max(0, min(ShIsland::kTriangleGridWidth - 1 - size.x, position.x)),
                max(0, min(ShIsland::kTriangleGridHeight - 1 - size.y, position.y))
    );

    cinder::Vec2i difference = position - corner1;

    corner1 += difference;
    corner2 += difference;

    if(queueChange)
    {
        changeQueued = true;
    }

    else
    {
        resetPositionAndSize();
        populateRangeVector(true); // Rebuild from scratch
    }
}

void ShSnakeRange::setCorner1(cinder::Vec2i newCorner)
{
    boost::upgrade_lock<boost::shared_mutex> lock(mutex);
    boost::upgrade_to_unique_lock<boost::shared_mutex> writeLock(lock);

    if(corner1.x > corner2.x)
    {
        if(newCorner.x % 2 != 0)
            newCorner.x += 1;

        if(newCorner.x == corner2.x)
            newCorner.x = corner2.x + 2;
    }

    else if(corner1.x < corner2.x)
    {
        if(newCorner.x % 2 != 0)
            newCorner.x -= 1;

        if(newCorner.x == corner2.x)
            newCorner.x = corner2.x - 2;
    }

    if(corner1.y > corner2.y)
    {
        if(newCorner.y % 2 != 0)
            newCorner.y += 1;

        if(newCorner.y == corner2.y)
            newCorner.y = corner2.y - 1;
    }

    else if(corner1.y < corner2.y)
    {
        if(newCorner.y % 2 != 0)
            newCorner.y -= 1;

        if(newCorner.y == corner2.y)
            newCorner.y = corner2.y + 1;
    }


    corner1 = cinder::Vec2i(
                max(0, min(ShIsland::kTriangleGridWidth - 1, newCorner.x)),
                max(0, min(ShIsland::kTriangleGridHeight - 1, newCorner.y))
    );

    resetPositionAndSize();
    populateRangeVector(true); // Rebuild from scratch
}

void ShSnakeRange::setCorner2(cinder::Vec2i newCorner, bool queueChange)
{
    boost::upgrade_lock<boost::shared_mutex> lock(mutex);
    boost::upgrade_to_unique_lock<boost::shared_mutex> writeLock(lock);

    if(corner2.x > corner1.x)
    {
        if(newCorner.x % 2 != 0)
            newCorner.x += 1;

        if(newCorner.x == corner1.x)
            newCorner.x = corner1.x + 2;
    }

    else if(corner2.x < corner1.x)
    {
        if(newCorner.x % 2 != 0)
            newCorner.x -= 1;

        if(newCorner.x == corner1.x)
            newCorner.x = corner1.x - 2;
    }

    if(corner2.y > corner1.y)
    {
        if(newCorner.y % 2 != 0)
            newCorner.y += 1;

        if(newCorner.y == corner1.y)
            newCorner.y = corner1.y - 1;
    }

    else if(corner2.y < corner1.y)
    {
        if(newCorner.y % 2 != 0)
            newCorner.y -= 1;

        if(newCorner.y == corner1.y)
            newCorner.y = corner1.y + 1;
    }

    corner2 = cinder::Vec2i(
                max(0, min(ShIsland::kTriangleGridWidth - 1, newCorner.x)),
                max(0, min(ShIsland::kTriangleGridHeight - 1, newCorner.y))
    );

    if(queueChange)
    {
        changeQueued = true;
    }

    else
    {
        resetPositionAndSize();
        populateRangeVector(true); // Rebuild from scratch
    }
}

void ShSnakeRange::updateMesh()
{
    boost::upgrade_lock<boost::shared_mutex> lock(mutex);
    boost::upgrade_to_unique_lock<boost::shared_mutex> writeLock(lock);
    populateRangeVector(true);
}

std::string ShSnakeRange::getSynthName()
{
    boost::upgrade_lock<boost::shared_mutex> lock(mutex);
    return synthName;
}

cinder::Vec2i ShSnakeRange::getCorner1()
{
    boost::upgrade_lock<boost::shared_mutex> lock(mutex);
    return corner1;
}

cinder::Vec2i ShSnakeRange::getCorner2()
{
    boost::upgrade_lock<boost::shared_mutex> lock(mutex);
    return corner2;
}

cinder::Color ShSnakeRange::getColor()
{
    boost::upgrade_lock<boost::shared_mutex> lock(mutex);
    return color;
}

ShIsland* ShSnakeRange::getIsland()
{
    boost::upgrade_lock<boost::shared_mutex> lock(mutex);
    return island;
}

cinder::Vec2i ShSnakeRange::getPosition()
{
    boost::upgrade_lock<boost::shared_mutex> lock(mutex);
    return position;
}

cinder::Vec2i ShSnakeRange::getSize()
{
    boost::upgrade_lock<boost::shared_mutex> lock(mutex);
    return size;
}

GridTri* ShSnakeRange::getTri(int rangeCursor)
{
    boost::upgrade_lock<boost::shared_mutex> lock(mutex);
    return rangeVector[rangeCursor];
}

std::vector<GridTri*>& ShSnakeRange::getRangeVector()
{
    boost::upgrade_lock<boost::shared_mutex> lock(mutex);
    return rangeVector;
}

snake_range_id_t ShSnakeRange::getID()
{
    boost::upgrade_lock<boost::shared_mutex> lock(mutex);
    return id;
}

void ShSnakeRange::populateRangeVector(bool rebuildMesh)
{
    // Populate the range vector using a looping gather: right, down, left, up
    rangeVector.clear();

    // Right
    for(int i = 0; i < size.x; ++i)
    {
        rangeVector.push_back(island->getTriPointer(position.x + i, position.y));
    }

    fourCorners[0] = rangeVector.front()->getv1(); // Populate first corner
    fourCorners[1] = rangeVector.back()->getv2(); // Populate second corner

    // Down
    for(int i = 1; i < size.y; ++i)
    {
        rangeVector.push_back(island->getTriPointer(position.x + size.x - 1, position.y + i));
    }

    fourCorners[2] = rangeVector.back()->getv1(); // Populate thid corner

    // Left
    for(int i = size.x - 2; i >= 0; --i)
    {
        rangeVector.push_back(island->getTriPointer(position.x + i, position.y + size.y - 1));
    }

    fourCorners[3] = rangeVector.back()->getv2(); // Populate fourth corner

    // Up
    for(int i = size.y - 2; i > 0; --i)
    {
        rangeVector.push_back(island->getTriPointer(position.x, position.y + i));
    }

    minAndMaxHeights();

    rebuildPositions();

    if(rebuildMesh)
    {
        createMesh();
    }

    bufferPositions();
}

void ShSnakeRange::minAndMaxHeights()
{
    if(rangeVector.size() > 0)
    {
        minHeight = rangeVector.at(0)->getv0().y;
        maxHeight = minHeight;

        // Find min/max height
        for(int i = 0; i < rangeVector.size(); ++i)
        {
            for(int j = 0; j < 3; ++j)
            {
                if(rangeVector.at(i)->operator [](j).y < minHeight)
                    minHeight = rangeVector.at(i)->operator [](j).y;

                if(rangeVector.at(i)->operator [](j).y > maxHeight)
                    maxHeight = rangeVector.at(i)->operator [](j).y;
            }
        }

        maxHeight += 10.0;
    }
}

void ShSnakeRange::createMesh()
{
    cinder::gl::VboMesh::Layout layout;
    layout.setStaticIndices();
    layout.setStaticColorsRGB();
    layout.setStaticPositions();
    layout.addDynamicCustomVec4f();

    mesh = cinder::gl::VboMesh(vertexCount, vertexCount, layout, GL_TRIANGLE_STRIP);

    std::vector<uint32_t> meshIndices;

    for(int i = 0; i < vertexCount; i++)
    {
        meshIndices.push_back(i);
    }

    mesh.bufferIndices(meshIndices);

    std::vector<cinder::Color> meshColors;

    for(int i = 0; i < vertexCount; ++i)
    {
        meshColors.push_back(color);
    }

    mesh.bufferColorsRGB(meshColors);

    // populate custom picking data
    cinder::gl::VboMesh::VertexIter meshIter = mesh.mapVertexBuffer();

    for(int i = 0; i < meshPositions.size(); ++i)
    {
        meshIter.setCustomVec4f(0, shcolor::intToVec4f(id.second));
        ++meshIter;
    }

    // Bind custom picking data
    ShShaders::bindPicking();
    mesh.setCustomDynamicLocation(0, ShShaders::pickingAttrib);
    ShShaders::unbindPicking();
}

void ShSnakeRange::rebuildPositions()
{
    // Build a wall using a triangle strip winding
    // We alternate heights between min/max heights while moving around the four corners

    for(int i = 0; i < fourCorners.size(); ++i)
    {
        cinder::Vec3f high = fourCorners[i];
        cinder::Vec3f low = high;
        high.y = maxHeight;
        low.y = minHeight;

        meshPositions[i * 2] = high;
        meshPositions[(i * 2) + 1] = low;
    }

    // Finish by completing the wall with the initial 2 points
    meshPositions[8] = meshPositions[0];
    meshPositions[9] = meshPositions[1];
}

void ShSnakeRange::bufferPositions()
{
    mesh.bufferPositions(meshPositions);
}

void ShSnakeRange::resetPositionAndSize()
{
    corner3 = cinder::Vec2i(corner1.x, corner2.y);
    corner4 = cinder::Vec2i(corner2.x, corner1.y);

    corners[0] = corner1;
    corners[1] = corner2;
    corners[2] = corner3;
    corners[3] = corner4;

    cinder::Vec2i minCorner = corner1;
    cinder::Vec2i maxCorner = corner1;

    for(int i = 0; i < 4; ++i)
    {
        if(corners[i].x < minCorner.x)
            minCorner.x = corners[i].x;
        if(corners[i].y < minCorner.y)
            minCorner.y = corners[i].y;

        if(corners[i].x > maxCorner.x)
            maxCorner.x = corners[i].x;
        if(corners[i].y > maxCorner.y)
            maxCorner.y = corners[i].y;
    }

    position = minCorner;
    size = maxCorner - minCorner;
}

void ShSnakeRange::createSynthNameTexture()
{
    try {
        cinder::TextLayout layout;
        layout.clear(cinder::ColorA(1, 1, 1, 0.5));
        layout.setColor(cinder::Color::black());
        layout.setFont(ShGlobals::FONT);
        layout.addLine(synthName);

        cinder::Surface8u rendered = layout.render(true);

        synthNameTexture = new cinder::gl::Texture(rendered);
    }

    catch(...)
    {
        synthNameTexture =  new cinder::gl::Texture();
    }
}

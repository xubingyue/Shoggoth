/*
 *  ShIsland.cpp
 *  Shoggoth
 *
 *  Created by Chad McKinney on 1/17/12.
 *
 */

// System includes
#include <iostream>
#include <cmath>
#include <stdlib.h>
#include <time.h>

// Local includes
#include "src/shmath.h"
#include "src/Graphics/ShIsland.h"
#include "cinder/Color.h"
#include "cinder/Timer.h"
#include "src/Graphics/ShSeqPath.h"
#include "src/Graphics/ShColor.h"
//#include "include/ShTriangleGrid.h"
#include "src/ShGlobals.h"
#include "Buffer.h"

#include "src/Graphics/shaders.h"
using namespace ShShaders;

using namespace ci;
using namespace gl;

uint16_t ShIsland::kTriGridWidth = kGridWidth * 2;
uint16_t ShIsland::kTriGridHeight = ShIsland::kGridDepth;
Material ShIsland::material = Material(Color(0.6, 0.6, 0.6), Color(0.6f, 0.6f, 0.6f), Color(0.5, 0.5, 0.5), 0.75);
uint32_t ShIsland::globalPickingIndex = 0;

ShIsland::ShIsland(Vec3f pos, int id, Vec2i coord) :
	mPos(pos),
	mID(id),
	mCoord(coord),
    mTerrain(1, kGridWidth + 1, kGridDepth + 1, 0, 999),
    scheduleBufferColors(false),
    scheduleBufferPositions(false),
    waveTerrainBuffer(0)
{   
	//mVertexCount = rand() % 9000;
	//mTriCount = mVertexCount/3;
	mVertexCount = 0;
	mTriCount = 0;
	mRandColor = rand() % 6;
	mDetail = High;

    mStepGen = std::make_pair(ShNetwork::Empty, 0);
    mTerrainGen = std::make_pair(ShNetwork::Empty, 0);
	
	for(int x = 0; x < kTriangleGridWidth; ++x)
	{
		for(int y = 0; y < kTriangleGridHeight; ++y)
		{
			triangleGrid[x][y] = NULL;
		}
	}

    //mTerrain.shiftAboveZero();
    //mTerrain.normalize(ShIsland::kGridSize * 1000000);
    mMinHeight = 0;
    mMaxHeight = 1;

    /*
    for(int y = 0; y < mTerrain.getHeight(); ++y)
    {
        for(int x = 0; x < mTerrain.getWidth(); ++x)
        {
            ShHeight value = mTerrain.getValue(x, y);
            if(value < mMinHeight)
                mMinHeight = value;
            else if(value > mMaxHeight)
                mMaxHeight = value;
        }
    }*/

    for(int x = 0; x < kGridWidth + 1; ++x)
    {
        mTerrainHeightMap.push_back(std::vector<float>());
        for(int y = 0; y < kGridDepth + 1; ++y)
        {
            mTerrainHeightMap[x].push_back(0.0);
        }
    }
}

ShIsland::~ShIsland()
{
	mSurface.unbindBuffers();
    deleteTriangleGrid();
	
	//delete[] mDiffuseMaterial;
	//delete[] mMatSpecular;
}

void ShIsland::setup(cinder::Vec3f cameraPos)
{
    // boost::upgrade_lock<boost::shared_mutex> lock(mMutex);
    // boost::upgrade_to_unique_lock<boost::shared_mutex> writeLock(lock);

	//mPos = Vec3f(rand() % 32000, 0, rand() % 32000);
	//mPos = Vec3f(mID * 600, 0, 0);
	//mPos = Vec3f(-6000, -6000, -6000);
	/*
	mDiffuseMaterial = new GLfloat[4];
	mDiffuseMaterial[0] = 1.0f;
	mDiffuseMaterial[1] = 1.0f;
	mDiffuseMaterial[2] = 1.0f;
	mDiffuseMaterial[3] = 1.0f;
	
	mMatSpecular = new GLfloat[4];
	mMatSpecular[0] = 1.1f;
	mMatSpecular[1] = 1.1f;
	mMatSpecular[2] = 1.1f;
	mMatSpecular[3] = 1.1f;
	
	glMaterialf(GL_FRONT_AND_BACK, GL_DIFFUSE, *mDiffuseMaterial);
	glMaterialf(GL_FRONT_AND_BACK, GL_SPECULAR, *mMatSpecular);
	glMaterialf(GL_FRONT_AND_BACK, GL_SHININESS, 100.0f);
	glColorMaterial(GL_FRONT_AND_BACK, GL_DIFFUSE);
	*/
	createTerrainMesh(TriangleFill);
	mBoundingBox = calcBoundingBox();
	setDetail(cameraPos);
}

void ShIsland::moveTo(Vec3f pos)
{
    // boost::upgrade_lock<boost::shared_mutex> lock(mMutex);
    // boost::upgrade_to_unique_lock<boost::shared_mutex> writeLock(lock);

	gl::VboMesh::VertexIter iter = mSurface.mapVertexBuffer();
	for(int idx = 0; idx < mVertexCount; ++idx)
	{
		//iter.setPosition(Vec3f((idx + 1) * 10, (idx + 1) * 10, (idx + 1) * 10));
	}
	
}

void ShIsland::update()
{
    // boost::upgrade_lock<boost::shared_mutex> lock(mMutex);
    // boost::upgrade_to_unique_lock<boost::shared_mutex> writeLock(lock);

    if(scheduleBufferColors)
    {
        bufferActivityColor();
        scheduleBufferColors = false;
    }

    if(scheduleBufferPositions)
    {
        /*
        mPositions.clear();
        fillPositionsVector(mPositions);
        calculateMinMax(mPositions);
        deleteTriangleGrid();
        buildTriangleGrid();
        mBoundingBox = calcBoundingBox();*/

        mSurface.bufferPositions(mPositions);
        calculateNormals(mSurface, mPositions);
        bufferActivityColor();

        scheduleBufferPositions = false;
    }

    if(mAnimationQueue.size() > 0)
    {

        mTerrainHeightMap = mAnimationQueue.front().get<HeightMap>();
        mMinHeight = mAnimationQueue.front().get<MinHeight>();
        mMaxHeight = mAnimationQueue.front().get<MaxHeight>();

        mPositions.clear();
        fillPositionsVector(mPositions);
        calculateMinMax(mPositions);
        rebuildTriangleGrid();
        mBoundingBox = calcBoundingBox();

        mSurface.bufferPositions(mPositions);
        calculateNormals(mSurface, mPositions);
        bufferActivityColor();
        updateWaveTerrainBuffer(mTerrainHeightMap, mMinHeight, mMaxHeight);
        synchronizedAnimationQueuePop();
    }
}

void ShIsland::draw()
{	
    // boost::shared_lock<boost::shared_mutex> lock(mMutex);

	switch(mDetail) 
	{
		case High:
			gl::draw(mSurface);
			break;
			
		case Medium:
			gl::draw(mSurfaceMediumDetail);
			break;
			
		case MediumLow:
			gl::draw(mSurfaceMediumLowDetail);
			break;
			
		case Low:
			gl::draw(mSurfaceLowDetail);
			break;
	}

    /*
    for(int y = 0; y < kTriangleGridHeight; ++y)
    {
        for(int x = 0; x < kTriangleGridWidth; ++x)
        {
            triangleGrid[x][y]->draw();
        }
    }*/
}

bool ShIsland::isAnimating()
{
    // boost::upgrade_lock<boost::shared_mutex> lock(mMutex);
    return mAnimationQueue.size() > 0;
}

Vec3f ShIsland::getPos()
{
    // boost::upgrade_lock<boost::shared_mutex> lock(mMutex);
	return mPos;
}

void ShIsland::createIsland(Vec3f pos)
{
    // boost::upgrade_lock<boost::shared_mutex> lock(mMutex);
    // boost::upgrade_to_unique_lock<boost::shared_mutex> writeLock(lock);

	VboMesh::Layout layout;
	layout.setDynamicIndices();
	layout.setDynamicColorsRGBA();
	layout.setDynamicPositions();
	//layout.setStaticPositions();
	
	
	// Lets try some fractal stuff!! Strange Attractors? Julian Sets? Mandelbulb? Cellular Automata (everyone does this :/) something new?
	
	//mMesh = VboMesh(mVertexCount, mTriCount * 3, layout, GL_TRIANGLE_FAN);
	//mMesh = VboMesh(mVertexCount, mTriCount * 3, layout, GL_LINE_STRIP);
	mSurface = VboMesh(mVertexCount, mTriCount * 3, layout, GL_TRIANGLE_STRIP);
	//mMesh = VboMesh(mVertexCount, mTriCount * 3, layout, GL_QUADS);
	//mMesh = VboMesh(mVertexCount, mTriCount * 3, layout, GL_TRIANGLES);
	//mMesh = VboMesh(mVertexCount, mVertexCount, layout, GL_QUAD_STRIP);
	//mMesh = VboMesh(mVertexCount, mTriCount * 3, layout, GL_POINTS);
	
	//glBegin(LINE_LOOP)
	
	std::vector<uint32_t> indices;
	
	for(int i = 0; i < mVertexCount; i++)
	{
		indices.push_back(i);
	}
	
	mSurface.bufferIndices(indices);
	Vec3f lastPos = Vec3f((rand() % 30) * 10, (rand() % 30) * 10, (rand() % 30) * 10);
	//Vec3f turn = Vec3f((rand() % 2), (rand() % 2), (rand() % 2));

	
	// STRANGE ATTRACTOR CODE
	
	//Vec3f lastPos = Vec3f(1000, 1000, 1000);
	
	float a, b, c, d;
	a = 2.24;
	b = 0.43;
	c = -0.65;
	d = -2.43;
	
	// Initialize position
	for(int i = 0; i < 1000; ++i)
	{
		float xnew = sin(a*lastPos.y) - lastPos.z*cos(b*lastPos.x);
		float ynew = lastPos.z*sin(c*lastPos.x) - cos(d*lastPos.y);
		float znew = sin(lastPos.x);
		
		lastPos = Vec3f(xnew, ynew, znew);
	}
	
	// Begin adding new positionas
	for(int i = 0; i < mVertexCount; ++i)
	{
		lastPos += Vec3f((rand() % 200) - 100, (rand() % 200) - 100, (rand() % 200) - 100);
		lastPos += Vec3f(((rand() % 15) * 10) - 75, ((rand() % 15) * 10) - 75, ((rand() % 15) * 10) - 75);
		/*
		float xnew = sin(a*lastPos.y) - lastPos.z*cos(b*lastPos.x);
		float ynew = lastPos.z*sin(c*lastPos.x) - cos(d*lastPos.y);
		float znew = sin(lastPos.x);
		
		lastPos = Vec3f(xnew, ynew, znew);*/
		
		mPositions.push_back(lastPos);
	}
	
	
	for(int i = 0; i < mPositions.size(); ++i)
	{
		mPositions[i] += pos;
	}
	
	// now we can buffer positions
	mSurface.bufferPositions(mPositions);
	mSurface.unbindBuffers();
	
	float sinWave;
	
	VboMesh::VertexIter iter = mSurface.mapVertexBuffer();
	for(int x = 0; x < mVertexCount; ++x)
	{
		sinWave = (float) ((sin(mID) + 1)/2.5)+0.2;
        iter.setColorRGBA(ColorA(0.1f, 0.1f, 0.1f, sinWave));
		++iter;
	}
}



void ShIsland::createCube(int size, Vec3f pos)
{
    // boost::upgrade_lock<boost::shared_mutex> lock(mMutex);
    // boost::upgrade_to_unique_lock<boost::shared_mutex> writeLock(lock);

	//mLayout.setStaticIndices();
	VboMesh::Layout layout;
	//layout.setStaticIndices();
	layout.setDynamicIndices();
	//layout.setDynamicColorsRGB();
	layout.setDynamicColorsRGBA();
	//layout.setDynamicPositions();
	layout.setStaticPositions();
	
	//mSurface = VboMesh(mVertexCount, mTriCount * 3, layout, GL_TRIANGLES);
	mSurface = VboMesh(mVertexCount, mTriCount * 4, layout, GL_QUADS);
	
	std::vector<uint32_t> indices;
	
	for(int i = 0; i < mVertexCount; i++)
	{
		indices.push_back(i);
	}
	
	mSurface.bufferIndices(indices);
	mPositions.push_back(Vec3f(size, size * 2, 1));
	mPositions.push_back(Vec3f( size * 2, size * 2, 1));
	mPositions.push_back(Vec3f( size * 2, size, 1));
	mPositions.push_back(Vec3f(size, size, 1));
	mPositions.push_back(Vec3f( size * 2, size * 2, 1));
	mPositions.push_back(Vec3f( size * 2, size * 2, size));
	mPositions.push_back(Vec3f( size * 2, size, size));
	mPositions.push_back(Vec3f( size * 2, size, 1));
	mPositions.push_back(Vec3f( size * 2, size * 2, size));
	mPositions.push_back(Vec3f(size, size * 2, size));
	mPositions.push_back(Vec3f(size, size, size));
	mPositions.push_back(Vec3f( size * 2, size, size));
	mPositions.push_back(Vec3f(size, size * 2, size));
	mPositions.push_back(Vec3f(size, size * 2, 1));
	mPositions.push_back(Vec3f(size, size, 1));
	mPositions.push_back(Vec3f(size, size, size));
	mPositions.push_back(Vec3f(size, size * 2, size));
	mPositions.push_back(Vec3f( size * 2, size * 2, size));
	mPositions.push_back(Vec3f( size * 2, size * 2, 1));
	mPositions.push_back(Vec3f(size, size * 2, 1));
	mPositions.push_back(Vec3f(size, size, size));
	mPositions.push_back(Vec3f( size * 2, size, size));
	mPositions.push_back(Vec3f( size * 2, size, 1));
	mPositions.push_back(Vec3f(size, size, 1));
	
	for(int i = 0; i < mPositions.size(); ++i)
	{
		mPositions[i] += pos;
	}
	
	// now we can buffer positions
	mSurface.bufferPositions(mPositions);
	mSurface.unbindBuffers();
	
	float sinWave;
	
	VboMesh::VertexIter iter = mSurface.mapVertexBuffer();
	for(int x = 0; x < mVertexCount; ++x)
	{
		sinWave = (float) ((sin(mID) + 1)/2.5)+0.1;
        iter.setColorRGBA(ColorA(0.1f, 0.1f, 0.1f, sinWave));
		//float shade = (float) ((sin(mID) + 1)/2.5)+0.1;
		//iter.setColorRGB(Color(shade, shade, shade));
		++iter;
	}
}

void ShIsland::addMeshIndex(std::vector<cinder::Vec3f>& positionVector, int x, int y)
{   
    //float height = (mTerrain.getValue(x, y) / 25) * kGridSize;
    //float height = (mTerrainHeightMap[x][y] / 25) * kGridSize;
    float height = mTerrainHeightMap[x][y];

    if(x == 0 || x == mTerrain.getWidth() - 1 || y == 0 || y == mTerrain.getHeight() -1)
        height = mMinHeight;
        //height = (mMinHeight / 25) * kGridSize;

    positionVector.push_back(Vec3f(x * kGridSize, height, y * kGridSize) + mPos);
}

void ShIsland::createTerrainMesh(DrawStyle style)
{
    mSurface = createLODMesh(style, kHighDetailStep, mPositions);
    //mSurfaceMediumDetail    = createLODMesh(style, kMediumDetailStep,    mMediumDetailPositions   );
    //mSurfaceMediumLowDetail = createLODMesh(style, kMediumLowDetailStep, mMediumLowDetailPositions);
    //mSurfaceLowDetail       = createLODMesh(style, kLowDetailStep,       mLowDetailPositions      );
	
	//float offset = (kGridSize * (kGridWidth / 2));
	//mCenterPos = mPos + Vec3f(offset, 0, offset);
	mCenterPos = mPositions[mPositions.size() / 2];
	buildTriangleGrid();
}

void ShIsland::fillPositionsVector(std::vector<cinder::Vec3f>& positionVector)
{
    ShCoord y = 0;
    ShCoord x = 0;
    bool even;
    bool doneIterating = false;
    unsigned char stepSize = 1;
    ShSize width = kGridWidth / stepSize;
    ShSize height = kGridDepth / stepSize;

    even = true;
    while(!doneIterating)
    {
        if(even)
        {
            x += 1;
            addMeshIndex(positionVector, x * stepSize, y * stepSize);
            x -= 1;
            addMeshIndex(positionVector, x * stepSize, y * stepSize);
            y +=1;
            addMeshIndex(positionVector, x * stepSize, y * stepSize);
            even = false;

            /*
            addMeshIndex(positionVector, x * stepSize, y * stepSize);
            y += 1;
            addMeshIndex(positionVector, x * stepSize, y * stepSize);
            x += 1;
            y -= 1;
            addMeshIndex(positionVector, x * stepSize, y * stepSize);*/
        }

        else
        {
            /*
            x -= 1;
            y += 1;
            addMeshIndex(positionVector, x * stepSize, y * stepSize);
            x += 1;
            addMeshIndex(positionVector, x * stepSize, y * stepSize);
            y -= 1;
            addMeshIndex(positionVector, x * stepSize, y * stepSize);*/


            addMeshIndex(positionVector, x * stepSize, y * stepSize);
            x += 1;
            addMeshIndex(positionVector, x * stepSize, y * stepSize);
            y -= 1;
            addMeshIndex(positionVector, x * stepSize, y * stepSize);
            even = true;

            // we check to see that we're done by testing x/y against width/height
            if((x == width) && (y == height - 1))
            {
                doneIterating = true;
            }

            else if(x == width)
            {
                // New row
                x = 0;
                y += 1;
            }
        }

    }
}

void ShIsland::calculateMinMax(std::vector<cinder::Vec3f>& positionVector)
{
    mMinHeight = 0;
    mMaxX = positionVector[0].x;
    mMaxZ = positionVector[0].z;

    for(int i = 0; i < positionVector.size(); ++i)
    {
        if(positionVector[i].y < mMinHeight)
            mMinHeight = positionVector[i].y;
    }

    mMaxHeight = 1;
    for(int i = 0; i < positionVector.size(); ++i)
    {
        positionVector[i] += mPos;
        //positionVector[i] += mPos + Vec3f(0, (mMinHeight * -1), 0);
        if(positionVector[i].y > mMaxHeight)
            mMaxHeight = positionVector[i].y;

        if(positionVector[i].x > mMaxX)
            mMaxX = positionVector[i].x;

        if(positionVector[i].z > mMaxZ)
            mMaxZ = positionVector[i].z;
    }
}

cinder::gl::VboMesh ShIsland::createLODMesh(DrawStyle style, uint16_t stepSize, std::vector<cinder::Vec3f>& positionVector)
{
	VboMesh mesh;
	uint32_t vertexCount;
	
	VboMesh::Layout layout;
	//layout.setDynamicIndices();
	layout.setStaticIndices();
    //layout.setDynamicColorsRGBA();
    layout.setStaticColorsRGBA();
	//layout.setDynamicPositions();
	layout.setStaticPositions();
	//layout.setDynamicTexCoords3d();
	layout.setDynamicNormals();
	
	//createCustomStaticData(&layout);
	//layout.addDynamicCustomFloat(); // 0, p0_attrib
	//layout.addDynamicCustomVec4f(); // 1, p1_attrib
	//layout.addDynamicCustomVec4f(); // 2, p2_attrib
	layout.addDynamicCustomVec4f(); // 0, pickingAttrib


    fillPositionsVector(positionVector);

    // Calculate vertex count as the array length + the degenerate triangles at the ends of the rows
    vertexCount = positionVector.size();
    // Calculate the number of triangles based on our weaving pattern
    //mTriCount = ((width * 2 + 1) * height);

    // Shader surface mesh
    mesh = VboMesh(vertexCount, vertexCount, layout, GL_TRIANGLES);
		
	std::vector<uint32_t> surfaceIndices;
	
	for(int i = 0; i < vertexCount; i++)
	{
		surfaceIndices.push_back(i);
	}
	
	mesh.bufferIndices(surfaceIndices);
    calculateMinMax(positionVector);
	mesh.bufferPositions(positionVector);
	bufferColors(mesh, vertexCount, stepSize);	
	mesh.unbindBuffers();
		
	//buildTriangleMap();
	populateCustomData(mesh, positionVector);
	calculateNormals(mesh, positionVector);
	bindCustomData(mesh);
	
	return mesh;
}

ColorA ShIsland::createVertexColor(int vertex, int maxWidth, int maxHeight, int maxDepth, int hue)
{
	float colorVal, highlight, lowlight, accent;
	/*
	colorVal = mPositions[vertex].y / maxHeight;
	colorVal = shmath::linexp(colorVal, 0, 1, 0.1, 1);
	highlight = (colorVal * 0.9)+ 0.1;
	lowlight = (mPositions[vertex].z / maxDepth) / 2;
	accent = (mPositions[vertex].x / maxWidth) / 4;*/
	highlight = 0.5;
	lowlight = 0.3;
	accent = 0.4;
	ColorA vertexColor;
	
	switch(hue)
	{
		case 0:
			vertexColor = ColorA(highlight, lowlight, accent, 1);
			break;
			
		case 1:
			vertexColor = ColorA(lowlight, highlight, accent, 1);
			break;
			
		case 2:
			vertexColor = ColorA(accent, highlight, lowlight, 1);
			break;
		case 3:
			vertexColor = ColorA(accent, lowlight, highlight, 1);
			break;
		case 4:
			vertexColor = ColorA(highlight, accent, lowlight, 1);
			break;
		case 5:
			vertexColor = ColorA(lowlight, accent, highlight, 1);
			break;
	}
	
	return vertexColor;
}

AxisAlignedBox3f ShIsland::calcBoundingBox()
{
	// Set inital box values to the first position in the positions array
	float bounds[3][2] = {
		{ mPositions[0].x, mPositions[0].x },
		{ mPositions[0].y, mPositions[0].y },
		{ mPositions[0].z, mPositions[0].z }
	};
	
	// Iterate through the array finding the minimum and maximum values for the x,y,z dimensions and 
	// put them in the bounding box
	for(int i = 0; i < mPositions.size(); ++i)
	{
		if(mPositions[i].x < bounds[0][0]) // Check against min X
			bounds[0][0] = mPositions[i].x;
		
		if(mPositions[i].x > bounds[0][1]) // Check against max X
			bounds[0][1] = mPositions[i].x;
		
		if(mPositions[i].y < bounds[1][0])// Check against min y
			bounds[1][0] = mPositions[i].y;
		
		if(mPositions[i].y > bounds[1][1])// Check against max y
			bounds[1][1] = mPositions[i].y;
		
		if(mPositions[i].z < bounds[2][0])// Check against min z
			bounds[2][0] = mPositions[i].z;
		
        if(mPositions[i].z > bounds[2][1])// Check against max z
			bounds[2][1] = mPositions[i].z;
		
	}

    AxisAlignedBox3f box(Vec3f(bounds[0][0], bounds[1][0], bounds[2][0]), Vec3f(bounds[0][1], bounds[1][1], bounds[2][1]));

    if(bounds[1][0] == 0 && bounds[1][1] == 0)
        return AxisAlignedBox3f(Vec3f(bounds[0][0], -20, bounds[2][0]),
                                Vec3f(bounds[0][1], 20, bounds[2][1]));
    else
        return box;
}

void ShIsland::setDetail(Vec3f pos)
{
	mDistance = mCenterPos.distance(pos);
	
	if(mDistance > kLowDetailDistance) 
	{
		mDetail = Low;
	}
	
	else if(mDistance > kMediumLowDetailDistance)
	{
		mDetail = MediumLow;
	}
	
	else if(mDistance > kMediumDetailDistance)
	{
		mDetail = Medium;
	}
	
	else
	{
		mDetail = High;
	}
}

/*
void ShIsland::buildTriangleMap()
{
	for(int i = 0; i < mVertexCount; i += 3)
	{
		Vec3f v0, v1, v2;
		v0 = Vec3f(mPositions[i].x,   mPositions[i].y,   mPositions[i].z  );
		v1 = Vec3f(mPositions[i+1].x, mPositions[i+1].y, mPositions[i+1].z);
		v2 = Vec3f(mPositions[i+2].x, mPositions[i+2].y, mPositions[i+2].z);
		
		triangleMap.emplace(i, ShTri(v0, v1, v2));
	}
}*/

void ShIsland::buildTriangleGrid()
{
    int index = 0;

    for(int y = 0; y < kTriangleGridHeight; ++y)
    {
        for(int x = 0; x < kTriangleGridWidth; ++x)
        {
            triangleGrid[x][y] = new GridTri(mPositions[index], mPositions[index + 1], mPositions[index + 2]);
            stepVector.push_back(0);
            index += 3;
        }
    }
}

void ShIsland::rebuildTriangleGrid()
{
    int index = 0;

    for(int y = 0; y < kTriangleGridHeight; ++y)
    {
        for(int x = 0; x < kTriangleGridWidth; ++x)
        {
            triangleGrid[x][y]->fill(mPositions[index], mPositions[index + 1], mPositions[index + 2]);
            index += 3;
        }
    }
}

void ShIsland::deleteTriangleGrid()
{
    // boost::upgrade_lock<boost::shared_mutex> lock(mMutex);
    // boost::upgrade_to_unique_lock<boost::shared_mutex> writeLock(lock);

    for(int x = 0; x < kTriangleGridWidth; ++x)
    {
        for(int y = 0; y < kTriangleGridHeight; ++y)
        {
            if(triangleGrid[x][y] != NULL)
            {
                delete triangleGrid[x][y];
                triangleGrid[x][y] = NULL;
            }
        }
    }
}

unsigned char ShIsland::getValue(int x, int y)
{
    // boost::shared_lock<boost::shared_mutex> lock(mMutex);

    if(x >= 0 && y >= 0 && x < kTriangleGridWidth && y < kTriangleGridHeight)
    {
        return triangleGrid[x][y]->getValue();
    }

    else
    {
        std::cout << "Out of Bounds Triangle Grid Request: getActive(" << x << ", " << y << ");" << std::endl;
        return 0;
    }
}

void ShIsland::setValue(int x, int y, unsigned char value)
{
    // boost::upgrade_lock<boost::shared_mutex> lock(mMutex);
    // boost::upgrade_to_unique_lock<boost::shared_mutex> writeLock(lock);

    if(x >= 0 && y >= 0 && x < kTriangleGridWidth && y < kTriangleGridHeight)
    {
        triangleGrid[x][y]->setValue(value);
        stepVector[x + (y * kTriangleGridWidth)] = value;
    }

    else
    {
        std::cout << "Out of Bounds Triangle Grid Request: setActive(" << x << ", " << y << ", " << value << ");" << std::endl;
    }
}

void ShIsland::clearValues()
{
    // boost::upgrade_lock<boost::shared_mutex> lock(mMutex);
    // boost::upgrade_to_unique_lock<boost::shared_mutex> writeLock(lock);

    for(int y = 0; y < kTriangleGridHeight; ++y)
    {
        for(int x = 0; x < kTriangleGridWidth; ++x)
        {
            triangleGrid[x][y]->setValue(0);
        }
    }
}

unsigned char ShIsland::toggleValue(int x, int y)
{
    // boost::upgrade_lock<boost::shared_mutex> lock(mMutex);
    // boost::upgrade_to_unique_lock<boost::shared_mutex> writeLock(lock);

    if(x >= 0 && y >= 0 && x < kTriangleGridWidth && y < kTriangleGridHeight)
    {
        return triangleGrid[x][y]->toggleValue();
    }

    else
    {
        std::cout << "Out of Bounds Triangle Grid Request: toggleValue(" << x << ", " << y << ");" << std::endl;
        return 0;
    }
}

GridTri ShIsland::getTri(int x, int y)
{
    // boost::shared_lock<boost::shared_mutex> lock(mMutex);

    if(x >= 0 && y >= 0 && x < kTriangleGridWidth && y < kTriangleGridHeight)
    {
        return *triangleGrid[x][y];
    }

    else
    {
        std::cout << "Out of Bounds Triangle Grid Request: getTri(" << x << ", " << y << ");" << std::endl;
        return *triangleGrid[0][0];
    }
}

GridTri* ShIsland::getTriPointer(int x, int y)
{
    // boost::shared_lock<boost::shared_mutex> lock(mMutex);

    if(x >= 0 && y >= 0 && x < kTriangleGridWidth && y < kTriangleGridHeight)
    {
        return triangleGrid[x][y];
    }

    else
    {
        std::cout << "Out of Bounds Triangle Grid Request: getTri(" << x << ", " << y << ");" << std::endl;
        return triangleGrid[0][0];
    }
}

std::vector<unsigned char> ShIsland::getStepVector()
{
    // boost::shared_lock<boost::shared_mutex> lock(mMutex);
    return stepVector;
}

void ShIsland::setTerrainHeightMap(std::vector< std::vector<float> >& heightMap, float minHeight, float maxHeight,
                                   bool scheduleUpdate)
{
    // boost::upgrade_lock<boost::shared_mutex> lock(mMutex);
    // boost::upgrade_to_unique_lock<boost::shared_mutex> writeLock(lock);

    mTerrainHeightMap = heightMap;
    scheduleBufferPositions = scheduleUpdate;
    mMinHeight = minHeight;
    mMaxHeight = maxHeight;


    if(scheduleBufferPositions)
    {
        mPositions.clear();
        fillPositionsVector(mPositions);
        calculateMinMax(mPositions);
        rebuildTriangleGrid();
        mBoundingBox = calcBoundingBox();
    }

    updateWaveTerrainBuffer(heightMap, minHeight, maxHeight);
}

void ShIsland::setAnimation(std::deque<animation_frame_t>& animation)
{
    // boost::upgrade_lock<boost::shared_mutex> lock(mMutex);
    // boost::upgrade_to_unique_lock<boost::shared_mutex> writeLock(lock);

    mAnimationQueue = animation;
}

void ShIsland::synchronizedAnimationQueuePop()
{
    mAnimationQueue.pop_front();
}

std::vector< std::vector<float> >& ShIsland::getTerrainHeightMap()
{
    // boost::upgrade_lock<boost::shared_mutex> lock(mMutex);
    return mTerrainHeightMap;
}

ShNetwork::algo_pair ShIsland::getTerrainGen()
{
    // boost::shared_lock<boost::shared_mutex> lock(mMutex);
    return mTerrainGen;
}

void ShIsland::setTerrainGen(ShNetwork::algo_pair terrainGen)
{
    // boost::upgrade_lock<boost::shared_mutex> lock(mMutex);
    // boost::upgrade_to_unique_lock<boost::shared_mutex> writeLock(lock);
    mTerrainGen = terrainGen;
}

ShNetwork::algo_pair ShIsland::getStepGen()
{
    // boost::shared_lock<boost::shared_mutex> lock(mMutex);
    return mStepGen;
}

void ShIsland::setStepGen(ShNetwork::algo_pair stepGen)
{
    // boost::upgrade_lock<boost::shared_mutex> lock(mMutex);
    // boost::upgrade_to_unique_lock<boost::shared_mutex> writeLock(lock);
    mStepGen = stepGen;
}

void ShIsland::bufferActivityColor()
{
    uint32_t index = 0;
    ColorA triColor;
    unsigned int value;

    for(int y = 0; y < kTriangleGridHeight; ++y)
    {
        for(int x = 0; x < kTriangleGridWidth; ++x)
        {
            value = triangleGrid[x][y]->getValue();

            if(value)
                triColor = ShGlobals::COLOR_ON;
            else
                triColor = ShGlobals::COLOR_OFF;

            /*
            switch(value)
            {
            case 0:
                triColor = ShGlobals::COLOR0;
                break;

            case 1:
                triColor = ShGlobals::COLOR1;
                break;

            case 2:
                triColor = ShGlobals::COLOR2;
                break;

            case 3:
                triColor = ShGlobals::COLOR3;
                break;
            }*/

            mColors[index] = triColor;
            mColors[index + 1] = triColor;
            mColors[index + 2] = triColor;

            ++index;
            ++index;
            ++index;
        }
    }

    mSurface.bufferColorsRGBA(mColors);
}

void ShIsland::setScheduleBufferColors(bool schedule)
{
    // boost::upgrade_lock<boost::shared_mutex> lock(mMutex);
    // boost::upgrade_to_unique_lock<boost::shared_mutex> writeLock(lock);
    scheduleBufferColors = schedule;
}

void ShIsland::createWaveTerrainBuffer()
{
    waveTerrainBuffer = sc::Buffer::alloc(sc::Server::internal, ShIsland::kGridWidth * ShIsland::kGridDepth);
}

void ShIsland::updateWaveTerrainBuffer(std::vector< std::vector<float> >& heightMap, float minHeight, float maxHeight)
{
    if(waveTerrainBuffer)
    {
        std::vector<double> collection;

        for(int x = 0; x < heightMap.size(); ++x)
        {
            for(int y = 0; y < heightMap.at(x).size(); ++y)
            {
                collection.push_back(shmath::linlin(heightMap[x][y], minHeight, maxHeight, -1, 1));
            }
        }

        waveTerrainBuffer->sendCollection(collection);
    }
}

void ShIsland::freeWaveTerrainBuffer()
{
    if(waveTerrainBuffer)
    {
        delete waveTerrainBuffer;
        waveTerrainBuffer = 0;
    }
}

int ShIsland::getWaveTerrainBufferNumber()
{
    if(waveTerrainBuffer)
    {
        return waveTerrainBuffer->getBufNum();
    }

    else
    {
        std::cerr << "ShIsland::getWaveTerrainBufferNumber() called but waveTerrainBuffer is not defined. Returning 0." << std::endl;
        return 0;
    }
}

bool ShIsland::getTriCoord(unsigned int index, SeqTri* pickedTri)
{
    // boost::upgrade_lock<boost::shared_mutex> lock(mMutex);

	if(index >= 0 && index < mPositions.size())
	{
		pickedTri->fill(mPositions[index], mPositions[index + 1], mPositions[index + 2]);
		pickedTri->setMapCoord(ShIsland::vertexToCoord(index));
		return true;
	}
	
	return false;
}

void ShIsland::bufferColors(cinder::gl::VboMesh& mesh, uint32_t vertexCount, uint16_t stepSize)
{		
	std::vector<cinder::ColorA> colors;
	
	for(int i = 0; i < vertexCount; i += 3)
	{
        //ColorA triColor = createVertexColor(i * stepSize, mMaxX, mMaxHeight, mMaxZ, mRandColor);
		
        colors.push_back(ShGlobals::COLOR_OFF);
        colors.push_back(ShGlobals::COLOR_OFF);
        colors.push_back(ShGlobals::COLOR_OFF);
    }
	
    //mDefaultColor = colors.front();
    mColors = colors;
    mesh.bufferColorsRGBA(colors); // color was mColors
}

void ShIsland::createCustomStaticData(gl::VboMesh::Layout* layout)
{
	layout->mCustomStatic.push_back(std::make_pair(gl::VboMesh::Layout::CUSTOM_ATTR_FLOAT,  0));
	layout->mCustomStatic.push_back(std::make_pair(gl::VboMesh::Layout::CUSTOM_ATTR_FLOAT4, 0));
	layout->mCustomStatic.push_back(std::make_pair(gl::VboMesh::Layout::CUSTOM_ATTR_FLOAT4, 0));
	layout->mCustomStatic.push_back(std::make_pair(gl::VboMesh::Layout::CUSTOM_ATTR_FLOAT4, 0));
}

void ShIsland::populateCustomData(cinder::gl::VboMesh& mesh, std::vector<cinder::Vec3f>& positionVector)
{	
    initialPickingIndex = ShIsland::globalPickingIndex;
    std::cout << "Island:: " << this->mID << " initial picking index: " << initialPickingIndex << std::endl;
	gl::VboMesh::VertexIter surfaceIter = mesh.mapVertexBuffer();
	for(int i = 0; i < positionVector.size(); i += 3)
	{
		/*
		surfaceIter.setCustomFloat(0, 0);
		surfaceIter.setCustomVec4f(1, Vec4f(positionVector[i+1].x, positionVector[i+1].y, positionVector[i+1].z, 1));
		surfaceIter.setCustomVec4f(2, Vec4f(positionVector[i+2].x, positionVector[i+2].y, positionVector[i+2].z, 1)); 
		surfaceIter.setTexCoord3d0(shcolor::intToVec3f(i));
		//surfaceIter.setCustomVec4f(3, shcolor::intToVec4f(i));
		++surfaceIter;
		
		surfaceIter.setCustomFloat(0, 1);
		surfaceIter.setCustomVec4f(1, Vec4f(positionVector[i+2].x, positionVector[i+2].y, positionVector[i+2].z, 1));
		surfaceIter.setCustomVec4f(2, Vec4f(positionVector[i].x,   positionVector[i].y,   positionVector[i].z,   1));
		surfaceIter.setTexCoord3d0(shcolor::intToVec3f(i));
		//surfaceIter.setCustomVec4f(3, shcolor::intToVec4f(i));
		++surfaceIter;*/
		
		//surfaceIter.setCustomFloat(0, 2);
		//surfaceIter.setCustomVec4f(1, Vec4f(positionVector[i].x,   positionVector[i].y,   positionVector[i].z,   1));
		//surfaceIter.setCustomVec4f(2, Vec4f(positionVector[i+1].x, positionVector[i+1].y, positionVector[i+1].z, 1));
		//surfaceIter.setTexCoord3d0(shcolor::intToVec3f(i));

        surfaceIter.setCustomVec4f(0, shcolor::intToVec4f(ShIsland::globalPickingIndex));
		++surfaceIter;
        surfaceIter.setCustomVec4f(0, shcolor::intToVec4f(ShIsland::globalPickingIndex));
		++surfaceIter;
        surfaceIter.setCustomVec4f(0, shcolor::intToVec4f(ShIsland::globalPickingIndex));
		++surfaceIter;

        ++ShIsland::globalPickingIndex;
        ++ShIsland::globalPickingIndex;
        ++ShIsland::globalPickingIndex;
	}
}

void ShIsland::bindCustomData(cinder::gl::VboMesh& mesh)
{	
	//ShShaders::bindWireframe();
	ShShaders::bindPicking();
	//mesh.setCustomDynamicLocation(0, ShShaders::p0_attrib);
	//mesh.setCustomDynamicLocation(1, ShShaders::p1_attrib);
	//mesh.setCustomDynamicLocation(2, ShShaders::p2_attrib);
	mesh.setCustomDynamicLocation(0, ShShaders::pickingAttrib);
	
	//ShShaders::unbindWireframe();
	ShShaders::unbindPicking();
}

void ShIsland::calculateNormals(cinder::gl::VboMesh& mesh, std::vector<cinder::Vec3f>& positionVector)
{
	Vec3f normalVector;
	ShTri triangle;
	gl::VboMesh::VertexIter surfaceIter = mesh.mapVertexBuffer();
	for(int i = 0; i < positionVector.size(); i += 3)
	{
		triangle.fill(positionVector[i], positionVector[i + 1], positionVector[i + 2]);
		normalVector = triangle.normal();
		
		surfaceIter.setNormal(normalVector);
		++surfaceIter;
		
		surfaceIter.setNormal(normalVector);
		++surfaceIter;
		
		surfaceIter.setNormal(normalVector);
		++surfaceIter;
	}
}

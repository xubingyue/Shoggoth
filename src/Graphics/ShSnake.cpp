/*
 *  ShSnake.cpp
 *  Shoggoth
 *
 *  Created by Chad McKinney on 4/22/12.
 *
 */
#include "src/Graphics/ShSnake.h"
#include "src/Graphics/ShIsland.h"
#include "src/Graphics/ShSeqPath.h"
#include "src/shmath.h"
#include "cinder/Sphere.h"
#include "cinder/gl/Light.h"
#include "Node.h"

using namespace ci;
using namespace gl;
using namespace sc;

cinder::gl::VboMesh ShSnake::MESH[ShSnake::SEGMENTS];
std::vector<cinder::Vec3f> ShSnake::positions[ShSnake::SEGMENTS];
std::vector<cinder::Vec3f> ShSnake::normals[ShSnake::SEGMENTS];
std::vector<cinder::ColorA> ShSnake::colors[ShSnake::SEGMENTS];

void ShSnake::createMesh()
{
	for(int i = 0; i < ShSnake::SEGMENTS; ++i)
	{
		ShSnake::positions[i] = std::vector<cinder::Vec3f>();
		ShSnake::normals[i] = std::vector<cinder::Vec3f>();
		ShSnake::colors[i] = std::vector<cinder::ColorA>();
	}
	
	
	for(int i = 0; i < SEGMENTS; ++i)
	{
		uint16_t vertexCount = 18;
		float segmentSize = (21 - (i * 2)) / SEGMENTS;
		
		VboMesh::Layout layout;
		layout.setStaticIndices();
		layout.setStaticColorsRGBA();
		layout.setStaticPositions();
		layout.setStaticNormals();
		
		MESH[i] = VboMesh(vertexCount, vertexCount, layout, GL_TRIANGLES);
		
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
		
		for(int j = 0; j < vertexCount; ++j)
		{
			ShSnake::positions[i].push_back(pyramid[j] * ShIsland::kGridSize * segmentSize);
		}
		
		MESH[i].bufferPositions(ShSnake::positions[i]);
		
		for(int j = 0; j < vertexCount; ++j)
		{
			ShSnake::colors[i].push_back(ColorA(1, 1, 1, 0.5));
		}
		
		MESH[i].bufferColorsRGBA(ShSnake::colors[i]);
		
		ShTri tri;
		for(int j = 0; j < vertexCount; j += 3)
		{
			tri.fill(ShSnake::positions[i][j], ShSnake::positions[i][j + 1], ShSnake::positions[i][j + 2]);
			
			ShSnake::normals[i].push_back(tri.normal());
			ShSnake::normals[i].push_back(tri.normal());
			ShSnake::normals[i].push_back(tri.normal());
		}
		
		MESH[i].bufferNormals(ShSnake::normals[i]);
		
		std::vector<uint32_t> surfaceIndices;
		
		for(int j = 0; j < vertexCount; ++j)
		{
			surfaceIndices.push_back(j);
		}
		
		MESH[i].bufferIndices(surfaceIndices);
	}
}

ShSnake::ShSnake(ShIsland* island) :
	mIsland(island),
	mDirection(1)
{
	for(int i = 0; i < ShSnake::SEGMENTS; ++i)
	{
		mGridPositions.push_back(Vec2i(i, 0));
	}

    for(int i = 0; i < ShSnake::SEGMENTS; ++i)
    {
        mTriQueue.push_back(island->getTri(i, 0));
    }
}

void ShSnake::setGridPositions(std::deque<cinder::Vec2i> gridPositions)
{
	mGridPositions = gridPositions;
}

const std::deque<cinder::Vec2i>& ShSnake::getGridPositions()
{
	return mGridPositions;
}

void ShSnake::update()
{
	
}

void ShSnake::draw()
{
    /*
    ShTri tri = mIsland->getTri(mGridPositions.front().x, mGridPositions.front().y);
    ShTri lastTri;
	uint16 index = 0;
	
	gl::color(0.5, 0.9, 0.5);
	
	cinder::Vec2i headPos = mGridPositions.front();
    //ShTri* headTri = mIsland->triangleGrid[headPos.x][headPos.y];
    ShTri headTri = mIsland->getTri(headPos.x, headPos.y);
	//cinder::Vec3f lightPos = headTri->getCentroid() + (headTri->normal() * 2);
	
	glBegin(GL_TRIANGLES);
    glVertex3f(headTri.v0().x, headTri.v0().y + 2, headTri.v0().z);
    glVertex3f(headTri.v1().x, headTri.v1().y + 2, headTri.v1().z);
    glVertex3f(headTri.v2().x, headTri.v2().y + 2, headTri.v2().z);
	glEnd();

	std::deque<cinder::Vec2i>::iterator iter = mGridPositions.begin();
	while(iter != mGridPositions.end())
	{
		lastTri = tri;
        tri = mIsland->getTri(iter->x, iter->y);
		
        glBegin(GL_TRIANGLES);

        glVertex3f(lastTri.getCentroid().x, lastTri.getCentroid().y, lastTri.getCentroid().z);
        glVertex3f(lastTri.getCentroid().x + (lastTri.normal().x),
                   lastTri.getCentroid().y + (lastTri.normal().y),
                   lastTri.getCentroid().z + (lastTri.normal().z));
        glVertex3f(tri.getCentroid().x, tri.getCentroid().y, tri.getCentroid().z);


        if(index < SEGMENTS - 1)
        {
            glVertex3f(tri.getCentroid().x, tri.getCentroid().y, tri.getCentroid().z);
            glVertex3f(tri.getCentroid().x + (tri.normal().x),
                       tri.getCentroid().y + (tri.normal().y),
                       tri.getCentroid().z + (tri.normal().z));
            glVertex3f(lastTri.getCentroid().x + (lastTri.normal().x),
                       lastTri.getCentroid().y + (lastTri.normal().y),
                       lastTri.getCentroid().z + (lastTri.normal().z));
        }

        glEnd();
		
		

		
		++iter;
		++index;
    }*/

    /*
    glBegin(GL_TRIANGLES);
    glVertex3f(tri->v0().x, lastTri.v0().y + 2, tri->v0().z);
    glVertex3f(tri->v1().x, tri->v1().y + 2, tri->v1().z);
    glVertex3f(tri->getCentroid().x + (tri->normal().x * 40),
               tri->getCentroid().y + (tri->normal().y * 40),
               tri->getCentroid().z + (tri->normal().z * 40));

    glVertex3f(tri->v1().x, tri->v1().y + 2, tri->v1().z);
    glVertex3f(tri->v2().x, tri->v2().y + 2, tri->v2().z);
    glVertex3f(tri->getCentroid().x + (tri->normal().x * 40),
               tri->getCentroid().y + (tri->normal().y * 40),
               tri->getCentroid().z + (tri->normal().z * 40));

    glVertex3f(tri->v2().x, tri->v2().y + 2, tri->v2().z);
    glVertex3f(tri->v0().x, tri->v0().y + 2, tri->v0().z);
    glVertex3f(tri->getCentroid().x + (tri->normal().x * 40),
               tri->getCentroid().y + (tri->normal().y * 40),
               tri->getCentroid().z + (tri->normal().z * 40));
    glEnd();*/


    //std::deque<ShTri>::iterator iter = mTriQueue.begin();
    //gl::color(0.75, 0, 0);

    /*
    glBegin(GL_TRIANGLES);
    while(iter != mTriQueue.end())
    {
        glVertex3f(iter->v0().x, iter->v0().y, iter->v0().z);
        glVertex3f(iter->v1().x, iter->v1().y, iter->v1().z);
        glVertex3f(iter->v2().x, iter->v2().y, iter->v2().z);
        ++iter;
    }
    glEnd();*/

    //ShTri* tri = &mTriQueue.front();

    /*
    int count = 0;
    glBegin(GL_TRIANGLES);

    std::deque<ShTri>::iterator tri = mTriQueue.begin();
    while(tri != mTriQueue.end())
    {
        float size = 2.0 * (mTriQueue.size() / (count / (double) ShSnake::SEGMENTS + 1));

        glVertex3f(tri->v0().x, tri->v0().y + 2, tri->v0().z);
        glVertex3f(tri->v1().x, tri->v1().y + 2, tri->v1().z);
        glVertex3f(tri->getCentroid().x,
                   tri->getCentroid().y + size,
                   tri->getCentroid().z);

        glVertex3f(tri->v1().x, tri->v1().y + 2, tri->v1().z);
        glVertex3f(tri->v2().x, tri->v2().y + 2, tri->v2().z);
        glVertex3f(tri->getCentroid().x,
                   tri->getCentroid().y + size,
                   tri->getCentroid().z);

        glVertex3f(tri->v2().x, tri->v2().y + 2, tri->v2().z);
        glVertex3f(tri->v0().x, tri->v0().y + 2, tri->v0().z);
        glVertex3f(tri->getCentroid().x,
                   tri->getCentroid().y + size,
                   tri->getCentroid().z);

        ++tri;
        ++count;
    }

    glEnd();*/


    GridTri* tri = &mTriQueue.front();
    //ShTri* backTri = &mTriQueue.back();
    float size = 50.0;

    if(tri->getValue())
    {
        gl::color(1, 0, 0);
        size = 100.0;
    }

    else
    {
        gl::color(0.6, 0.0, 0.0);
        size = 30.0;
    }

    glBegin(GL_TRIANGLES);
    glVertex3f(tri->v0().x, tri->v0().y, tri->v0().z);
    glVertex3f(tri->v1().x, tri->v1().y, tri->v1().z);
    glVertex3f(tri->getCentroid().x,
               tri->getCentroid().y + size,
               tri->getCentroid().z);

    glVertex3f(tri->v1().x, tri->v1().y, tri->v1().z);
    glVertex3f(tri->v2().x, tri->v2().y, tri->v2().z);
    glVertex3f(tri->getCentroid().x,
               tri->getCentroid().y + size,
               tri->getCentroid().z);

    glVertex3f(tri->v2().x, tri->v2().y, tri->v2().z);
    glVertex3f(tri->v0().x, tri->v0().y, tri->v0().z);
    glVertex3f(tri->getCentroid().x,
               tri->getCentroid().y + size,
               tri->getCentroid().z);

    /*
    glVertex3f(backTri->getCentroid().x,
               backTri->getCentroid().y + size,
               backTri->getCentroid().z);

    glVertex3f(tri->getCentroid().x,
               tri->getCentroid().y,
               tri->getCentroid().z);

    glVertex3f(tri->getCentroid().x,
               tri->getCentroid().y + size,
               tri->getCentroid().z);

    glVertex3f(tri->getCentroid().x,
               tri->getCentroid().y + size,
               tri->getCentroid().z);

    glVertex3f(tri->getCentroid().x,
               tri->getCentroid().y,
               tri->getCentroid().z);

    glVertex3f(backTri->getCentroid().x,
               backTri->getCentroid().y + size,
               backTri->getCentroid().z);*/

    glEnd();


    /*
    glBegin(GL_LINE_STRIP);
    std::deque<ShTri>::iterator iter = mTriQueue.begin();

    while(iter != mTriQueue.end())
    {

        glVertex3f(iter->getCentroid().x,
                   iter->getCentroid().y + size,
                   iter->getCentroid().z);

        ++iter;
    }

    glEnd();*/
}

void ShSnake::increment()
{
	if(mDirection > 0)
	{
		if(mGridPositions.front().x < ShIsland::kTriangleGridWidth - 1)
		{
			mGridPositions.pop_back();
			mGridPositions.push_front(Vec2i(mGridPositions.front().x + mDirection, mGridPositions.front().y));
		}
		
		else if(mGridPositions.front().y < ShIsland::kTriangleGridHeight - 1)
		{
			mDirection *= -1;
			mGridPositions.pop_back();
			mGridPositions.push_front(Vec2i(mGridPositions.front().x, mGridPositions.front().y + 1));
		}
		
		else 
		{
			mGridPositions.pop_back();
			mGridPositions.push_front(Vec2i(0, 0));
		}
	}
	
	else
	{
		if(mGridPositions.front().x > 0)
		{
			mGridPositions.pop_back();
			mGridPositions.push_front(Vec2i(mGridPositions.front().x + mDirection, mGridPositions.front().y));
		}
		
		else if(mGridPositions.front().y < ShIsland::kTriangleGridHeight - 1)
		{
			mDirection *= -1;
			mGridPositions.pop_back();
			mGridPositions.push_front(Vec2i(mGridPositions.front().x, mGridPositions.front().y + 1));
		}
		
		else 
		{
			mGridPositions.pop_back();
			mGridPositions.push_front(Vec2i(0, 0));
		}
    }

    mTriQueue.pop_back();
    mTriQueue.push_front(mIsland->getTri(mGridPositions.front().x, mGridPositions.front().y));
	
    if(mIsland->getValue(mGridPositions.front().x, mGridPositions.front().y) > 0)
    {
		Synth::grain(
					 "ShoggothPerc", 
					 ARGS("freq", 440.0f)
					 );
	}
}

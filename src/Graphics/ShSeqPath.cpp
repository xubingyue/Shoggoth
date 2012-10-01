/*
 *  ShSeqPath.cpp
 *  Shoggoth
 *
 *  Created by Chad McKinney on 2/24/12.
 *
 */
#include <vector>
#include <iostream>
#include <sstream>

#include "src/Graphics/ShSeqPath.h"
#include "src/Graphics/ShIsland.h"
#include "src/ShGlobals.h"
#include "src/Graphics/shaders.h"

using namespace cinder;
using namespace gl;

//////////
// ShTri
//////////

ShTri::ShTri(cinder::Vec3f _v0, cinder::Vec3f _v1, cinder::Vec3f _v2) :
	vZero(_v0),
	vOne(_v1),
	vTwo(_v2),
	normalVector(cinder::Vec3f(0, 0, 0))
{
	setCentroid();
	setNormal();
}

void ShTri::setv0(cinder::Vec3f _v0)
{
	vZero = _v0;
	setCentroid();
	setNormal();
}

void ShTri::setv1(cinder::Vec3f _v1)
{
	vOne = _v1;
	setCentroid();
	setNormal();
}

void ShTri::setv2(cinder::Vec3f _v2)
{
	vTwo = _v2;
	setCentroid();
	setNormal();
}

void ShTri::v0(cinder::Vec3f _v0)
{
	setv0(_v0);
}

void ShTri::v1(cinder::Vec3f _v1)
{
	setv1(_v1);
}

void ShTri::v2(cinder::Vec3f _v2)
{
	setv2(_v2);
}

cinder::Vec3f ShTri::getv0()
{
	return vZero;
}

cinder::Vec3f ShTri::getv1()
{
	return vOne;
}

cinder::Vec3f ShTri::getv2()
{
	return vTwo;
}

cinder::Vec3f ShTri::v0()
{
	return vZero;
}

cinder::Vec3f ShTri::v1()
{
	return vOne;
}

cinder::Vec3f ShTri::v2()
{
	return vTwo;
}

cinder::Vec3f ShTri::c()
{
	return centroid;
}

cinder::Vec3f ShTri::getCentroid()
{
	return centroid;
}

cinder::Vec3f ShTri::normal()
{
	return normalVector;
}

void ShTri::setCentroid()
{
	centroid = Vec3f((vZero.x + vOne.x + vTwo.x) / 3, (vZero.y + vOne.y + vTwo.y) / 3, (vZero.z + vOne.z + vTwo.z) / 3);
	//std::cout << "Centroid: (" << centroid.x << ", " << centroid.y << ", " << centroid.z << ")" << std::endl;
}

void ShTri::setNormal()
{
	cinder::Vec3f normal, normalU, normalV;
	normalU = vOne - vZero;
	normalV = vTwo - vZero;
	
	normal.x = (normalU.y * normalV.z) - (normalU.z * normalV.y);
	normal.y = (normalU.z * normalV.x) - (normalU.x * normalV.z);
	normal.z = (normalU.x * normalV.y) - (normalU.y * normalV.x);
	normalVector = normal.normalized();
}

float ShTri::degenerateArea = 0.0f;

bool ShTri::isDegenerate()
{
	Vec3f d1, d2;
	d1 = vOne - vZero;
	d2 = vTwo - vOne;
	d1 = d1.cross(d2);
	return d1.lengthSquared() <= (4.0f * degenerateArea * degenerateArea);
}

float ShTri::getDegenerateArea()
{
	return degenerateArea;
}

void ShTri::setDegenerateArea(float _degenerateArea)
{
	degenerateArea = _degenerateArea;
}

///////////
// GridTri
///////////

GridTri::GridTri(Vec3f _v0, Vec3f _v1, Vec3f _v2, unsigned char _value) :
	ShTri(_v0, _v1, _v2),
    value(_value)
{
    //createMesh();
}

void GridTri::setValue(unsigned char _value)
{
    value = _value;
}

unsigned char GridTri::toggleValue()
{
    value = !value;
    return value;
}

unsigned char GridTri::getValue()
{
    return value;
}

void GridTri::draw()
{
    if(value > 0)
    {
        //gl::enableAlphaBlending();
        //gl::draw(mesh);
        //gl::disableAlphaBlending();
    }
}

void GridTri::createMesh()
{
    uint32_t vertexCount = 3;

    VboMesh::Layout layout;
    layout.setStaticIndices();
    layout.setStaticColorsRGBA();
    layout.setStaticPositions();
    layout.setStaticNormals();

    //layout.addDynamicCustomFloat(); // 0, p0_attrib
    //layout.addDynamicCustomVec4f(); // 1, p1_attrib
    //layout.addDynamicCustomVec4f(); // 2, p2_attrib

    mesh = VboMesh(vertexCount, vertexCount, layout, GL_TRIANGLES);

    std::vector<uint32_t> indices;
    std::vector<cinder::Vec3f> positions;
    std::vector<cinder::ColorA> colors;
    std::vector<cinder::Vec3f> normals;

    for(int i = 0; i < vertexCount; ++i)
    {
        indices.push_back(i);
        colors.push_back(cinder::ColorA(4, 4, 4, 0.5));
        normals.push_back(this->normal());

        switch(i)
        {
        case 0:
            positions.push_back(this->getv0() + cinder::Vec3f(0, 2, 0));
            break;

        case 1:
            positions.push_back(this->getv1() + cinder::Vec3f(0, 2, 0));
            break;

        case 2:
            positions.push_back(this->getv2() + cinder::Vec3f(0, 2, 0));
            break;
        }
    }

    mesh.bufferIndices(indices);
    mesh.bufferPositions(positions);
    mesh.bufferColorsRGBA(colors);
    mesh.bufferNormals(normals);

    /*
    cinder::gl::VboMesh::VertexIter meshIter = mesh.mapVertexBuffer();

    meshIter.setCustomFloat(0, 0);
    meshIter.setCustomVec4f(1, Vec4f(positions[1].x, positions[1].y, positions[1].z, 1));
    meshIter.setCustomVec4f(2, Vec4f(positions[2].x, positions[2].y, positions[2].z, 1));
    ++meshIter;

    meshIter.setCustomFloat(0, 1);
    meshIter.setCustomVec4f(1, Vec4f(positions[2].x, positions[2].y, positions[2].z, 1));
    meshIter.setCustomVec4f(2, Vec4f(positions[0].x, positions[0].y, positions[0].z, 1));
    ++meshIter;

    meshIter.setCustomFloat(0, 2);
    meshIter.setCustomVec4f(1, Vec4f(positions[0].x, positions[0].y, positions[0].z, 1));
    meshIter.setCustomVec4f(2, Vec4f(positions[1].x, positions[1].y, positions[1].z, 1));
    ++meshIter;


    ShShaders::bindWireframe();
    mesh.setCustomDynamicLocation(0, ShShaders::p0_attrib);
    mesh.setCustomDynamicLocation(1, ShShaders::p1_attrib);
    mesh.setCustomDynamicLocation(2, ShShaders::p2_attrib);
    ShShaders::unbindWireframe();*/
}

//////////
// SeqTri
//////////

SeqTri::SeqTri(cinder::Vec3f _v0, cinder::Vec3f _v1, cinder::Vec3f _v2, cinder::Vec2i _mapCoord) :
	ShTri(_v0, _v1, _v2),
	mapCoord(_mapCoord)
{

}

void SeqTri::draw()
{
    gl::enableAlphaBlending();
    gl::draw(mesh);
    gl::disableAlphaBlending();
}

void SeqTri::setMapCoord(cinder::Vec2i _mapCoord)
{
	mapCoord = _mapCoord;
}

cinder::Vec2i SeqTri::getMapCoord()
{
	return mapCoord;
}

void SeqTri::setMapVertex(uint32_t _mapVertex)
{
	mapVertex = _mapVertex;
}

uint32_t SeqTri::getMapVertex()
{
	return mapVertex;
}

void SeqTri::createMesh()
{
    uint32_t vertexCount = 3;

    VboMesh::Layout layout;
    layout.setStaticIndices();
    layout.setStaticColorsRGBA();
    layout.setStaticPositions();
    layout.setStaticNormals();

    layout.addDynamicCustomFloat(); // 0, p0_attrib
    layout.addDynamicCustomVec4f(); // 1, p1_attrib
    layout.addDynamicCustomVec4f(); // 2, p2_attrib

    mesh = VboMesh(vertexCount, vertexCount, layout, GL_TRIANGLES);

    std::vector<uint32_t> indices;
    std::vector<cinder::Vec3f> positions;
    std::vector<cinder::ColorA> colors;
    std::vector<cinder::Vec3f> normals;

    for(int i = 0; i < vertexCount; ++i)
    {
        indices.push_back(i);
        colors.push_back(cinder::ColorA(4, 4, 4, 0.5));
        normals.push_back(this->normal());

        switch(i)
        {
        case 0:
            positions.push_back(this->getv0() + cinder::Vec3f(0, 2, 0));
            break;

        case 1:
            positions.push_back(this->getv1() + cinder::Vec3f(0, 2, 0));
            break;

        case 2:
            positions.push_back(this->getv2() + cinder::Vec3f(0, 2, 0));
            break;
        }
    }

    mesh.bufferIndices(indices);
    mesh.bufferPositions(positions);
    mesh.bufferColorsRGBA(colors);
    mesh.bufferNormals(normals);

    cinder::gl::VboMesh::VertexIter meshIter = mesh.mapVertexBuffer();

    meshIter.setCustomFloat(0, 0);
    meshIter.setCustomVec4f(1, Vec4f(positions[1].x, positions[1].y, positions[1].z, 1));
    meshIter.setCustomVec4f(2, Vec4f(positions[2].x, positions[2].y, positions[2].z, 1));
    ++meshIter;

    meshIter.setCustomFloat(0, 1);
    meshIter.setCustomVec4f(1, Vec4f(positions[2].x, positions[2].y, positions[2].z, 1));
    meshIter.setCustomVec4f(2, Vec4f(positions[0].x, positions[0].y, positions[0].z, 1));
    ++meshIter;

    meshIter.setCustomFloat(0, 2);
    meshIter.setCustomVec4f(1, Vec4f(positions[0].x, positions[0].y, positions[0].z, 1));
    meshIter.setCustomVec4f(2, Vec4f(positions[1].x, positions[1].y, positions[1].z, 1));
    ++meshIter;

    ShShaders::bindWireframe();
    mesh.setCustomDynamicLocation(0, ShShaders::p0_attrib);
    mesh.setCustomDynamicLocation(1, ShShaders::p1_attrib);
    mesh.setCustomDynamicLocation(2, ShShaders::p2_attrib);
    ShShaders::unbindWireframe();
}

/////////////
// ShSeqPath
/////////////

uint32_t ShSeqPath::seqCounter = 0;

ShSeqPath::ShSeqPath(ShIsland* targetIsland, SeqTri initialTri) :
	mTargetIsland(targetIsland),
	mPathColor(0, 0.9, 0.9, 1),
    mEventColor(1.5, 1.5, 1.5, 1)
{	
	beginSubPath(initialTri);
	ShSeqPath::seqCounter++;
	
	seqID = ShSeqPath::seqCounter;
	std::stringstream ss;
    ss << ShGlobals::USER_NAME << seqID;
	seqSyncKey = ss.str().c_str();
}

ShSeqPath::~ShSeqPath()
{
	//mPathMesh.unbindBuffers();
	/*
	submesh_t::iterator meshIter = mMeshChain.begin();
	
	while(meshIter != mMeshChain.end())
	{
		delete *meshIter;
		++meshIter;
	}
	
	mMeshChain.clear();*/
}

void ShSeqPath::step(int stepDirection)
{
	
}

void ShSeqPath::update()
{
	
}

void ShSeqPath::draw()
{
	//gl::draw(mPathMesh);
	/*
	submesh_t::iterator meshIter = mMeshChain.begin();
	
	while(meshIter != mMeshChain.end())
	{
		gl::draw(*(*meshIter));
		++meshIter;
	}*/
	
	/*
	glBegin(GL_TRIANGLES);
	
	subpath_t::iterator chainIter = mPathChain.back().begin();
	while(chainIter != mPathChain.back().end())
	{
		for(int j = 0; j < 3; ++j)
		{
			glVertex3f((*chainIter)[j].x, (*chainIter)[j].y, (*chainIter)[j].z);
		}
		++chainIter;
	}
	glEnd();*/
	
	/////////////////////////
	// Draw Event Triangles
	
	

    //gl::color(Color(0.25, 0.25, 0.25));
    //glPolygonMode(GL_FRONT_AND_BACK, GL_LINE);
    //glBegin(GL_TRIANGLES);
	
	subpath_t::iterator eventIter = mEventPositions.begin();
	while(eventIter != mEventPositions.end())
	{
        /*
		for(int j = 0; j < 3; ++j)
        {
            glVertex3f((*eventIter)[j].x, (*eventIter)[j].y + 3, (*eventIter)[j].z);
        }*/
		
        (*eventIter).draw();

		//glVertex3f((*eventIter).getCentroid().x, (*eventIter).getCentroid().y, (*eventIter).getCentroid().z);
		
		++eventIter;
	}
	
    //glEnd();

    /*
    gl::color(mEventColor);
    //glPolygonMode(GL_FRONT_AND_BACK, GL_FILL);
    //glPolygonOffset(1, 1);
    glBegin(GL_TRIANGLES);
    eventIter = mEventPositions.begin();
    while(eventIter != mEventPositions.end())
    {

        for(int j = 0; j < 3; ++j)
        {
            glVertex3f((*eventIter)[j].x, (*eventIter)[j].y + 2, (*eventIter)[j].z);
        }

        //glVertex3f((*eventIter).getCentroid().x, (*eventIter).getCentroid().y, (*eventIter).getCentroid().z);

        ++eventIter;
    }

    glEnd();*/
	
	//////////////////////////
	// Draw SubPath Triangles
	
    //glPolygonOffset(1, 1);
	
    /*
	gl::color(mPathColor);
	glBegin(GL_LINE_STRIP);
	
	std::deque<subpath_t>::iterator chainIter = mPathChain.begin();
	while(chainIter != mPathChain.end()) // mPathChain: deque of paths
	{
		subpath_t::iterator subPathIter = (*chainIter).begin(); // subPaths
		while(subPathIter != (*chainIter).end())
		{
			
			for(int j = 0; j < 3; ++j) // SeqTri's in a given subPath
			{
				glVertex3f((*subPathIter)[j].x, (*subPathIter)[j].y + 2, (*subPathIter)[j].z); // Draw the triangle from the 3 Vertices
			}
			//glVertex3f((*subPathIter).getCentroid().x, (*subPathIter).getCentroid().y, (*subPathIter).getCentroid().z);
			++subPathIter;
		}
		
		++chainIter;
	}
	
    glEnd();*/

    //glPolygonMode( GL_FRONT_AND_BACK, GL_FILL );
	
	//glPolygonOffset(0, 0);
	
	/*
	gl::color(Color(0, 1, 0));
	
	glBegin(GL_LINE_STRIP);
	
	chainIter = mEventPositions.begin();
	while(chainIter != mEventPositions.end())
	{
		glVertex3f((*chainIter).getCentroid().x, (*chainIter).getCentroid().y, (*chainIter).getCentroid().z);
		++chainIter;
	}
	glEnd();
	*/
}

void ShSeqPath::updateChainTarget(SeqTri tri)
{
	
}

void ShSeqPath::beginSubPath(SeqTri eventTri)
{
	//mPathChain.push_back(subpath_t());
    eventTri.createMesh();
	mEventPositions.push_back(eventTri);
}

void ShSeqPath::addEventToSubPath(SeqTri eventTri)
{	
	mPathChain.push_back(pathFind(&mEventPositions.back(), &eventTri));
	mEventPositions.push_back(eventTri);
	
	// Calculate event number
	uint32_t eventID = 0;
	
	std::deque<subpath_t>::iterator pathIter = mPathChain.begin();
	while(pathIter != mPathChain.end()) // Iterate through the path chain adding up the length of each
	{
		eventID += (*pathIter).size() - 1;
		++pathIter;
	}
	
	//eventID = mTriCount - 1;
	std::cout << "EVENT ID" << eventID << std::endl;
	
	eventSet.insert(eventID);
	std::cout << "Event Set Size: " << eventSet.size() << std::endl;
	/*
	subpath_t subPath;
	for(int i = 0; i < ShIsland::kTriGridWidth; ++i)
	{
		uint32_t index = ShIsland::coordToVertex(Vec2i(i, 0));
		subPath.push_back(
					SeqTri(
						   mTargetIsland->mPositions[index], 
						   mTargetIsland->mPositions[index+1],
						   mTargetIsland->mPositions[index+2]
					)
		);
	}
	
	mPathChain.push_back(subPath);*/
}

void ShSeqPath::finishSubPath()
{
	//createSubPathMesh(&(*mPathChain.end()));
}

void ShSeqPath::addSubPathToChain()
{
	
}

void ShSeqPath::finishChain()
{
	
} 

ShIsland* ShSeqPath::getTargetIsland()
{
	return mTargetIsland;
}

void ShSeqPath::addMeshIndex(uint32_t x, uint32_t y)
{
	
}

// NEED TO MAKE THE VBO STATIC
void ShSeqPath::createSubPathMesh(subpath_t* subPath)
{
	VboMesh::Layout layout;
	layout.setDynamicIndices();
	layout.setDynamicPositions();
	layout.setDynamicColorsRGBA();
	
	mVertexCount += subPath->size() * 3;
	mTriCount += subPath->size();
	
	VboMesh* pathMesh = new VboMesh(mVertexCount, mTriCount * 3, layout, GL_TRIANGLES);
	std::vector<uint32_t> indices;
	for(uint32_t i = 0; i < mVertexCount; ++i)
	{
		indices.push_back(i);
	}
	pathMesh->bufferIndices(indices);
	pathMesh->unbindBuffers();
	
	VboMesh::VertexIter pathIter = pathMesh->mapVertexBuffer();
	
	for(uint16_t i = 0; i < subPath->size(); ++i)
	{
		for(uint16_t j = 0; j < 3; ++j)
		{
			pathIter.setColorRGBA(mPathColor);
			//pathIter.setPosition(initialTri[i]);
			pathIter.setPosition((*subPath)[i][j]);
			++pathIter;
		}
	}
	mMeshChain.push_back(pathMesh);
}

ShSeqPath::subpath_t ShSeqPath::pathFind(SeqTri* startTri, SeqTri* targetTri) //create a new subpath
{
	subpath_t subPath;
	//subPath.push_back(*startTri);
	std::deque<cinder::Vec2i> pathIndexes;
	//pathIndexes.push_back(startTri->getMapCoord());
	
	Vec2i currentCoord, nextCoord;
	currentCoord = startTri->getMapCoord();
	nextCoord = targetTri->getMapCoord();
	
	///////////////////////////////////////
	// First, find the sequence of indexes
	///////////////////////////////////////
			
	while(currentCoord != nextCoord && pathIndexes.size() < (ShIsland::kTriGridWidth * ShIsland::kTriGridHeight))
	{
		// North
		if(currentCoord.x == nextCoord.x && currentCoord.y > nextCoord.y)
		{
			if(currentCoord.x % 2 == 0)
			{
				currentCoord.x += 1;
				currentCoord.y -= 1;
			}
			
			else
			{
				currentCoord.x -= 1;
			}
			
			pathIndexes.push_back(currentCoord);
		}
		
		else if(currentCoord.x < nextCoord.x && currentCoord.y > nextCoord.y)
		{	
			// NorthEast
			
			// If even go down in the y coord, else right in the x
			if(currentCoord.x % 2 == 0)
			{
				currentCoord.x += 1;
				currentCoord.y -= 1;
			}
		
			else
			{
				currentCoord.x += 1;
			}
			
			pathIndexes.push_back(currentCoord);
			
		} 
		
		else if(currentCoord.x < nextCoord.x && currentCoord.y == nextCoord.y)
		{
			// East
			currentCoord.x += 1;
			pathIndexes.push_back(currentCoord);
			
		}
		
		else if(currentCoord.x < nextCoord.x && currentCoord.y < nextCoord.y)
		{
			// SouthEast
			if(currentCoord.x % 2 == 0)
			{
				currentCoord.x += 1;
				pathIndexes.push_back(currentCoord);
				if(currentCoord.x != nextCoord.x && currentCoord.y < nextCoord.y)
				{
					currentCoord.x -= 1;
					currentCoord.y += 1;
					pathIndexes.push_back(currentCoord);
					
					if(currentCoord.x < nextCoord.x)
					{
						currentCoord.x += 1;
						pathIndexes.push_back(currentCoord);
					}
				}
			}
			
			else
			{
				currentCoord.x += 1;
				pathIndexes.push_back(currentCoord);
				if(currentCoord.x < nextCoord.x)
				{
					currentCoord.x += 1;
					pathIndexes.push_back(currentCoord);
					
					if(currentCoord.y < nextCoord.y)
					{
						currentCoord.x -= 1;
						currentCoord.y += 1;
						pathIndexes.push_back(currentCoord);
					}
				}
			}
		}
		
		else if(currentCoord.x == nextCoord.x && currentCoord.y < nextCoord.y)
		{	
			// South
			if(currentCoord.x % 2 == 0)
			{
				currentCoord.x += 1;
			}
			
			else
			{
				currentCoord.x -= 1;
				currentCoord.y += 1;
			}
			
			pathIndexes.push_back(currentCoord);
		}
		
		else if(currentCoord.x > nextCoord.x && currentCoord.y < nextCoord.y)
		{
			// SouthWest
			
			// If even go down in the y coord, else right in the x
			if(currentCoord.x % 2 == 0)
			{
				currentCoord.x -= 1;			
			}
			
			else
			{
				currentCoord.x -= 1;
				currentCoord.y += 1;
			}
			
			pathIndexes.push_back(currentCoord);
		}
		
		else if(currentCoord.x > nextCoord.x && currentCoord.y == nextCoord.y)
		{
			// West
			currentCoord.x -= 1;
			pathIndexes.push_back(currentCoord);
		}
		
		else if(currentCoord.x > nextCoord.x && currentCoord.y > nextCoord.y)
		{
			// NorthWest
			if(currentCoord.x % 2 == 0)
			{
				if(currentCoord.x < ShIsland::kTriGridWidth)
				{
					currentCoord.x += 1;
					currentCoord.y -= 1;
				}
				else
				{
					currentCoord.x -= 1;
				}
				
				pathIndexes.push_back(currentCoord);
				if(currentCoord.x > nextCoord.x && currentCoord.y > nextCoord.y)
				{
					currentCoord.x -= 1;
					pathIndexes.push_back(currentCoord);
					
					if(currentCoord.x > nextCoord.x)
					{
						currentCoord.x -= 1;
						pathIndexes.push_back(currentCoord);
					}
				}
			}
			
			else
			{
				currentCoord.x -= 1;
				pathIndexes.push_back(currentCoord);
				if(currentCoord.x > nextCoord.x && currentCoord.y > nextCoord.y)
				{
					currentCoord.x += 1;
					currentCoord.y -= 1;
					pathIndexes.push_back(currentCoord);
					
					if(currentCoord.x > nextCoord.x)
					{
						currentCoord.x -= 1;
						pathIndexes.push_back(currentCoord);
					}
				}
			}
			
			
			pathIndexes.push_back(currentCoord);
			
		}
		
		else
		{
			// ?
			std::cout << "Could Not Find Complete Sequence Path!";
			return subPath;
		}
	}
	
	if(currentCoord != nextCoord)
	{
		std::cout << "Could Not Find Complete Sequence Path!";
	}
	/*
	else
	{
		std::cout << "Path Created!";
	}*/
		
	
	// Next create the path of SeqTri's
	std::deque<Vec2i>::iterator indexIter = pathIndexes.begin();
	while(indexIter != pathIndexes.end())
	{
		uint32_t index = ShIsland::coordToVertex(*indexIter);
		//std::cout << index << std::endl;
		SeqTri tri(
				mTargetIsland->mPositions[index],
				mTargetIsland->mPositions[index + 1],
				mTargetIsland->mPositions[index + 2],
				*indexIter);
				
		std::cout << (*indexIter).x << ", " << (*indexIter).y << std::endl;
		subPath.push_back(tri);
		++indexIter;
	}
	
	//std::cout << "Path length: " << pathIndexes.size() << std::endl;
	
	return subPath;
}

SeqTri ShSeqPath::triFromIslandPosition(uint32_t x, uint32_t y)
{
	uint32_t index = x + (y * ShIsland::kTriGridWidth);
	
	SeqTri islandTri(mTargetIsland->mPositions[index],
		mTargetIsland->mPositions[index+1],
		mTargetIsland->mPositions[index+2]
	);
	
	return islandTri;
}

/*
 *  ShSeqPath.h
 *  Shoggoth
 *
 *  Created by Chad McKinney on 2/24/12.
 *
 */
#pragma once

#include <deque>
#include <set>

#include "cinder/gl/Vbo.h"
#include "cinder/gl/gl.h"
#include "cinder/Vector.h"
#include "src/ShAbstractSequence.h"

class ShIsland;

//////////
// ShTri
/////////

class ShTri {
	
public:
	
	ShTri(cinder::Vec3f _v0 = cinder::Vec3f::zero(), cinder::Vec3f _v1 = cinder::Vec3f::zero(), 
		   cinder::Vec3f _v2 = cinder::Vec3f::zero());
	
	void setv0(cinder::Vec3f _v0);
	void setv1(cinder::Vec3f _v1);
	void setv2(cinder::Vec3f _v2);
	
	void v0(cinder::Vec3f _v0);
	void v1(cinder::Vec3f _v1);
	void v2(cinder::Vec3f _v2);
	
	cinder::Vec3f getv0();
	cinder::Vec3f getv1();
	cinder::Vec3f getv2();
	
	cinder::Vec3f v0();
	cinder::Vec3f v1();
	cinder::Vec3f v2();
	
	cinder::Vec3f c();
	cinder::Vec3f getCentroid();
	cinder::Vec3f normal();
	bool isDegenerate();
	
	inline cinder::Vec3f operator[](int v)
	{
		switch(v)
		{
			case 0:
				return vZero;
				break;
				
			case 1:
				return vOne;
				break;
				
			case 2:
				
				return vTwo;
				break;
		}
		
		return cinder::Vec3f::zero();
	}
	
	inline void fill(cinder::Vec3f v)
	{
		setv0(v);
		setv1(v);
		setv2(v);
	}
	
	inline void fill(cinder::Vec3f _v0, cinder::Vec3f _v1, cinder::Vec3f _v2)
	{
		setv0(_v0);
		setv1(_v1);
		setv2(_v2);
	}
	
	static float getDegenerateArea();
	static void setDegenerateArea(float _degenerateArea);
	
protected:
	
	static float degenerateArea;
	
	void setCentroid();
	void setNormal();
	
	cinder::Vec3f vZero, vOne, vTwo, centroid, normalVector;
};


////////////
// GridTri
////////////

class GridTri : public ShTri {
	
public:
	
	GridTri(cinder::Vec3f _v0 = cinder::Vec3f::zero(), cinder::Vec3f _v1 = cinder::Vec3f::zero(), 
            cinder::Vec3f _v2 = cinder::Vec3f::zero(), unsigned char _value = 0);
	
    void setValue(unsigned char _value);
    unsigned char toggleValue(); // Returns the current value
    unsigned char getValue();
    void draw();
    void createMesh();
	
private:
	
    uint32_t mapVertex;
    cinder::gl::VboMesh mesh;
    unsigned char value;
};

//////////
// SeqTri
//////////

class SeqTri : public ShTri {
	
public:
	
	SeqTri(cinder::Vec3f _v0 = cinder::Vec3f::zero(), cinder::Vec3f _v1 = cinder::Vec3f::zero(), 
		   cinder::Vec3f _v2 = cinder::Vec3f::zero(), cinder::Vec2i _mapCoord = cinder::Vec2f::zero());
	
    void draw();
    void createMesh();

	void setMapCoord(cinder::Vec2i _mapCoord);
	cinder::Vec2i getMapCoord();
	
	void setMapVertex(uint32_t _mapVertex);
	uint32_t getMapVertex();
	
private:
	
	cinder::Vec2i mapCoord;
	uint32_t mapVertex;
    cinder::gl::VboMesh mesh;
};


/////////////
// ShSeqPath
/////////////

class ShSeqPath : public ShAbstractSequence {
	
public:
	
	// Start with initial triangle
	ShSeqPath(ShIsland* targetIsland, SeqTri initialTri);
	~ShSeqPath();
	
	void step(int stepDirection = 1);
	
	void update();
	void draw();
	
	// Set the mesh positions index of the target triangle of the current chain
	void updateChainTarget(SeqTri tri);
	// Add a new event triangle to the current running chain of events that is being edited
	
	void beginSubPath(SeqTri eventTri);
	void addEventToSubPath(SeqTri eventTri);
	void finishSubPath();
	void addSubPathToChain();
	void finishChain(); // Finish the chain path and finalize it
	
	typedef std::deque<SeqTri> subpath_t;
	typedef std::deque<cinder::gl::VboMesh*> submesh_t;
	
	std::deque<SeqTri> mEventPositions;
	std::deque<subpath_t> mPathChain; // collection of paths between events
	
	ShIsland* getTargetIsland();
	cinder::ColorA getPathColor();
	void setPathColor(cinder::ColorA pathColor);
	cinder::ColorA getEventColor();
	void setEventColor(cinder::ColorA eventColor);
	
	static uint32_t seqCounter;
	
	uint32_t seqID;
	const char* seqSyncKey;
	
	std::set<uint32_t> eventSet;
	
private:
	
	void addMeshIndex(uint32_t x, uint32_t y);
	void createSubPathMesh(subpath_t* subPath); // Create the initial mesh
	subpath_t pathFind(SeqTri* startTri, SeqTri* targetTri); //create a new subpath
	SeqTri triFromIslandPosition(uint32_t x, uint32_t y);
	
	int mTriCount;
	int mVertexCount;
	
	submesh_t mMeshChain;
	cinder::gl::VboMesh mPathMesh;
	//cinder::gl::VboMesh mEvents;
	std::deque<uint32_t> mCurrentIndices;
	ShIsland* mTargetIsland;
	cinder::ColorA mPathColor, mEventColor;
};

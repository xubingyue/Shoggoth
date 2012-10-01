/*
 *  ShIsland.h
 *  Shoggoth
 *
 *  Created by Chad McKinney on 1/17/12.
 *
 */

#pragma once

// System Includes
#include <vector>
#include <list>
#include <deque>

// Boost Includes
#include "boost/thread/shared_mutex.hpp"

// Local Includes
#include "cinder/gl/Vbo.h"
#include "cinder/gl/gl.h"
#include "cinder/Vector.h"
#include "cinder/AxisAlignedBox.h"
#include "cinder/gl/Material.h"
#include "src/Graphics/ShDiamondSquare.h"
#include "src/Graphics/ShColor.h"
#include "boost/unordered_map.hpp"
#include "src/ShIslandGrid.h"
#include "src/network/ShNetwork.h"
#include "src/Time/ShScheduler.h"

class ShTri;
class GridTri;
class SeqTri;
class ShTriangleGrid;

class ShIsland {
	
public:
	
	ShIsland(cinder::Vec3f pos, int id, cinder::Vec2i coord);
	~ShIsland();
	
	enum DrawStyle
	{
		Points,
		TriangleFill,
		TriangleFrame,
		TriangleFillAndFrame
	};
	
	bool getTriCoord(unsigned int index, SeqTri* pickedTri);
	void moveTo(cinder::Vec3f pos);
	void setup(cinder::Vec3f cameraPos);
    void update();
	void draw();
    bool isAnimating();
	cinder::Vec3f getPos();
	cinder::AxisAlignedBox3f calcBoundingBox();
	void setDetail(cinder::Vec3f pos); // Sets detail by the distance from the position
	
    static const uint16_t kGridSize = 4; // Gap between points
    static const uint16_t kGridWidth = 72; // Number of points wide
    static const uint16_t kGridDepth = 72; // Number of points deep (long)
    static const uint16_t kTriangleGridWidth = 144; // Width of the triangle grid
    static const uint16_t kTriangleGridHeight = 72; // Height of the Triangle grid
	static const uint16_t kHighDetailStep = 1; 
	static const uint16_t kMediumDetailStep = 4; // Points to step by when making the medium detail LOD mesh
	static const uint16_t kMediumLowDetailStep = 10;
	static const uint16_t kLowDetailStep = 20;
	static const uint32_t kHighDetailDistance = 0;
	static const uint32_t kMediumDetailDistance = 2000; // Distance from the camera when the MediumDetail LOD mesh is drawn
	static const uint32_t kMediumLowDetailDistance = 4000;
	static const uint32_t kLowDetailDistance = 8000;
    static uint32_t globalPickingIndex;
	
	static cinder::gl::Material material;
	
	static uint16_t kTriGridWidth;
	static uint16_t kTriGridHeight;
	static const uint8_t kNumTriPoints = 3;
	
	int mID;
	cinder::Vec2i mCoord;
	
	cinder::AxisAlignedBox3f mBoundingBox;
	std::vector<cinder::Vec3f> mPositions, mMediumDetailPositions, mMediumLowDetailPositions, mLowDetailPositions;
    static const uint32_t kNumIndexes = 31104; // Number of indexes in each island
    uint32_t initialPickingIndex;
		
    unsigned char getValue(int x, int y);
    void setValue(int x, int y, unsigned char value);
    void clearValues();
    unsigned char toggleValue(int x, int y); // returns value
    void bufferActivityColor(); // Updates the terrain color according to the triangleGrid;
    void setScheduleBufferColors(bool schedule = true);
    GridTri getTri(int x, int y);
    GridTri* getTriPointer(int x, int y);
    std::vector<unsigned char> getStepVector();
    void setTerrainHeightMap(std::vector< std::vector<float> >& heightMap, float minHeight, float maxHeight,
                             bool scheduleUpdate = true);

    void setAnimation(std::deque<animation_frame_t>& animation);

    std::vector< std::vector<float> >& getTerrainHeightMap();

    ShNetwork::algo_pair getTerrainGen();
    void setTerrainGen(ShNetwork::algo_pair terrainGen);
    ShNetwork::algo_pair getStepGen();
    void setStepGen(ShNetwork::algo_pair stepGen);

    //void updateGridColor(x, y); // Updates the grid color for a trianges
    //void updateGridColors(std::vector<int, )

    static inline uint8_t pickingIndexToIslandID(uint32_t index)
    {
        return index / kNumIndexes;
    }
	
	static inline cinder::Vec2i vertexToCoord(uint32_t vertex)
	{
		//int coord = vertex / 3;
		return cinder::Vec2i((vertex % (kTriGridWidth * kNumTriPoints)) / kNumTriPoints, 
							 (int) (vertex / kNumTriPoints / kTriGridWidth));
	}
	
	static inline uint32_t coordToVertex(cinder::Vec2i coord)
	{
		return (coord.x * kNumTriPoints) + (coord.y * (kTriGridWidth * kNumTriPoints)); 
	}
		
	enum Detail {
		High,
		Medium,
		MediumLow,
		Low
	};
	
private:
	
	void createIsland(cinder::Vec3f pos);
	void createCube(int size, cinder::Vec3f pos);
	void addMeshIndex(std::vector<cinder::Vec3f>& positionVector, int x, int y);
	void createTerrainMesh(DrawStyle style);
    void fillPositionsVector(std::vector<cinder::Vec3f>& positionVector);
    void calculateMinMax(std::vector<cinder::Vec3f>& positionVector);
	cinder::gl::VboMesh createLODMesh(DrawStyle style, uint16_t stepSize, std::vector<cinder::Vec3f>& positionVector);
	void buildTriangleMap();
	void buildTriangleGrid();
    void rebuildTriangleGrid();
    void deleteTriangleGrid();
	void bufferColors(cinder::gl::VboMesh& mesh, uint32_t vertexCount, uint16_t stepSize);
	void createCustomStaticData(cinder::gl::VboMesh::Layout* layout);
	void populateCustomData(cinder::gl::VboMesh& mesh, std::vector<cinder::Vec3f>& positionVector);
	void bindCustomData(cinder::gl::VboMesh& mesh);
	void calculateNormals(cinder::gl::VboMesh& mesh, std::vector<cinder::Vec3f>& positionVector); 
    void synchronizedAnimationQueuePop();
	cinder::ColorA createVertexColor(int vertex, int maxWidth, int maxHeight, int maxDepth, int hue);
	int mTriCount;
	int mVertexCount;
	cinder::Vec3f mPos;
	cinder::Vec3f mCenterPos; // Position of the CENTER of the terrain. used for LOD drawing
	
    GridTri* triangleGrid[kTriangleGridWidth][kTriangleGridHeight];
    std::vector<unsigned char> stepVector;
    boost::shared_mutex mMutex;

    float mMinHeight, mMaxHeight, mMaxX, mMaxZ;
	
	cinder::gl::VboMesh mSurface, mSurfaceMediumDetail, mSurfaceMediumLowDetail, mSurfaceLowDetail;
	std::vector<uint32_t> mCurrentIndices;
	std::vector<cinder::ColorA> mColors;
    cinder::ColorA mDefaultColor;
	std::vector<GLfloat> mP0_Swizz;
	std::vector<cinder::Vec4f> mP1_3d;
	std::vector<cinder::Vec4f> mP2_3d;
    std::vector< std::vector<float> > mTerrainHeightMap;
    std::deque<animation_frame_t> mAnimationQueue;
	ShDiamondSquare mTerrain;
    ShNetwork::algo_pair mTerrainGen;
    ShNetwork::algo_pair mStepGen;
	
	//boost::unordered_map<unsigned int, unsigned int> triangleMap;
	
	GLfloat* mDiffuseMaterial;
	GLfloat* mMatSpecular;
	uint16_t mRandColor;
	Detail mDetail;
	float mDistance; // Distance from camera. Used for LOD
    bool scheduleBufferColors, scheduleBufferPositions;
};

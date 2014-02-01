/*
 *  ShIslandGrid.h
 *  Shoggoth
 *
 *  Created by Chad McKinney on 4/18/12.
 */
#pragma once

// System includes
#include <iostream>
#include <deque>
//#include <tr1/shog::unordered_map>
#include "shogtypes.h"
#include <vector>

// Cinder includes
#include "cinder/gl/gl.h"

// Boost includes
#include "boost/thread/shared_mutex.hpp"

// Shoggoth includes
#include "src/Time/ShScheduler.h"
#include "src/Graphics/ShSnakeRange.h"

class ShIsland;
class SeqTri;
class AnimationTimer;

typedef std::vector< std::vector<float> > height_map_t;

class ShIslandGrid : public ShAbstractSequence
{
	
public:
	
	ShIslandGrid();
	~ShIslandGrid();
	
    void reset();
    void cleanup();
    void drawIslands();
    void drawSnakeRanges(bool drawActive);
    void drawSnakeRangeHilight();
    void drawSnakeRangNames();
	void drawBoundingBoxes();
    void drawBoundingBox(int id);
	void setup(cinder::Vec3f cameraPos);
    void update();
    void createWaveTerrainBuffers();
    void freeWaveTerrainBuffers();
    bool getTriCoor(int id, unsigned int index, SeqTri* pickedTri);
    snake_range_id_t addShSnakeRange(int islandID, std::string synthName, cinder::Vec2i corner1,
                                     cinder::Vec2i corner2, bool addTimeEvent = true, bool sendToNetwork = false);
    void addShSnakeRange(snake_range_id_t snakeID, std::string synthName, cinder::Vec2i corner1,
                         cinder::Vec2i corner2, bool addTimeEvent = true, bool sendToNetwork = false);
    void removeSnakeRange(snake_range_id_t snakeID, bool addTimeEvent = true, bool sendToNetwork = false);
    void removeCurrentlySelectedSnakeRange();
    void setSnakeRangePosition(snake_range_id_t snakeID, cinder::Vec2i corner, bool addTimeEvent = true,
                               bool sendToNetwork = false);
    void setSnakeRangeCorner(snake_range_id_t snakeID, cinder::Vec2i corner, bool addTimeEvent = true, bool sendToNetwork = false);
    snake_range_id_t getCurrentlySelectedSnakeRangeID();
    void setSelectedSnakeRange(unsigned int id);
    int getNumSnakeRanges();
    void removeAllSnakeRanges();
    virtual void step(int stepDirection = 1);
	
	ShIsland* getIsland(int x, int y);
	ShIsland* getIsland(int id);
    ShIsland** getIslands();
    ShNetwork::algo_pair getIslandStepGen(int id);
    ShNetwork::algo_pair getIslandHeightGen(int id);

    // Terrain Step Generation
    void emptySteps(int id, bool addTimeEvent = true);
    void diamondSquareSteps(int id, unsigned char seed, bool addTimeEvent = true);
    void wolframCASteps(int id, unsigned char ruleSet, bool addTimeEvent = true);
    void strangeSteps(int id, unsigned char seed, bool addTimeEvent = true);
    void lSystemSteps(int id, unsigned char seed, bool addTimeEvent = true);
    void flockingSteps(int id, unsigned char seed, bool addTimeEvent = true);

    void gameOfLife(int id);

    // Terrain Heigh Map Generation
    void emptyHeights(int id, bool addTimeEvent = true);
    void diamondSquareHeights(int id, unsigned char seed, bool addTimeEvent = true);
    void wolframHeights(int id, unsigned char seed, bool addTimeEvent = true);
    void strangeHeights(int id, unsigned char seed, bool addTimeEvent = true);
    void lSystemHeights(int id, unsigned char seed, bool addTimeEvent = true);
    void flockingHeights(int id, unsigned char seed, bool addTimeEvent = true);

    // Height Map setting (used for animation thread)
    void setTerrainHeightMap(int id, height_map_t& heightMap, float minHeight, float maxHeight);
    void setAnimation(int id, std::deque<animation_frame_t>& animation);
    void removeAnimationTimer(std::string name);
    void addAnimationTimer(std::string name, AnimationTimer* timer);
    void createIslandAnimation(int id, height_map_t& newTerrain, float minHeight, float maxHeight);
	
	static const int GRID_WIDTH = 2;
	static const int GRID_HEIGHT = 2;
	static const int NUM_ISLANDS = 4;
	static const int SPACING = 10; // Distance between the islands in space
	
	static inline cinder::Vec2i idToCoord(int id)
	{
		return cinder::Vec2i(id % GRID_WIDTH, (int) (id / GRID_HEIGHT));
    }
	
	static inline int coordToID(int x, int y)
	{
		return x + (y * GRID_WIDTH);
    }
	
	static inline int coordToID(cinder::Vec2i coord)
	{
		return coord.x + (coord.y * GRID_WIDTH);
    }
		
private:

    unsigned int snakeRangeIDCounter;
	
	void createIslands();
    void queueDeleteSnakeRange(ShSnakeRange* snakeRange);
	
	ShIsland** islands;
	ShIsland* grid[GRID_WIDTH][GRID_HEIGHT];
    boost::shared_mutex mutex;
    shog::unordered_map<std::string, AnimationTimer*> animationTimers;
    std::vector<ShSnakeRange*> snakeRangeGrid[NUM_ISLANDS];
    shog::unordered_map<unsigned int, ShSnakeRange*> snakeRangeMap; // For quick lookup
    std::deque<ShSnakeRange*> deleteSnakeQueue;
    unsigned int selectedSnakeRange;
};

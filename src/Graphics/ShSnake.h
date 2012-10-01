/*
 *  ShSnake.h
 *  Shoggoth
 *
 *  Created by Chad McKinney on 4/22/12.
 *
 */
#pragma once

#include <deque>
#include <vector>

#include "cinder/gl/gl.h"
#include "cinder/gl/Vbo.h"
#include "cinder/Color.h"
#include "src/Graphics/ShSeqPath.h"

class ShIsland;

class ShSnake {

public:
	
    static const int SEGMENTS = 15;
	static cinder::gl::VboMesh MESH[SEGMENTS];
	static std::vector<cinder::Vec3f> positions[SEGMENTS];
	static std::vector<cinder::Vec3f> normals[SEGMENTS];
	static std::vector<cinder::ColorA> colors[SEGMENTS];
	
	static void createMesh(); // create the global mesh 
	
	ShSnake(ShIsland* island);
	
	void setGridPositions(std::deque<cinder::Vec2i> gridPositions);
	const std::deque<cinder::Vec2i>& getGridPositions();
	
	void update();
	void draw();
	void increment();
	
private:
	
	int mDirection; // Just for the demo path;
	std::deque<cinder::Vec2i> mGridPositions;
    std::deque<GridTri> mTriQueue;
	ShIsland* mIsland;
};

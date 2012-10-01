/*
 *  ShSnakePit.h
 *  Shoggoth
 *
 *  Created by Chad McKinney on 4/23/12.
 *
 */
#pragma once
#include <vector>

#include "boost/thread/shared_mutex.hpp"
#include "src/Graphics/ShSnake.h"
#include "src/ShIslandGrid.h"
#include "src/ShAbstractSequence.h"

/** synchronized snake access */
class ShSnakePit : public ShAbstractSequence {
	
public:
	
	ShSnakePit();
	~ShSnakePit();
	
	void add(int islandNum, ShSnake* snake); // The snake pit takes ownership after this
	void draw();
	void step(int stepDirection = 1);
	
private:
	
	boost::shared_mutex mMutex;
	std::vector<ShSnake*> mSnakes[ShIslandGrid::NUM_ISLANDS];
};

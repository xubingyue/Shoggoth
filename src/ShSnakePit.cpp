/*
 *  ShSnakePit.cpp
 *  Shoggoth
 *
 *  Created by Chad McKinney on 4/23/12.
 *  Copyright 2012 __MyCompanyName__. All rights reserved.
 *
 */
#include "src/ShSnakePit.h"

ShSnakePit::ShSnakePit()
{
	
}

ShSnakePit::~ShSnakePit()
{
	boost::shared_lock<boost::shared_mutex> lock(mMutex);
	
	for(int i = 0; i < ShIslandGrid::NUM_ISLANDS; ++i)
	{
		for(int j = 0; j < mSnakes[i].size(); ++j)
		{
			delete mSnakes[i][j];
		}
	}
}

void ShSnakePit::add(int islandNum, ShSnake* snake)
{
	boost::shared_lock<boost::shared_mutex> lock(mMutex);
	
	mSnakes[islandNum].push_back(snake);
}

void ShSnakePit::draw()
{
	boost::shared_lock<boost::shared_mutex> lock(mMutex);
	
	for(int i = 0; i < ShIslandGrid::NUM_ISLANDS; ++i)
	{
		for(int j = 0; j < mSnakes[i].size(); ++j)
		{
			mSnakes[i][j]->draw();
		}
	}
}

void ShSnakePit::step(int stepDirection)
{
	boost::shared_lock<boost::shared_mutex> lock(mMutex);
	
	for(int i = 0; i < ShIslandGrid::NUM_ISLANDS; ++i)
	{
		for(int j = 0; j < mSnakes[i].size(); ++j)
		{
			mSnakes[i][j]->increment();
		}
	}
}

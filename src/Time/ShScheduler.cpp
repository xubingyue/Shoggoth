/*
 *  ShScheduler.cpp
 *  Shoggoth
 *
 *  Created by Chad McKinney on 3/5/12.
 *
 */

// System includes
#include <iostream>

// Shoggoth includes
#include "src/Time/ShScheduler.h"
#include "src/Graphics/ShIsland.h"
#include "src/ShGlobals.h"

///////////////
// ShScheduler
///////////////

ShScheduler::ShScheduler()
{

}

ShScheduler::~ShScheduler()
{

}


void ShScheduler::advance(boost::chrono::steady_clock::time_point time)
{
    this->time = time;
}

/////////////////
// StepScheduler
/////////////////

uint64_t StepScheduler::MAX_STEPS = ShIsland::kGridWidth * ShIsland::kGridDepth;

StepScheduler::StepScheduler(boost::chrono::steady_clock::duration _stepQuant,
                         boost::unordered_set<ShAbstractSequence*>* _scheduleSet) :
	stepQuant(_stepQuant),
	currentStep(0),
	scheduleSet(_scheduleSet)
{
	
}

StepScheduler::~StepScheduler()
{

}

void StepScheduler::setStepQuant(boost::chrono::steady_clock::duration _stepQuant)
{
	stepQuant = _stepQuant;
}

void StepScheduler::advance(boost::chrono::steady_clock::time_point time)
{
    if(scheduleSet != NULL)
    {
        boost::unordered_set<ShAbstractSequence*>::iterator eventIter = scheduleSet->begin();
        while(eventIter != scheduleSet->end())
        {
            (*eventIter)->step(1);
            ++eventIter;
        }
    }

    ShScheduler::advance(time);
}

///////////////////////
// TimeStreamScheduler
///////////////////////

TimeStreamScheduler::TimeStreamScheduler(ShTimeStream *currentTimeStream) :
    currentTimeStream(currentTimeStream)
{

}

TimeStreamScheduler::~TimeStreamScheduler()
{

}

void TimeStreamScheduler::advance(boost::chrono::steady_clock::time_point time)
{
    boost::upgrade_lock<boost::shared_mutex> lock(mutex);
    boost::upgrade_to_unique_lock<boost::shared_mutex> writeLock(lock);

     // Move the time for the currentTimeStream, which might return a different time stream (possibly a parent or child branch)
    currentTimeStream = currentTimeStream->moveCurrentTime(time, false);
    ShScheduler::advance(time);
}

void TimeStreamScheduler::setCurrentTimeStream(ShTimeStream* newTimeStream)
{
    boost::upgrade_lock<boost::shared_mutex> lock(mutex);
    boost::upgrade_to_unique_lock<boost::shared_mutex> writeLock(lock);
    currentTimeStream = newTimeStream;
}

ShTimeStream* TimeStreamScheduler::getCurrentTimeStream()
{
    boost::shared_lock<boost::shared_mutex> lock(mutex);
    return currentTimeStream;
}

const ShTimeStream* TimeStreamScheduler::addTimeEvent(ShTimeEvent* timeEvent)
{
    boost::upgrade_lock<boost::shared_mutex> lock(mutex);
    boost::upgrade_to_unique_lock<boost::shared_mutex> writeLock(lock);
    currentTimeStream = currentTimeStream->addTimeEvent(timeEvent);
    return currentTimeStream;
}


//////////////////////
// AnimationScheduler
//////////////////////

AnimationScheduler::AnimationScheduler(int islandID, height_map_t &beginTerrain, height_map_t &endTerrain,
                                       float endMinHeight, float endMaxHeight) :
    islandID(islandID),
    beginTerrain(beginTerrain),
    endTerrain(endTerrain),
    done(false),
    endMinHeight(endMinHeight),
    endMaxHeight(endMaxHeight)
{

}

AnimationScheduler::~AnimationScheduler()
{

}

void AnimationScheduler::advance(boost::chrono::steady_clock::time_point time)
{
    /*
    // Set the height map to the current animation frame (Height map, Min Height, Max Height)
    ShGlobals::ISLAND_GRID->setTerrainHeightMap(islandID, currentFrame->get<0>(), currentFrame->get<1>(), currentFrame->get<2>());

    if(currentFrame == islandAnimationQueue.end())
    {
        done = true;
    }

    else
    {
        ++currentFrame;
    }*/

    ShGlobals::ISLAND_GRID->setAnimation(islandID, islandAnimationQueue);
    done = true;
}

bool AnimationScheduler::isDone()
{
    return this->done;
}

void AnimationScheduler::generateAnimation()
{
    try
    {
        height_map_t differenceVector;
        height_map_t animationFrame;

        for(int x = 0; x < ShIsland::kGridWidth; ++x)
        {
            differenceVector.push_back(std::vector<float>());
            animationFrame.push_back(std::vector<float>());

            for(int y = 0; y < ShIsland::kGridDepth; ++y)
            {
                differenceVector[x].push_back((endTerrain[x][y] - beginTerrain[x][y]) / (float) AnimationScheduler::NUM_STEPS);
                animationFrame[x].push_back(0);
            }
        }

        //islandAnimationQueue.push_front(animation_frame_t(endTerrain, endMinHeight, endMaxHeight));

        for(int i = 0; i < AnimationScheduler::NUM_STEPS; ++i)
        {
            float initialHeight = endTerrain.front().front();
            float minHeight = initialHeight;
            float maxHeight = initialHeight;

            for(int x = 0; x < ShIsland::kGridWidth; ++x)
            {
                for(int y = 0; y < ShIsland::kGridDepth; ++y)
                {
                    float height = beginTerrain[x][y] + (differenceVector[x][y] * (float) i);

                    if(minHeight > height)
                        minHeight = height;
                    if(maxHeight < height)
                        maxHeight = height;

                    animationFrame[x][y] = height;
                }
            }

            islandAnimationQueue.push_back(animation_frame_t(animationFrame, minHeight, maxHeight));
        }

        islandAnimationQueue.push_back(animation_frame_t(endTerrain, endMinHeight, endMaxHeight));
        //currentFrame = islandAnimationQueue.begin();
    }

    catch(...)
    {
        std::cout << "Island Animation Generation Catch!!!" << std::endl;
        islandAnimationQueue.clear();
        islandAnimationQueue.push_front(animation_frame_t(endTerrain, 0, 1));
    }
}









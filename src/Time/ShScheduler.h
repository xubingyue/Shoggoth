/*
 *  ShScheduler.h
 *  Shoggoth
 *
 *  Created by Chad McKinney on 3/5/12.
 *
 */

#pragma once

// System includes
#include <vector>
#include <deque>

// Boost includes
#include "boost/unordered_set.hpp"
#include "boost/function.hpp"
#include "boost/tuple/tuple.hpp"
#include "boost/thread/shared_mutex.hpp"

// Shoggoth includes
#include "src/ShAbstractSequence.h"
#include "src/Time/ShTimer.h"
#include "src/Time/shtimestream.h"

class ShIsland;
typedef std::vector< std::vector<float> > height_map_t;
typedef boost::tuples::tuple<height_map_t, float, float> animation_frame_t; // Height Map, Min Height, Max Height
enum AnimationTupleType
{
    HeightMap = 0,
    MinHeight = 1,
    MaxHeight = 2
};

///////////////
// ShScheduler
///////////////

class ShScheduler {

public:

    ShScheduler();
    virtual ~ShScheduler();

    virtual void advance(boost::chrono::steady_clock::time_point time);

private:

    boost::chrono::steady_clock::time_point time;
};

/////////////////
// StepScheduler
/////////////////

class StepScheduler : public ShScheduler {
	
public:
	
    StepScheduler(boost::chrono::steady_clock::duration _stepQuant,
                boost::unordered_set<ShAbstractSequence*>* _scheduleSet = NULL);

    ~StepScheduler();
	
    void setStepQuant(boost::chrono::steady_clock::duration = boost::chrono::seconds(1));
    void advance(boost::chrono::steady_clock::time_point time);
	
	
private:
		
	// Maximum number of steps in a possible sequence, use this as a modulo point to reset currentStep to 0
	static uint64_t MAX_STEPS;
	
	boost::unordered_set<ShAbstractSequence*>* scheduleSet;
	
    int currentStep;
    boost::chrono::steady_clock::duration stepQuant;
};


///////////////////////
// TimeStreamScheduler
///////////////////////


class TimeStreamScheduler : public ShScheduler {

public:

    TimeStreamScheduler(ShTimeStream* currentTimeStream);
    ~TimeStreamScheduler();

    void advance(boost::chrono::steady_clock::time_point time);

    void setCurrentTimeStream(ShTimeStream* newTimeStream);
    ShTimeStream* getCurrentTimeStream();

    // returns the time stream that the new event will belong to.
    // If the event happens after the last event, then the current ShTimeStream is returned, otherwise a new time stream is returned
    const ShTimeStream* addTimeEvent(ShTimeEvent* timeEvent);

private:

    ShTimeStream* currentTimeStream;
    boost::shared_mutex mutex;
};


//////////////////////
// AnimationScheduler
//////////////////////

class AnimationScheduler : public ShScheduler {

public:

    AnimationScheduler(int islandID, height_map_t& beginTerrain, height_map_t& endTerrain, float endMinHeight, float endMaxHeight);
    ~AnimationScheduler();

    void advance(boost::chrono::steady_clock::time_point time);
    bool isDone();

    static const int NUM_STEPS = 30;

    void generateAnimation();

private:

    int islandID;
    std::deque<animation_frame_t> islandAnimationQueue;
    std::deque<animation_frame_t>::iterator currentFrame;
    height_map_t beginTerrain;
    height_map_t endTerrain;
    bool done;
    float endMinHeight, endMaxHeight;
};

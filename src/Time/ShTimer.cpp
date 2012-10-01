/*
 *  ShTimer.cpp
 *  Shoggoth
 *
 *  Created by Chad McKinney on 3/6/12.
 */

// System includes
#include <iostream>

// Boost includes
#include "boost/bind.hpp"

// Shoggoth includes
#include "src/Time/ShTimer.h"
#include "src/Time/ShScheduler.h"
#include "src/shmath.h"
#include "src/ShGlobals.h"

///////////
// ShTimer
///////////

ShTimer::ShTimer(ShScheduler *_scheduler, boost::chrono::milliseconds _stepQuant) :
    scheduler(_scheduler),
    running(false),
    timerThread(NULL)
{
    creationTime = clock.now();
    offsetTime = boost::chrono::steady_clock::time_point(boost::chrono::milliseconds(0));
    // The time according to the outside world is equal to time - creationTime + offsetTime.
    // we subtract the creationTime so that we're always starting from 0
    // We add the offset time so that our time in the timestream is where the user wants it to be
    setStepQuant(_stepQuant);
}

ShTimer::~ShTimer()
{
    if(running)
    {
        stop();
    }
}

void ShTimer::start()
{
    setRunning(true);

    boost::upgrade_lock<boost::shared_mutex> lock(timerMutex);
    boost::upgrade_to_unique_lock<boost::shared_mutex> writeLock(lock);
    creationTime = lastStepTime = time = clock.now();
    offsetTime = boost::chrono::steady_clock::time_point(boost::chrono::milliseconds(0));
    timerThread = new boost::thread(boost::bind(&ShTimer::run, this));
}

void ShTimer::run()
{
    while(running)
    {
        calculateEpoch();
        boost::this_thread::sleep(boost::posix_time::milliseconds(10));
    }

    timerThread->join();
}

void ShTimer::stop()
{
    boost::upgrade_lock<boost::shared_mutex> lock(timerMutex);
    boost::upgrade_to_unique_lock<boost::shared_mutex> writeLock(lock);
    running = false;
    //std::cout << "ShTimer FINISHED JOIN" << std::endl;
    //std::cout << "ShTimer stopped" << std::endl;
}

void ShTimer::setScheduler(ShScheduler* _scheduler)
{
    boost::upgrade_lock<boost::shared_mutex> lock(timerMutex);
    boost::upgrade_to_unique_lock<boost::shared_mutex> writeLock(lock);
    scheduler = _scheduler;
}

void ShTimer::calculateEpoch()
{
    boost::upgrade_lock<boost::shared_mutex> lock(timerMutex);
    boost::upgrade_to_unique_lock<boost::shared_mutex> writeLock(lock);

    time = clock.now();

    // if the current time is greater than our step quantization, advance the scheduler
    if((time - lastStepTime) > stepQuant)
    {
        scheduler->advance(boost::chrono::steady_clock::time_point(time - creationTime + offsetTime));
        lastStepTime = time;
    }
}


boost::chrono::steady_clock::time_point ShTimer::getTime()
{
    boost::shared_lock<boost::shared_mutex> lock(timerMutex);
    return boost::chrono::steady_clock::time_point(time - creationTime + offsetTime);
}

void ShTimer::setTime(boost::chrono::steady_clock::time_point newTime)
{
    boost::upgrade_lock<boost::shared_mutex> lock(timerMutex);
    boost::upgrade_to_unique_lock<boost::shared_mutex> writeLock(lock);
    offsetTime = newTime - (time - creationTime);
}

boost::chrono::milliseconds ShTimer::getEpochQuant()
{
    boost::shared_lock<boost::shared_mutex> lock(timerMutex);
    return epochQuant;
}

boost::chrono::milliseconds ShTimer::getStepQuant()
{
    boost::shared_lock<boost::shared_mutex> lock(timerMutex);
    return stepQuant;
}

void ShTimer::setStepQuant(boost::chrono::milliseconds _stepQuant)
{
    boost::upgrade_lock<boost::shared_mutex> lock(timerMutex);
    boost::upgrade_to_unique_lock<boost::shared_mutex> writeLock(lock);

    if(_stepQuant == boost::chrono::seconds(0))
    {
        stepQuant = boost::chrono::seconds(1);
        std::cout << "ShTimer: You can't have a stepQuant of size 0. Set to 1 second" << std::endl;
    }

    stepQuant = _stepQuant;
    epochQuant = boost::chrono::milliseconds(10);
}

bool ShTimer::getRunning()
{
    boost::shared_lock<boost::shared_mutex> lock(timerMutex);
    return running;
}

void ShTimer::setRunning(bool _running)
{
    boost::upgrade_lock<boost::shared_mutex> lock(timerMutex);
    boost::upgrade_to_unique_lock<boost::shared_mutex> writeLock(lock);
    running = _running;
}

///////////////////////
// AnimationScheduler
///////////////////////

AnimationTimer::AnimationTimer(AnimationScheduler* _scheduler, boost::chrono::milliseconds _stepQuant) :
    ShTimer(_scheduler, _stepQuant)
{
    name = boost::to_string(getTime());
}

AnimationTimer::~AnimationTimer()
{
    if(running)
    {
        stop();
    }

    delete scheduler;
}

std::string AnimationTimer::getName()
{
    boost::upgrade_lock<boost::shared_mutex> lock(timerMutex);
    return name;
}

void AnimationTimer::calculateEpoch()
{
    ShTimer::calculateEpoch();

    boost::upgrade_lock<boost::shared_mutex> lock(timerMutex);
    if(static_cast<AnimationScheduler*>(scheduler)->isDone())
    {
        stop(); // If done, stop ourselves
    }
}

void AnimationTimer::run()
{
    static_cast<AnimationScheduler*>(scheduler)->generateAnimation();
    ShTimer::run();
    ShGlobals::ISLAND_GRID->removeAnimationTimer(name); // Clean up when we're done
}


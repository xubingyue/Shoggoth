/*
 *  ShTimer.h
 *  Shoggoth
 *
 *  Created by Chad McKinney on 3/6/12.
 *
 */

#pragma once

#include "boost/shared_ptr.hpp"
#include "boost/thread.hpp"
#include "boost/thread/shared_mutex.hpp"
#include "boost/timer.hpp"
#include "boost/chrono.hpp"
#include "boost/chrono/time_point.hpp"

class ShScheduler;
class AnimationScheduler;

////////////
// ShTimer
////////////

// Step based timer with drift correction and forward/reverse time
class ShTimer {

public:
	
    ShTimer(ShScheduler* _scheduler,
            boost::chrono::milliseconds _stepQuant = boost::chrono::milliseconds(1000000000));
    virtual ~ShTimer();
	
	void start();
    virtual void run();
	void stop();
    void setScheduler(ShScheduler* _scheduler);
	
    boost::chrono::steady_clock::time_point getTime();
    void setTime(boost::chrono::steady_clock::time_point newTime);
    boost::chrono::milliseconds getEpochQuant();
    boost::chrono::milliseconds getStepQuant();
    void setStepQuant(boost::chrono::milliseconds _stepQuant);
	
	bool running;
	
	bool getRunning();
	void setRunning(bool _running);
	
protected:
	
    boost::chrono::steady_clock::time_point time, creationTime, offsetTime;
    boost::chrono::milliseconds epochQuant, stepQuant;
    boost::chrono::steady_clock::time_point lastStepTime;
	
    virtual void calculateEpoch();
	
    boost::timer timer;
    boost::chrono::steady_clock clock;
	boost::thread* timerThread;
	boost::shared_mutex timerMutex;
	ShScheduler* scheduler;
};

//////////////////
// AnimationTimer
//////////////////

class AnimationTimer : public ShTimer {
public:

    AnimationTimer(AnimationScheduler* _scheduler,
                   boost::chrono::milliseconds _stepQuant = boost::chrono::milliseconds(33));

    ~AnimationTimer();

    std::string getName();
    virtual void run();

protected:

    virtual void calculateEpoch();

    std::string name;
};

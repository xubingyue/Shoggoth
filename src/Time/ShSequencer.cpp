/*
 *  ShSequencer.cpp
 *  Shoggoth
 *
 *  Created by Chad McKinney on 3/6/12.
 *
 */
#include <iostream>
#include "src/Time/ShSequencer.h"
#include "boost/foreach.hpp"
#include "boost/bind.hpp"

#include "src/ShGlobals.h"

ShSequencer::ShSequencer(boost::chrono::milliseconds _stepQuant) :
	stepQuant(_stepQuant),
	scheduler(stepQuant, &sequenceSet),
	timer(&scheduler, stepQuant)
{
	isPlaying = false;
    ShGlobals::SEQUENCER = this;
}

ShSequencer::~ShSequencer()
{
	if(isPlaying)
		stop();
	
	sequenceSet.clear();
}

void ShSequencer::play()
{
	//scheduler = new ShScheduler(stepQuant, &sequenceSet);
	
	//timer = new ShTimer(scheduler, stepQuant);
	timer.setStepQuant(stepQuant);
	timer.start();
	isPlaying = true;
}

void ShSequencer::pause()
{
	// NOT IMPLEMENTED YET
}

void ShSequencer::stop()
{	
	timer.stop();
	isPlaying = false;
	std::cout << "ShSequencer stopped" << std::endl;
}

// Set the step quantization of the sequencer, this can be positive OR negative, but NOT 0
void ShSequencer::setStepQuant(boost::chrono::milliseconds _stepQuant)
{
	stepQuant = _stepQuant;
	scheduler.setStepQuant(stepQuant);
	timer.setStepQuant(stepQuant);
}

boost::chrono::milliseconds ShSequencer::getStepQuant()
{
    return stepQuant;
}

/*
 *  ShAudioSequence.cpp
 *  Shoggoth
 *
 *  Created by Chad McKinney on 3/6/12.
 *
 */
#include "src/Audio/ShAudioSequence.h"
#include "Server.h"
#include "Node.h"
#include <iostream>

using namespace sc;

ShAudioSequence::ShAudioSequence(const char* _synthDefName, std::set<uint32_t> _eventSet) :
	synthDefName(_synthDefName),
	currentStep(0),
	eventSet(_eventSet)
{
	std::set<uint32_t>::iterator setIter = eventSet.begin();
	finalStep = *setIter;
	while(setIter != eventSet.end())
	{
		if(*setIter > finalStep)
			finalStep = *setIter;
		++setIter;
	}
}

// step forward (positive) or backward (negative)
void ShAudioSequence::step(int stepDirection)
{	
	if(stepDirection > 0)
	{
		currentStep = (currentStep + 1) % finalStep;
	}
	
	else
	{
		--currentStep;
		if(currentStep < 0)
			currentStep += finalStep;
	};
	
	std::set<uint32_t>::iterator eventIter = eventSet.find(currentStep);
	if(eventIter != eventSet.end())
		play(); // If the current step is an event, play the synth
	//std::cout << eventSet.size() << std::endl;
}

// play a synth with the settings for the given step
void ShAudioSequence::play()
{
	Synth::grain(
				 synthDefName, 
				 ARGS("freq", (double) (20.0f * currentStep))
				);
	//std::cout << "Play Synth: " << synthDefName << std::endl;
}

/*
 *  ShAudioSequence.h
 *  Shoggoth
 *
 *  Created by Chad McKinney on 3/6/12.
 *
 */

#include <set>

#include "src/ShAbstractSequence.h"

class ShAudioSequence : public ShAbstractSequence {
	
public: 
	
	ShAudioSequence(const char* _synthDefName, std::set<uint32_t> _eventSet);
	
	// step forward (positive) or backward (negative)
	void step(int stepDirection = 1);
	
	// Typedef for pointer to step function
	//int (ShAudioSequence::*stepPtr) (int stepDirection) = &ShAudioSequence::step;
	
private:
	
	// play a synth with the settings for the given step
	void play();
	
	std::set<uint32_t> eventSet;
	uint32_t currentStep;
	const char* synthDefName;
	uint32_t finalStep;
};

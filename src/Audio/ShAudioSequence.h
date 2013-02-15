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
	
    ShAudioSequence(const char* _synthDefName, std::set<unsigned int> _eventSet);
	
	// step forward (positive) or backward (negative)
	void step(int stepDirection = 1);
	
	// Typedef for pointer to step function
	//int (ShAudioSequence::*stepPtr) (int stepDirection) = &ShAudioSequence::step;
	
private:
	
	// play a synth with the settings for the given step
	void play();
	
    std::set<unsigned int> eventSet;
    unsigned int currentStep;
	const char* synthDefName;
    unsigned int finalStep;
};

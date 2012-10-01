/*
 *  ShSequencer.h
 *  Shoggoth
 *
 *  Created by Chad McKinney on 3/6/12.
 *
 */
#pragma once

#include "src/Time/ShTimer.h"
#include "src/Time/ShScheduler.h"
#include "src/ShAbstractSequence.h"
#include "boost/unordered_set.hpp"

// For attaching member functions
 #define CALL_MEMBER_FN(object,ptrToMember)  ((object).*(ptrToMember))

class ShSequencer {
	
public:
	
    ShSequencer(boost::chrono::milliseconds _stepQuant = boost::chrono::milliseconds(100));
	~ShSequencer();
	
	void play();
	void pause();
	void stop();
	
	// Set the step quantization of the sequencer, this can be positive OR negative, but NOT 0
    void setStepQuant(boost::chrono::milliseconds _stepQuant);
    boost::chrono::milliseconds getStepQuant();
	
	// Add a new audio sequence from a given ShSeqPath, then add both to the scheduler for scheduling
	inline void scheduleSequence(ShAbstractSequence* sequence)
	{
		sequenceSet.insert(sequence);
	}
	
	inline void removeSequence(ShAbstractSequence* sequence)
	{
		sequenceSet.erase(sequence);
	}
	
	bool isPlaying;
	
private:
	
	ShTimer timer;
    StepScheduler scheduler;
	boost::unordered_set<ShAbstractSequence*> sequenceSet;
    boost::chrono::milliseconds stepQuant;
};

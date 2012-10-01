/*
 *  ShAbstractSequence.h
 *  Shoggoth
 *
 *  Created by Chad McKinney on 3/6/12.
 *
 */
#pragma once

// Abstract class that all classes that will be scheduled and sequenced must inherit from
class ShAbstractSequence {

public:
	
	virtual void step(int stepDirection = 1) = 0;
};
/*
 *  ShDiamondSquare.h
 *  Shoggoth
 *
 *  Created by Chad McKinney on 2/1/12.
 *
 */

#pragma once
#include "math.h"
#include <cstdlib>

// Types
typedef signed char int8;
typedef unsigned char uint8;
typedef signed short int16;
typedef unsigned short uint16;
typedef signed int int32;
typedef unsigned int uint32;
typedef signed long long int64;
typedef unsigned long long uint64;

typedef int16 ShHeight;
typedef int32 ShExtHeight;
typedef int64 ShExtExtHeight;
typedef uint16 ShSize;
typedef uint32 ShTotalSize;
typedef uint16 ShCoord;
typedef uint32 ShCoordOffset;
typedef ShTotalSize ShIndex;
typedef uint32 ShDistance;

// Constants
const int16 kShInvalidHeight = -32768;
const int16 kShMinHeight	 = -32767;
const int16 kShMaxHeight	 = 32767;
const int8  kShMinMapSize	 = 2;

#define SH_MAX(a,b) ((a) > (b) ? (a) : (b))
#define SH_MIN(a,b) ((a) < (b) ? (a) : (b)) 
#define SH_ABS(a) ((a) < 0 ? -(a): (a))

class ShDiamondSquare {

public:
	
    ShDiamondSquare(unsigned char seed, ShSize width, ShSize height, ShHeight value, uint64 steps = 1000);
	~ShDiamondSquare();
	
	class ShAmplitudes {
		
	public:
		ShAmplitudes(ShSize maxFeatureSize);
		~ShAmplitudes();
		
		// Add a new amplitude to the object
		void addAmplitude(uint16 featureSize, uint16 amplitude);
			
		int getValue(uint16 x, uint16 y);
		uint16* mData;
		ShSize mLength;
	};
	
	
	// create an exact copy
	ShDiamondSquare* clone();
	
	static inline int log2(int x)
	{
		static double base = log10((double) 2);
		return (int16) (log10((double) x) / base);
	}
	
	ShSize getWidth();
	ShSize getHeight();
	ShIndex getLength();
	// returns the minimum of all values in the map
	ShHeight getMin();
	// returns the maximum of all values in the map
	ShHeight getMax();
	ShHeight getValue(ShCoord x, ShCoord y);
    void setValue(ShCoord x, ShCoord y, ShHeight value);
	// if the minimum value < 0, shifts all values in the terrain by the minimum value so everything is positive */
	void shiftAboveZero();
    void normalize(ShHeight maxValue); // Normalize the terrain proportionally to the maxValue
	// sets all values in the map
	void fill(ShHeight value);
	ShAmplitudes* mAmplitudes;
	
//protected:
	
	ShHeight* mData;
	
private:
	
	template<class T>
	T randomRange(int minValue, int maxValue)
	{
		return minValue + (rand() % (int)(maxValue - minValue + 1));
	}

	// sets the values in all tiles inside a rectangle
	void setTileValue(ShCoord x1, ShCoord y1, ShCoord x2, ShCoord y2, ShHeight value);
	ShHeight getSafeValue(ShCoordOffset x, ShCoordOffset y, ShHeight* horizontalOverflowBuffer, ShHeight* verticalOverflowBuffer);
	// adds an integer to all values in the map
	void add(ShHeight value);
	// multiplies each value in the map
	void multiply(double factor);
	// scale the map by a ratio
	void scale(double ratio, bool scaleValues);
	// clams all values to the range
	void clamp(ShHeight min, ShHeight max);
	// replaces all values with the absolute version
	void abs();
	double cubicInterpolate(double p[4], double x);
	double bicubicInterpolate(double p[4][4], double x, double y);
	// Fills the array with random fractal noise.
	void generateTerrain(ShSize minFeatureSize, ShSize maxFeatureSize, ShAmplitudes* amplitudes);
		
	ShSize mWidth, mHeight, mLength;
	uint64 mSteps;
    unsigned char mSeed;
};

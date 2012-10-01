/*
 *  ShDiamondSquare.cpp
 *  Shoggoth
 *
 *  Created by Chad McKinney on 2/1/12.
 *	Thanks to Matěj Zábský for some referential diamond-square code found here:
 *	http://code.google.com/p/geogen/source/browse/trunk/src/ggen_data_2d.cpp#803
 *	Under GPL license
 */

// System Includes
#include <cstring>
#include <time.h>

// Local Includes
#include "src/Graphics/ShDiamondSquare.h"

/////////////////
// ShAmplitudes
////////////////
ShDiamondSquare::ShAmplitudes::ShAmplitudes(ShSize maxFeatureSize)
{
	ShSize size = maxFeatureSize + 1;
	mData = new uint16[size];
	mLength = size;
	
	if(mData != 0)
	{
		for(int i = 0; i < size; ++i)
		{
			mData[i] = 0;
		}
	}
}

ShDiamondSquare::ShAmplitudes::~ShAmplitudes()
{
	delete[] mData;
}

void ShDiamondSquare::ShAmplitudes::addAmplitude(uint16 featureSize, uint16 amplitude)
{
	if(log2(featureSize) < mLength)
	{
		mData[log2(featureSize)] = amplitude;
	}
}


////////////////////
// ShDiamondSquare
///////////////////

ShDiamondSquare::ShDiamondSquare(unsigned char seed, ShSize width, ShSize height, ShHeight value, uint64 steps) :
	mWidth(width),
	mHeight(height),
    mSteps(steps),
    mSeed(seed)
{
	mLength = width * height;
	mData = new ShHeight[mLength];
	fill(value);
    srand(mSeed);
		
    mAmplitudes = new ShAmplitudes(32);
    //mAmplitudes = new ShAmplitudes(64);
    mAmplitudes->addAmplitude(1, 3 * 15);
    mAmplitudes->addAmplitude(2, 7 * 15);
    mAmplitudes->addAmplitude(4, 10 * 15);
    mAmplitudes->addAmplitude(8, 20 * 15);
    mAmplitudes->addAmplitude(16, 50 * 15);
    mAmplitudes->addAmplitude(32, 75 * 15);
    //mAmplitudes->addAmplitude(64, 150 * 15);
    //mAmplitudes->addAmplitude(128, 250 * 15);
    //mAmplitudes->addAmplitude(256, 400 * 15);
    //mAmplitudes->addAmplitude(512, 600 * 15);
    //mAmplitudes->addAmplitude(1024, 1000 * 15);
    //mAmplitudes->addAmplitude(2048, 1400 * 15);
    //mAmplitudes->addAmplitude(4096, 2000 * 15);
	
    generateTerrain(1, 32, mAmplitudes);
    //generateTerrain(1, 64, mAmplitudes);
}

ShDiamondSquare::~ShDiamondSquare()
{
	delete mAmplitudes;
	delete[] mData;
}

ShDiamondSquare* ShDiamondSquare::clone()
{
    ShDiamondSquare* clone = new ShDiamondSquare(mSeed, mWidth, mHeight, 0);
	memcpy(clone->mData, mData, sizeof(ShHeight) * mLength);
	return clone;
}

ShSize ShDiamondSquare::getWidth()
{
	return mWidth;
}

ShSize ShDiamondSquare::getHeight()
{
	return mHeight;
}

ShIndex ShDiamondSquare::getLength()
{
	return mLength;
}

ShHeight ShDiamondSquare::getMin()
{
	ShHeight min = kShMinHeight;
	for(ShIndex i = 0; i < mLength; ++i)
	{
		min = min > mData[i] ? mData[i] : min;
	}
	
	return min;
}

ShHeight ShDiamondSquare::getMax()
{
	ShHeight max = kShMaxHeight;
	for(ShIndex i = 0; i < mLength; ++i)
	{
		max = max < mData[i] ? mData[i] : max;
	}
	
	return max;
}

void ShDiamondSquare::setValue(ShCoord x, ShCoord y, ShHeight value)
{
	mData[x + mWidth * y] = value;
	
}

void ShDiamondSquare::setTileValue(ShCoord x1, ShCoord y1, ShCoord x2, ShCoord y2, ShHeight value)
{
	for(int y = y1; y <= y2; ++y)
	{
		for(int x = x1; x <= x2; ++x)
		{
			mData[x + mWidth * y] = value;
		}
	}
}

ShHeight ShDiamondSquare::getValue(ShCoord x, ShCoord y)
{
	return mData[x + mWidth * y];
}

ShHeight ShDiamondSquare::getSafeValue(ShCoordOffset x, ShCoordOffset y, 
									   ShHeight* horizontalOverflowBuffer, ShHeight* verticalOverflowBuffer)
{
	if(x < 0)
	{
		x = -1;
	}
	
	else if(x >= mWidth)
	{
		return verticalOverflowBuffer[SH_MAX(SH_MIN(y, mHeight), 0)];
	}
	
	if(y < 0)
	{
		y = -y;
	}
	
	else if(y >= mHeight)
	{
		return horizontalOverflowBuffer[x];
	}
	
	return mData[x + mWidth * y];
}

void ShDiamondSquare::add(ShHeight value)
{
	for(ShIndex i = 0; i < mLength; ++i)
	{
		mData[i] += value;
	}
}

void ShDiamondSquare::multiply(double factor)
{
	for(ShIndex i = 0; i < mLength; ++i)
	{
		mData[i] = (int) (factor * (double) mData[i]);
	}
}

void ShDiamondSquare::scale(double ratio, bool scaleValues)
{
	
}

void ShDiamondSquare::fill(ShHeight value)
{
	for(ShIndex i = 0; i < mLength; ++i)
	{
		mData[i] = value;
	}
}

void ShDiamondSquare::clamp(ShHeight min, ShHeight max)
{
	for(ShIndex i = 0; i < mLength; ++i)
	{
		if(mData[i] > max)
		{
			mData[i] = max;
		}
		
		else if(mData[i] < min)
		{
			mData[i] = min;
		}
	}
}

void ShDiamondSquare::abs()
{
	for(ShIndex i = 0; i < mLength; ++i)
	{
		if(mData[i] < 0)
		{
			mData[i] = -mData[i];
		}
	}
}

void ShDiamondSquare::shiftAboveZero()
{
	ShHeight minVal = getMin();
	if(minVal < 0)
	{
		minVal *= -1;
		add(minVal);
	}
}

void ShDiamondSquare::normalize(ShHeight maxValue)
{
    float ratio = (float) maxValue / (float) getMax();

    for(int y = 0; y < getHeight(); ++y)
    {
        for(int x = 0; x < getWidth(); ++x)
        {
            ShHeight value = ((float) getValue(x, y)) * ratio;
            setValue(x, y, value);
        }
    }
}

double ShDiamondSquare::cubicInterpolate(double p[4], double x)
{
	return p[1] + 0.5 * x*(p[2] - p[0] + x*(2.0*p[0] - 5.0*p[1] + 4.0*p[2] - p[3] + x*(3.0*(p[1] - p[2]) + p[3] - p[0])));
}
double ShDiamondSquare::bicubicInterpolate(double p[4][4], double x, double y)
{
	double value[4];
	value[0] = cubicInterpolate(p[0], y);
	value[1] = cubicInterpolate(p[1], y);
	value[2] = cubicInterpolate(p[2], y);
	value[3] = cubicInterpolate(p[3], y);
	return cubicInterpolate(value, x);
}

void ShDiamondSquare::generateTerrain(ShSize minFeatureSize, ShSize maxFeatureSize, ShAmplitudes* amplitudes)
{
	fill(0);
    srand(mSeed);
	
	ShHeight* verticalOverflowBuffer = new ShHeight[mHeight + 1];
	ShHeight* horizontalOverflowBuffer = new ShHeight[mWidth + 1];
	
	// convert wavelength to power of 2
	unsigned waveLengthLog2 = (unsigned) log2(maxFeatureSize);
	ShSize waveLength = 1 << waveLengthLog2;
	ShHeight amplitude = amplitudes->mData[waveLengthLog2];
	
	// generate initial seed values (square corners)
	for(ShCoord y = 0; /* loop */ ; y += waveLength)
	{
		if(y < mHeight)
		{
			for(ShCoord x = 0; /* loop */ ; x += waveLength)
			{
				if(x < mWidth)
				{
					mData[x + mWidth * y] = randomRange<ShHeight>(-amplitude, amplitude);
				}
				
				else
				{
					verticalOverflowBuffer[y] = randomRange<ShHeight>(-amplitude, amplitude);
					break;
				}
			}
		}
		
		else
		{
			for(ShCoord x = 0; /* loop */; x += waveLength)
			{
				if(x < mWidth)
				{
					horizontalOverflowBuffer[x] = randomRange<ShHeight>(-amplitude, amplitude);
				}
				
				else
				{
					verticalOverflowBuffer[mHeight] = randomRange<ShHeight>(-amplitude, amplitude);
					break;
				}
			}
			
			break;
		}
	}
	
	amplitude = amplitudes->mData[waveLengthLog2 - 1];
	
	// Keep interpolating until there are uninterpolated tiles..
	while(waveLength > 1)
	{
		ShSize halfWaveLength = waveLength / 2;
		
		uint64 currentStep = 0;
		
		// The Square step - put a randomly generated point in the center of each square
		bool breakY = false;
		for(ShCoord y = halfWaveLength; (breakY == false) && (currentStep < mSteps); y += waveLength)
		{
			for(ShCoord x = halfWaveLength; /* loop */; x += waveLength)
			{
				// Prepare the 4x4 value matrix for bicubic interpolation.
				ShCoordOffset x0 = (int) x - (int) halfWaveLength - (int) waveLength;
				ShCoordOffset x1 = (int) x - (int) halfWaveLength;
				ShCoordOffset x2 = (int) x + (int) halfWaveLength;
				ShCoordOffset x3 = (int) x + (int) halfWaveLength + (int) waveLength;
				
				ShCoordOffset y0 = (int) y - (int) halfWaveLength - (int) waveLength;
				ShCoordOffset y1 = (int) y - (int) halfWaveLength;
				ShCoordOffset y2 = (int) y + (int) halfWaveLength;
				ShCoordOffset y3 = (int) y + (int) halfWaveLength + (int) waveLength;
				
				double data[4][4] = {
					{
						getSafeValue(x0, y0, verticalOverflowBuffer, horizontalOverflowBuffer),
						getSafeValue(x1, y0, verticalOverflowBuffer, horizontalOverflowBuffer),
						getSafeValue(x2, y0, verticalOverflowBuffer, horizontalOverflowBuffer),
						getSafeValue(x3, y0, verticalOverflowBuffer, horizontalOverflowBuffer),
					},
					{
						getSafeValue(x0, y1, verticalOverflowBuffer, horizontalOverflowBuffer),
						getSafeValue(x1, y1, verticalOverflowBuffer, horizontalOverflowBuffer),
						getSafeValue(x2, y1, verticalOverflowBuffer, horizontalOverflowBuffer),
						getSafeValue(x3, y1, verticalOverflowBuffer, horizontalOverflowBuffer),
					},
					{
						getSafeValue(x0, y2, verticalOverflowBuffer, horizontalOverflowBuffer),
						getSafeValue(x1, y2, verticalOverflowBuffer, horizontalOverflowBuffer),
						getSafeValue(x2, y2, verticalOverflowBuffer, horizontalOverflowBuffer),
						getSafeValue(x3, y2, verticalOverflowBuffer, horizontalOverflowBuffer),
					},
					{
						getSafeValue(x0, y3, verticalOverflowBuffer, horizontalOverflowBuffer),
						getSafeValue(x1, y3, verticalOverflowBuffer, horizontalOverflowBuffer),
						getSafeValue(x2, y3, verticalOverflowBuffer, horizontalOverflowBuffer),
						getSafeValue(x3, y3, verticalOverflowBuffer, horizontalOverflowBuffer),
					},
				};
				
				ShHeight newHeight = bicubicInterpolate(data, 0.5, 0.5) 
								+ (waveLength < minFeatureSize ? 0 : randomRange<ShHeight>(-amplitude, amplitude));
			
				// Place in overflow buffer if outside map
				if( x >= mWidth)
				{
					verticalOverflowBuffer[SH_MIN(y, mHeight)] = newHeight;
					break;
				}
				
				else if(y >= mHeight)
				{
					horizontalOverflowBuffer[x] = newHeight;
					breakY = true;
				}
				
				else
				{
					mData[x + mWidth * y] = newHeight;
				}
			}
			
			currentStep++;
		}
		
		currentStep = 0;
		
		// The Diamond step - add point into middle of each diamond so each square from the square step is composed of 4 smaller
		// smaller squares
		breakY = false;
		bool evenRow = true;
		for(ShCoord y = 0; (breakY == false) && (currentStep < mSteps); y += halfWaveLength)
		{
			for(ShCoord x = (evenRow ? halfWaveLength : 0); /* loop */; x += waveLength)
			{
				// Prepare the 4x4 value matrix for bicubic interpolation (this time rotated by 45 degrees).
				ShCoordOffset x0 = (int) x - (int) halfWaveLength - (int) waveLength;
				ShCoordOffset x1 = (int) x - (int) waveLength;
				ShCoordOffset x2 = (int) x - (int) halfWaveLength;
				ShCoordOffset x3 = (int) x;
				ShCoordOffset x4 = (int) x + (int) halfWaveLength;
				ShCoordOffset x5 = (int) x + (int) waveLength;
				ShCoordOffset x6 = (int) x + (int) halfWaveLength + (int) waveLength;
				
				ShCoordOffset y0 = (int) y - (int) halfWaveLength - (int) waveLength;
				ShCoordOffset y1 = (int) y - (int) waveLength;
				ShCoordOffset y2 = (int) y - (int) halfWaveLength;
				ShCoordOffset y3 = (int) y;
				ShCoordOffset y4 = (int) y + (int) halfWaveLength;
				ShCoordOffset y5 = (int) y + (int) waveLength;
				ShCoordOffset y6 = (int) y + (int) halfWaveLength + (int) waveLength;
				
				double data[4][4] = {
					{
						getSafeValue(x0, y3, verticalOverflowBuffer, horizontalOverflowBuffer),
						getSafeValue(x1, y4, verticalOverflowBuffer, horizontalOverflowBuffer),
						getSafeValue(x2, y5, verticalOverflowBuffer, horizontalOverflowBuffer),
						getSafeValue(x3, y6, verticalOverflowBuffer, horizontalOverflowBuffer),
					},
					{
						getSafeValue(x1, y2, verticalOverflowBuffer, horizontalOverflowBuffer),
						getSafeValue(x2, y3, verticalOverflowBuffer, horizontalOverflowBuffer),
						getSafeValue(x3, y4, verticalOverflowBuffer, horizontalOverflowBuffer),
						getSafeValue(x4, y5, verticalOverflowBuffer, horizontalOverflowBuffer),
					},
					{
						getSafeValue(x2, y1, verticalOverflowBuffer, horizontalOverflowBuffer),
						getSafeValue(x3, y2, verticalOverflowBuffer, horizontalOverflowBuffer),
						getSafeValue(x4, y3, verticalOverflowBuffer, horizontalOverflowBuffer),
						getSafeValue(x5, y4, verticalOverflowBuffer, horizontalOverflowBuffer),
					},
					{
						getSafeValue(x3, y0, verticalOverflowBuffer, horizontalOverflowBuffer),
						getSafeValue(x4, y1, verticalOverflowBuffer, horizontalOverflowBuffer),
						getSafeValue(x5, y2, verticalOverflowBuffer, horizontalOverflowBuffer),
						getSafeValue(x6, y3, verticalOverflowBuffer, horizontalOverflowBuffer),
					},
				};
				
				ShHeight newHeight = bicubicInterpolate(data, 0.5, 0.5) 
								+ (waveLength < minFeatureSize ? 0 : randomRange<ShHeight>(-amplitude, amplitude));
			
				// Place in overflow buffer if outside map
				if( x >= mWidth)
				{
					verticalOverflowBuffer[SH_MIN(y, mHeight)] = newHeight;
					break;
				}
				
				else if(y >= mHeight)
				{
					horizontalOverflowBuffer[x] = newHeight;
					breakY = true;
				}
				
				else
				{
					mData[x + mWidth * y] = newHeight;
				}
			}
			
			// The X coordinates are shifted by waveLength/2 in even rows.
			evenRow = !evenRow;
			currentStep++;
		}
		
		// Decrese the wave length and amplitude.
		waveLength /= 2;
		if(waveLength > 1)
		{
			amplitude = amplitudes->mData[log2(waveLength / 2)];
		}
	}
	
	delete[] verticalOverflowBuffer;
	delete[] horizontalOverflowBuffer;
	
	return;
}


















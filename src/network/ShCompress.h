#ifndef SHCOMPRESS_H
#define SHCOMPRESS_H

// System includes
#include <deque>

// Local includes
#include "src/network/ShNetwork.h"

namespace ShNetwork {

// Compress Step Vars
extern int algorithmBits;
extern int genArgumentBits;
extern int totalCompressBits;

int compressBitArray(std::deque<unsigned char>& bitDeque);
void decompressBitArray(std::deque<unsigned char>& bitDeque, int data, unsigned int size);

int compressSteps(Algorithm algorithm, unsigned char genArgument);
int compressTerrain(Algorithm algorithm, unsigned char genArgument);

bool decompressSteps(int compressedState, unsigned char& algorithm, unsigned char& genArgument);
bool decompressTerrain(int compressedTerrain, unsigned char& algorithm, unsigned char& genArgument);

int compressVec2(cinder::Vec2i vec); // Only works with numbers 0 - 65536
cinder::Vec2i decompressVec2(int vec); // Only works with numbers 0 - 65536

int compressVec3(cinder::Vec3i vec); // Only works with numbers 0 - 1024
cinder::Vec3i decompressVec3(int vec); // Only works with numbers 0 - 1024

int compressVec4(cinder::Vec4i vec); // Only works with numbers 0 - 255
cinder::Vec4i decompressVec4(int vec); // Only works with numbers 0 - 255

template <class T>
inline int compressVec(T vec)
{
    std::deque<unsigned char> bitDeque;

    for(int i = 0; i < vec.length(); ++i)
    {
        decompressBitArray(bitDeque, vec[i], 32);
    }

    return compressBitArray(bitDeque);
}

/*
    std::deque<unsigned char> bitDeque;
    decompressBitArray(bitDeque, vec, 32);
    std::deque<unsigned char> xDeque, yDeque;

    for(int i = 0; i < 16; ++i)
    {
        yDeque.push_back(bitDeque.front());
        bitDeque.pop_front();
    }

    for(int i = 0; i < 16; ++i)
    {
        xDeque.push_back(bitDeque.front());
        bitDeque.pop_front();
    }

    return cinder::Vec2i(compressBitArray(xDeque), compressBitArray(yDeque));*/

template<class T>
inline T decompressVec(int vec, int numDimensions)
{
    std::deque<unsigned char> bitDeque;
    decompressBitArray(bitDeque, vec, 32);
    int numBitsPerDimension = 32 / numDimensions;
    T decompressedVector;

    for(int i = 0; i < numDimensions; ++i)
    {
        std::deque<unsigned char> dimensionDeque;

        for(int j = 0; i < numBitsPerDimension; ++i)
        {
            dimensionDeque.push_back(bitDeque.front());
            bitDeque.pop_back();
        }

        decompressedVector[i] = compressBitArray(dimensionDeque);
    }
}

} // ShNetwork namespace

#endif // SHCOMPRESS_H

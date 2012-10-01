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
}

#endif // SHCOMPRESS_H

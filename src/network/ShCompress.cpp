#include "ShCompress.h"

namespace ShNetwork {

// Compress Step Vars
int algorithmBits = 4;
int genArgumentBits = 8;
int totalCompressBits = algorithmBits + genArgumentBits;

int compressBitArray(std::deque<unsigned char>& bitDeque)
{
    int compressedData = 0;
    int i = 0;

    std::deque<unsigned char>::iterator iter = bitDeque.begin();

    while(iter != bitDeque.end())
    {
        compressedData += *iter << i;
        ++i;
        ++iter;
    }

    return compressedData;
}

void decompressBitArray(std::deque<unsigned char>& bitDeque, int data, unsigned int size)
{
    for(int i = 0; i < size; ++i)
    {
        bitDeque.push_front((data >> (size - i - 1)) & 1);
    }
}

int compressSteps(Algorithm algorithm, unsigned char genArgument)
{
    std::deque<unsigned char> bitDeque; // Create the bit deque for holding the encrypted data
    decompressBitArray(bitDeque, genArgument, ShNetwork::genArgumentBits); // translate the genArgument into the bit deque

    std::deque<unsigned char> stepGenDeque; // Create a second deque for holding the step Gen data, momentarily
    decompressBitArray(stepGenDeque, algorithm, ShNetwork::algorithmBits); // translate the stepGen into the bit deque

    //iterate backwards, pushing the stepGen bits to the front of the bitDeque
    for(int i = ShNetwork::algorithmBits - 1; i >= 0; --i)
    {
        bitDeque.push_front(stepGenDeque[i]);
    }

    return compressBitArray(bitDeque); // return the compressed data
}

int compressTerrain(Algorithm algorithm, unsigned char genArgument)
{
    std::deque<unsigned char> bitDeque; // Create the bit deque for holding the encrypted data
    decompressBitArray(bitDeque, genArgument, ShNetwork::genArgumentBits); // translate the seed into the bit deque

    std::deque<unsigned char> terrainGenDeque; // Create a second deque for holding the step seed data, momentarily
    decompressBitArray(terrainGenDeque, algorithm, ShNetwork::algorithmBits); // translate the terrainGen into the bit deque

    // iterate backwards, pushing the terrainGen bits to the front of the bitDeque
    for(int i = ShNetwork::algorithmBits - 1; i >= 0; --i)
    {
        bitDeque.push_front(terrainGenDeque[i]);
    }

    return compressBitArray(bitDeque); // return the compressed data
}

bool decompressSteps(int compressedState, unsigned char &algorithm, unsigned char &genArgument)
{
    std::deque<unsigned char> bitDeque; // Create the bit deque for holding the decrypted data
    // translate the compressedState into the bit deque
    decompressBitArray(bitDeque, compressedState, ShNetwork::totalCompressBits);

    std::deque<unsigned char> stepGenDeque; // create a second deque for the stepGen data

    for(int i = 0; i < ShNetwork::algorithmBits; ++i) // one by one grab the bits from the bitDeque and push them
    {
        stepGenDeque.push_back(bitDeque.front());
        bitDeque.pop_front();
    }

    algorithm = compressBitArray(stepGenDeque); // recompress the stepGen bits to generate the stepGen argument
    genArgument = compressBitArray(bitDeque); // recompress the remaining bits to generate the argument for the state generation
}

bool decompressTerrain(int compressedTerrain, unsigned char &algorithm, unsigned char &genArgument)
{
    std::deque<unsigned char> bitDeque; // Create the bit deque for holding the decrypted data
    // translate the compressedState into the bit deque
    decompressBitArray(bitDeque, compressedTerrain, ShNetwork::totalCompressBits);

    std::deque<unsigned char> terrainGenDeque; // create a second deque for the stepGen data

    for(int i = 0; i < ShNetwork::algorithmBits; ++i) // one by one grab the bits from the bitDeque and push them
    {
        terrainGenDeque.push_back(bitDeque.front());
        bitDeque.pop_front();
    }

    algorithm = compressBitArray(terrainGenDeque); // recompress the stepGen bits to generate the stepGen argument
    genArgument = compressBitArray(bitDeque); // recompress the remaining bits to generate the argument for the state generation
}

int compressVec2(cinder::Vec2i vec)
{
    std::deque<unsigned char> bitDeque;
    decompressBitArray(bitDeque, vec.x, 16);
    decompressBitArray(bitDeque, vec.y, 16);
    return compressBitArray(bitDeque);
}

cinder::Vec2i decompressVec2(int vec)
{
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

    return cinder::Vec2i(compressBitArray(xDeque), compressBitArray(yDeque));
}

int compressVec3(cinder::Vec3i vec)
{
    std::deque<unsigned char> bitDeque;
    decompressBitArray(bitDeque, vec.x, 10);
    decompressBitArray(bitDeque, vec.y, 10);
    decompressBitArray(bitDeque, vec.z, 10);
    return compressBitArray(bitDeque);
}

cinder::Vec3i decompressVec3(int vec)
{
    std::deque<unsigned char> bitDeque;
    decompressBitArray(bitDeque, vec, 32);
    std::deque<unsigned char> xDeque, yDeque, zDeque;

    for(int i = 0; i < 10; ++i)
    {
        zDeque.push_back(bitDeque.front());
        bitDeque.pop_front();
    }

    for(int i = 0; i < 10; ++i)
    {
        yDeque.push_back(bitDeque.front());
        bitDeque.pop_front();
    }

    for(int i = 0; i < 10; ++i)
    {
        xDeque.push_back(bitDeque.front());
        bitDeque.pop_front();
    }

    return cinder::Vec3i(compressBitArray(xDeque), compressBitArray(yDeque), compressBitArray(zDeque));
}

int compressVec4(cinder::Vec4i vec)
{
    std::deque<unsigned char> bitDeque;
    decompressBitArray(bitDeque, vec.w, 8);
    decompressBitArray(bitDeque, vec.x, 8);
    decompressBitArray(bitDeque, vec.y, 8);
    decompressBitArray(bitDeque, vec.z, 8);
    return compressBitArray(bitDeque);
}

cinder::Vec4i decompressVec4(int vec)
{
    std::deque<unsigned char> bitDeque;
    decompressBitArray(bitDeque, vec, 32);
    std::deque<unsigned char> wDeque, xDeque, yDeque, zDeque;

    for(int i = 0; i < 8; ++i)
    {
        zDeque.push_back(bitDeque.front());
        bitDeque.pop_front();
    }

    for(int i = 0; i < 8; ++i)
    {
        yDeque.push_back(bitDeque.front());
        bitDeque.pop_front();
    }

    for(int i = 0; i < 8; ++i)
    {
        xDeque.push_back(bitDeque.front());
        bitDeque.pop_front();
    }

    for(int i = 0; i < 8; ++i)
    {
        wDeque.push_back(bitDeque.front());
        bitDeque.pop_front();
    }

    return cinder::Vec4i(compressBitArray(wDeque), compressBitArray(xDeque), compressBitArray(yDeque), compressBitArray(zDeque));
}

} // ShNetwork namespace

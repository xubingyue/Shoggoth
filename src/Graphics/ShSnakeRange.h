#ifndef SHSNAKERANGE_H
#define SHSNAKERANGE_H

// System includes
#include <vector>
// #include <pair.h>

// Boost includes
#include "boost/thread/shared_mutex.hpp"

// Cinder includes
#include "cinder/Vector.h"
#include "cinder/gl/Vbo.h"
#include "cinder/Color.h"
#include "cinder/gl/Texture.h"

// Shoggoth includes
#include "src/Graphics/ShSeqPath.h"
#include "src/Audio/polyphonicsynth.h"

class ShIsland;

typedef std::pair<unsigned int, unsigned int> snake_range_id_t; // Used to identify snakes uniquely. First number is the island they're on.

class ShSnakeRange
{
public:
    // Position, width, and height are given as positions on the ShIsland::triangleGrid
    // Position and size MUST BE EVEN!
    ShSnakeRange(snake_range_id_t id, std::string synthName, cinder::Vec2i corner1, cinder::Vec2i corner2,
                 cinder::Color color, ShIsland* island, bool queueChange = false);

    ~ShSnakeRange();

    void increment();
    void draw(bool drawActive);
    void drawHighlight();
    void drawName();
    void move(cinder::Vec2i position, bool queueChange = false);
    void setCorner1(cinder::Vec2i newCorner);
    void setCorner2(cinder::Vec2i newCorner, bool queueChange = false);
    void updateMesh();
    snake_range_id_t getID();
    std::string getSynthName();
    cinder::Vec2i getCorner1();
    cinder::Vec2i getCorner2();
    cinder::Color getColor();
    ShIsland* getIsland();

    cinder::Vec2i getPosition();
    cinder::Vec2i getSize();
    GridTri* getTri(int rangeCursor);
    std::vector<GridTri*>& getRangeVector();

    static const int vertexCount = 10;

private:

    void populateRangeVector(bool rebuildMesh);
    void createMesh();
    void minAndMaxHeights();
    void rebuildPositions();
    void bufferPositions();
    void resetPositionAndSize();
    void createSynthNameTexture();

    ShIsland* island;
    cinder::Vec2i corner1, corner2, corner3, corner4, position, size;
    std::vector<cinder::Vec2i> corners;

    std::vector<GridTri*> rangeVector; // range grid collected as a one dimensional vector
    cinder::gl::VboMesh mesh;
    std::vector<cinder::Vec3f> meshPositions, fourCorners;
    float minHeight, maxHeight;
    cinder::ColorA color;
    std::string synthName;
    snake_range_id_t id;
    int beatPointer;
    bool changeQueued;
    cinder::gl::Texture* synthNameTexture;
    boost::shared_mutex mutex;
    cinder::Vec3d islandPosition;
    int islandID;
    PolyphonicSynth* synth;
};

#endif // SHSNAKERANGE_H

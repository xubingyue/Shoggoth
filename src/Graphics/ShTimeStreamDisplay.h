#ifndef SHTIMESTREAMDISPLAY_H
#define SHTIMESTREAMDISPLAY_H

// Boost includes
#include "boost/chrono.hpp"

// Cinder includes
#include "cinder/Rect.h"
#include "cinder/gl/Vbo.h"
#include "cinder/Font.h"

class ShTimeStream;

class ShTimeStreamDisplay
{
public:
    ShTimeStreamDisplay();

    void draw();

private:

    void recursiveDrawBranch(ShTimeStream *stream);
    void drawBranches();

    boost::chrono::steady_clock::time_point mostFutureTime, currentTime;
    cinder::Rectf bounds;
    int numBranches, width, height;
    cinder::Font mFont;
};

#endif // SHTIMESTREAMDISPLAY_H

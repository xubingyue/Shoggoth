#ifndef SERVERPANEL_H
#define SERVERPANEL_H

#include "cinder/Vector.h"

namespace serverpanel
{
    void setPos(cinder::Vec2i pos);
    void update(int numUGens,int numSynths, float avgCPU, float peakCPU);
    void draw();
} // Server Panel

#endif // SERVERPANEL_H

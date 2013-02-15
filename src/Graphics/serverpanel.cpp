#include <sstream>
#include "src/ShGlobals.h"
#include "serverpanel.h"

namespace serverpanel
{
    bool serverBooted = false;
    cinder::Vec2i pos = cinder::Vec2i(5, 5);
    std::string status("numUGens: 0 numSynths: 0 avgCPU: 0 peakCPU: 0");

    void setPos(cinder::Vec2i pos)
    {
        serverpanel::pos = pos;
    }

    void update(int numUGens,int numSynths, float avgCPU, float peakCPU)
    {
        if(!serverBooted)
        {
            serverBooted = true;
            ShGlobals::ISLAND_GRID->createWaveTerrainBuffers();
        }

        std::stringstream ss;
        ss << "numUGens: " << numUGens << " numSynths: " << numSynths << " avgCPU: " << avgCPU << " peakCPU: " << peakCPU;
        status = ss.str();
    }

    void draw()
    {
        cinder::gl::drawString(status, pos, cinder::ColorA(0, 0, 0, 0.75), ShGlobals::FONT);
    }
} // Server Panel

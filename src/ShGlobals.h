/*
 *  ShGlobals.h
 *  Shoggoth
 *
 *  Created by Chad McKinney on 3/6/12.
 *
 */
#pragma once

// System includes
#include <string>
#include <tr1/unordered_map>

// Cinder includes
#include "cinder/Vector.h"
#include "cinder/Color.h"
#include "cinder/Font.h"

// Shoggoth includes
#include "ShCamera.h"
#include "src/Time/ShSequencer.h"
#include "src/HCI/ShData.h"
#include "src/ShIslandGrid.h"
#include "src/Time/ShTimer.h"
#include "src/Time/ShScheduler.h"
#include "src/Graphics/luaconsole.h"
#include "src/Graphics/timequakedisplay.h"
#include "src/Graphics/serverpanel.h"

// Forward declaration
namespace SLB {
    class ShoggothScript;
}

namespace boost {
    class shared_mutex;
}

namespace ShGlobals {
    extern cinder::Font FONT;
    extern std::string USER_NAME;
    extern unsigned int RAND_SEED;
    extern unsigned int OSCTHULHU_PORT;
    extern cinder::Vec2i SCREEN_SIZE;
    extern ShCamera* CAMERA;
    extern ShSequencer* SEQUENCER;
    // extern ShData* DATA;
    extern cinder::ColorA COLOR_ON, COLOR_OFF, COLOR0, COLOR1, COLOR2, COLOR3;
    extern ShIslandGrid* ISLAND_GRID;
    extern ShTimer* TIME_STREAM_TIMER;
    extern TimeStreamScheduler* TIME_STREAM_SCHEDULER;
    extern TimeQuakeDisplay* TIME_QUAKE_DISPLAY;
    extern LuaConsole* LUA_CONSOLE;
    void luaPrintCallback(SLB::ShoggothScript *s, const char *str, size_t length);
    extern int SECTION_NUMBER;
    extern unsigned int NUM_SECTIONS;
    extern bool DRAW_WIREFRAMES;
    extern cinder::ColorA BACKGROUND_COLOR;
    void setSectionNumber(int sectionNumber);
    void incrementSectionNumber();
    void decrementSectionNumber();

    void addTimeStream(std::string key, ShTimeStream* timeStream);
    std::map<std::string, ShTimeStream*>& getTimeStreamMap();

    extern boost::shared_mutex mutex;

    namespace detail
    {
        extern std::map<std::string, ShTimeStream*> TIME_STREAM_MAP;
    }
}

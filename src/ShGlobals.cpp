// Boost includes
#include "boost/thread/shared_mutex.hpp"

// Local includes
#include "ShGlobals.h"

// Shoggoth includes
#include "Script/ShoggothScript.hpp"

namespace ShGlobals {
    cinder::Font FONT;
    std::string USER_NAME = "DefaultUser";
    unsigned int RAND_SEED = 0;
    unsigned int OSCTHULHU_PORT = 32243;
    cinder::Vec2i SCREEN_SIZE = cinder::Vec2i(0, 0);
    ShCamera* CAMERA = 0;
    ShSequencer* SEQUENCER = 0;
    ShData* DATA = 0;
    cinder::ColorA COLOR_OFF = cinder::ColorA(0.05, 0.05, 0.05, 1);
    cinder::ColorA COLOR_ON = cinder::ColorA(0.9, 0.9, 0.9, 1);
    cinder::ColorA COLOR0 = cinder::ColorA(0.25, 0.25, 0.25, 1);
    cinder::ColorA COLOR1 = cinder::ColorA(0.0, 0.5, 0.5, 1);
    cinder::ColorA COLOR2 = cinder::ColorA(1, 0.0, 0.0, 1);
    cinder::ColorA COLOR3 = cinder::ColorA(1, 1, 1, 1);
    ShIslandGrid* ISLAND_GRID = 0;
    ShTimer* TIME_STREAM_TIMER = 0;
    TimeStreamScheduler* TIME_STREAM_SCHEDULER = 0;
    TimeQuakeDisplay* TIME_QUAKE_DISPLAY = 0;
    LuaConsole* LUA_CONSOLE = 0;

    void luaPrintCallback(SLB::ShoggothScript *s, const char *str, size_t length)
    {
        if(LUA_CONSOLE)
            LUA_CONSOLE->addMessage(str);
    }

    boost::shared_mutex mutex;

    void addTimeStream(std::string key, ShTimeStream* timeStream)
    {
        boost::shared_lock<boost::shared_mutex> lock(mutex);
        detail::TIME_STREAM_MAP[key] = timeStream;
    }

    std::map<std::string, ShTimeStream*>& getTimeStreamMap()
    {
        boost::shared_lock<boost::shared_mutex> lock(mutex);
        return detail::TIME_STREAM_MAP;
    }

    namespace detail
    {
        std::map<std::string, ShTimeStream*> TIME_STREAM_MAP;
    } // detail namespace

} // ShGlobals namespace

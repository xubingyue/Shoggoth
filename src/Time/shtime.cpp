// System includes
#include <cmath>

// Boost includes
#include "boost/chrono/time_point.hpp"

// Local includes
#include "shtime.h"
#include "src/Time/shtimestream.h"
#include "src/Script/script.h"
#include "src/ShGlobals.h"

namespace shtime {

void timeShift(int minutes, int seconds)
{
    boost::chrono::steady_clock::time_point newTime(boost::chrono::seconds(std::max(5, (minutes * 60) + seconds)));
    ShGlobals::TIME_STREAM_TIMER->setTime(newTime);
    ShGlobals::TIME_STREAM_SCHEDULER->getCurrentTimeStream()->moveCurrentTime(newTime, true);
}

} // shtime namespace

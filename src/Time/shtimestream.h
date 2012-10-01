#ifndef SHTIMESTREAM_H
#define SHTIMESTREAM_H

// System includes
#include <map>
#include <list>

// Boost includes
#include "boost/chrono.hpp"
#include "boost/chrono/time_point.hpp"
#include "boost/thread/shared_mutex.hpp"

// Cinder includes
#include "cinder/Vector.h"

// Shoggoth includes
#include "src/Graphics/ShAvatar.h"
#include "src/Time/ShTimeEvent.h"

// ShTimeStream is the controller class for branching time streams. It contains a vector of other ShTimeStream in turn creating
// a branching tream of ShTimeStreams which can be traverse recusively using static functions
class ShTimeStream
{
public:

    ShTimeStream(std::string id, boost::chrono::steady_clock::time_point creationTime, ShTimeStream *parent = 0,
                 TimeSlice initialTimeSlice = TimeSlice());
    ~ShTimeStream();

    ShTimeStream* getParent();
    void callAllParentEventsUpToTime(boost::chrono::steady_clock::time_point time);
    // Sets the current time, calling time events (if not jump) as needed.
    // If the new time is less than creationTime we return parent, otherwise this is ShTimeStream* is returned
    ShTimeStream* moveCurrentTime(boost::chrono::steady_clock::time_point newTime, bool jump);
    // returns the time stream that the new event will belong to.
    // If the event happens after the last event, then it this ShTimeStream is returned, otherwise a new time stream is returned
    ShTimeStream* addTimeEvent(ShTimeEvent* timeEvent); // Takes ownership

    boost::chrono::steady_clock::time_point getCreationTime();
    boost::chrono::steady_clock::time_point getCurrentTime();
    boost::chrono::steady_clock::time_point getMostFutureTime();
    std::string getID();

    std::list<ShTimeStream*>& getTimeBranches();
    int numTimeBranches();
    std::list<ShTimeStream*>::iterator getTimeBranchesBeginIterator();
    std::list<ShTimeStream*>::iterator getTimeBranchesEndIterator();
    std::list<ShTimeEvent*>& getTimeEvents();

    static ShTimeStream* root;
    static boost::chrono::steady_clock::time_point globalMostFutureTime;

private:

    void jumpToTime(boost::chrono::steady_clock::time_point newTime, bool callAddAndRemoveEvents);
    void updateTimeVars(boost::chrono::steady_clock::time_point newTime);
    TimeSlice createTimeSlice(boost::chrono::steady_clock::time_point sliceTime);

    ShTimeStream* parent;
    std::list<ShTimeStream*> timeBranches;
    std::list<ShTimeEvent*> timeEvents;
    std::list<ShTimeEvent*>::iterator currentEventIter; // used for time setting and event calling
    boost::chrono::steady_clock::time_point creationTime, currentTime, mostFutureTime;
    boost::shared_mutex mutex;
    TimeSlice initialTimeSlice; // The initial state the the TimeStream was in at creation
    std::string id;
    bool isRoot;
};

#endif // SHTIMESTREAM_H

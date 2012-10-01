// System includes
#include <sstream>

// Boost includes
#include "boost/chrono.hpp"
#include "boost/chrono/time_point.hpp"

// Shoggoth includes
#include "shtimestream.h"
#include "src/Time/ShTimeEvent.h"
#include "src/Script/script.h"
#include "src/network/ShNetwork.h"
#include "src/ShIslandGrid.h"
#include "src/ShGlobals.h"
#include "src/network/ShNetwork.h"

ShTimeStream* ShTimeStream::root = 0; // Static pointer to root ShTimeStream
boost::chrono::steady_clock::time_point ShTimeStream::globalMostFutureTime =
        boost::chrono::steady_clock::time_point(boost::chrono::seconds(1));

ShTimeStream::ShTimeStream(std::string id, boost::chrono::steady_clock::time_point creationTime, ShTimeStream *parent,
                           TimeSlice initialTimeSlice) :
    id(id),
    creationTime(creationTime),
    currentTime(creationTime),
    mostFutureTime(creationTime),
    parent(parent),
    initialTimeSlice(initialTimeSlice)
{
    if(ShTimeStream::root == 0) // Begin with empty events
    {
        ShTimeStream::root = this;
        isRoot = true;
        std::cout << "ROOT TIME STREAM!!!" << std::endl;

        boost::chrono::steady_clock::time_point zeroTime(boost::chrono::milliseconds(0));
        ShNetwork::algo_pair emptyGen = std::make_pair(ShNetwork::Empty, 0);

         // initialize islands to empty at 00:00
        for(int i = 0; i < ShIslandGrid::NUM_ISLANDS; ++i) // Populate initial events
        {
            TerrainStepsEvent* stepEvent = new TerrainStepsEvent(i, emptyGen, zeroTime);
            TerrainHeightsEvent* heightEvent = new TerrainHeightsEvent(i, emptyGen, zeroTime);

            timeEvents.push_back(stepEvent);
            timeEvents.push_back(heightEvent);
            this->initialTimeSlice.islandSteps[i] = stepEvent;
            this->initialTimeSlice.islandHeights[i] = heightEvent;
        }
    }

    else
    {
        isRoot = false;

        for(int i = 0; i < ShIslandGrid::NUM_ISLANDS; ++i) // populate initial events
        {
            timeEvents.push_back(new TerrainStepsEvent(*(this->initialTimeSlice.islandSteps.at(i))));
            timeEvents.push_back(new TerrainHeightsEvent(*(this->initialTimeSlice.islandHeights.at(i))));
        }

        std::cout << "NEW TIME STREAM!!!!!" << std::endl;
    }

    ShGlobals::addTimeStream(id, this);
    //ShNetwork::sendCreateTimeStream(id.c_str(), creationTime.time_since_epoch().count());
    //std::cout << "Steam ID: " << id << std::endl;

    updateTimeVars(creationTime);
    currentEventIter = timeEvents.begin();
}

ShTimeStream::~ShTimeStream()
{
    boost::upgrade_lock<boost::shared_mutex> lock(mutex);
    boost::upgrade_to_unique_lock<boost::shared_mutex> writeLock(lock);

    std::list<ShTimeEvent*>::iterator eventIter = timeEvents.begin();

    while(eventIter != timeEvents.end())
    {
        delete *eventIter;
        ++eventIter;
    }

    timeEvents.clear();

    std::list<ShTimeStream*>::iterator branchIter = timeBranches.begin();

    while(branchIter != timeBranches.end())
    {
        delete *branchIter;
        ++branchIter;
    }

    timeBranches.clear();
}

ShTimeStream *ShTimeStream::getParent()
{
    boost::shared_lock<boost::shared_mutex> lock(mutex);
    return parent;
}

void ShTimeStream::callAllParentEventsUpToTime(boost::chrono::steady_clock::time_point time)
{
    boost::upgrade_lock<boost::shared_mutex> lock(mutex);
    boost::upgrade_to_unique_lock<boost::shared_mutex> writeLock(lock);

    ShTimeStream* timeStream = parent;
    std::vector<ShTimeStream*> parentStreams;

    while(timeStream != 0)
    {
        parentStreams.push_back(timeStream);
        timeStream = timeStream->getParent();
    }

    for(int i = 0; i < parentStreams.size(); ++i)
    {
        ShTimeStream* currentTimeStream = parentStreams[i];
        currentTimeStream->moveCurrentTime(currentTimeStream->getCreationTime(), true);
        currentTimeStream->moveCurrentTime(currentTimeStream->getMostFutureTime(), true);
    }
}

ShTimeStream* ShTimeStream::moveCurrentTime(boost::chrono::steady_clock::time_point newTime, bool jump)
{
    boost::upgrade_lock<boost::shared_mutex> lock(mutex);
    boost::upgrade_to_unique_lock<boost::shared_mutex> writeLock(lock);

    if(currentTime < newTime)
    {
        if(!jump) // If not jumping, move back, calling the events as we go
        {
            while(currentEventIter != timeEvents.end())
            {
                boost::chrono::steady_clock::time_point eventTime = (*currentEventIter)->getTimeStamp();
                if(eventTime < newTime && eventTime > currentTime)
                {
                    (*currentEventIter)->call();
                    ++currentEventIter;
                }

                else
                {
                    break;
                }
            }
        }

        else // If jumping, collect events of each type until the newTime, then call those events
        {
            jumpToTime(newTime, true);
        }
    }

    else
    {
        if(!jump)
        {
            while(currentEventIter != timeEvents.begin())
            {
                if((*currentEventIter)->getTimeStamp() > newTime)
                {
                    TimeEventType type = (*currentEventIter)->type();

                    if(type == SnakeAddType || type == SnakeRemoveType)
                        (*currentEventIter)->undo();
                    else
                        (*currentEventIter)->call();

                    --currentEventIter;
                }

                else
                {
                    break;
                }
            }
        }

        else
        {
            while(currentEventIter != timeEvents.begin())
            {
                // Undo events (if they implement it such as add/remove events) movng backwards until we rech the new time
                if((*currentEventIter)->getTimeStamp() > newTime)
                {
                    (*currentEventIter)->undo();
                    --currentEventIter;
                }

                else // Then jump to the beginning
                {
                    // reset the eventIter to the beginning so we can find the most recent events of each type
                    currentEventIter = timeEvents.begin();
                    jumpToTime(newTime, true); // jump to the new time and call the most recent events of each type
                    break;
                }
            }
        }
    }

    // If the new time is less than creationTime and we're not the root stream, return our parent, jumping it to the new time
    if(newTime < creationTime && !isRoot)
    {
        return parent->moveCurrentTime(newTime, true);
    }

    else
    {
        updateTimeVars(newTime); // Otherwise we simply set our currentTime to the newTime
        return this;
    }
}

// Jump to new time by collecting events of each type until the newTime, then call those events
void ShTimeStream::jumpToTime(boost::chrono::steady_clock::time_point newTime, bool callAddAndRemoveEvents)
{
    // TimeSlice
    TimeSlice timeSlice = initialTimeSlice;

    // Pointers to events
    ShTimeEvent *terrainStepsEvent, *terrainHeightsEvent, *avatarEvent, *snakeAddEvent, *snakeRemoveEvent;
    terrainStepsEvent = terrainHeightsEvent = avatarEvent = snakeAddEvent = snakeRemoveEvent = 0;

    while(currentEventIter != timeEvents.end()) // collect events of each type
    {
        if((*currentEventIter)->getTimeStamp() < newTime)
        {
            switch((*currentEventIter)->type())
            {
            case TerrainStepsType:
                timeSlice.softAddStepEvent(static_cast<TerrainStepsEvent*>(*currentEventIter));
                break;

            case TerrainHeightsType:
               timeSlice.softAddHeightEvent(static_cast<TerrainHeightsEvent*>(*currentEventIter));
                break;

            case AvatarType:
                timeSlice.avatarEvent = (static_cast<AvatarEvent*>(*currentEventIter));
                break;

            case SnakeAddType:
                snakeAddEvent = (static_cast<SnakeAddEvent*>(*currentEventIter));
                break;

            case SnakeRemoveType:
                snakeRemoveEvent = (static_cast<SnakeRemoveEvent*>(*currentEventIter));
                break;
            }

            ++currentEventIter;
        }

        else
        {
            //timeSlice.call(); // Call the time slice to put everything in place

            /*
            if(terrainStepsEvent)
                terrainStepsEvent->call();

            if(terrainHeightsEvent)
                terrainHeightsEvent->call();

            if(avatarEvent)
                avatarEvent->call();

            if(snakeAddEvent && callAddAndRemoveEvents)
                snakeAddEvent->call();

            if(snakeRemoveEvent && callAddAndRemoveEvents)
                snakeRemoveEvent->call();
            */

            break; // break the while loop if we've reached the new time
        }
    }

    timeSlice.call(); // Call the time slice to put everything in place
}

ShTimeStream* ShTimeStream::addTimeEvent(ShTimeEvent* timeEvent)
{
    boost::upgrade_lock<boost::shared_mutex> lock(mutex);
    boost::upgrade_to_unique_lock<boost::shared_mutex> writeLock(lock);

    boost::chrono::steady_clock::time_point newTime = timeEvent->getTimeStamp();

    if(timeEvents.size() == 0)
    {
        timeEvents.push_back(timeEvent); // if new event time after last event time, push event onto the back
        currentEventIter = timeEvents.begin();
        updateTimeVars(newTime);
    }

    else if(newTime >= timeEvents.back()->getTimeStamp())
    {
        timeEvents.push_back(timeEvent); // if new event time after last event time, push event onto the back
        currentEventIter = timeEvents.end();
        --currentEventIter;
        updateTimeVars(newTime);
        return this;
    }

    else // Create a new branch
    {
        std::list<ShTimeStream*>::iterator streamIter = timeBranches.begin();
        std::stringstream newID;
        newID << id << "|" << timeBranches.size();

        /*
        while(streamIter != timeBranches.end())
        {
            if(newTime < (*streamIter)->getCreationTime())
            {
                if(streamIter != timeBranches.begin())
                {
                    ShTimeStream* stream = new ShTimeStream(newID.str(), newTime, this, createTimeSlice(newTime));
                    stream->addTimeEvent(timeEvent);
                    timeBranches.insert(streamIter, stream);
                    return stream;
                }

                else
                {
                    ShTimeStream* stream = new ShTimeStream(newID.str(), newTime, this, createTimeSlice(newTime));
                    stream->addTimeEvent(timeEvent);
                    timeBranches.push_front(stream);
                    return stream;
                }
            }

            ++streamIter;
        }*/

        ShTimeStream* stream = new ShTimeStream(newID.str(), newTime, this, createTimeSlice(newTime));
        stream->addTimeEvent(timeEvent);
        timeBranches.push_back(stream);
        return stream;
    }
}

boost::chrono::steady_clock::time_point ShTimeStream::getCreationTime()
{
    boost::shared_lock<boost::shared_mutex> lock(mutex);
    return creationTime;
}

boost::chrono::steady_clock::time_point ShTimeStream::getCurrentTime()
{
    boost::shared_lock<boost::shared_mutex> lock(mutex);
    return currentTime;
}

boost::chrono::steady_clock::time_point ShTimeStream::getMostFutureTime()
{
    boost::shared_lock<boost::shared_mutex> lock(mutex);
    return mostFutureTime;
}

std::string ShTimeStream::getID()
{
    return id;
}

std::list<ShTimeStream*>& ShTimeStream::getTimeBranches()
{
    boost::shared_lock<boost::shared_mutex> lock(mutex);
    return timeBranches;
}

int ShTimeStream::numTimeBranches()
{
    return timeBranches.size();
}

std::list<ShTimeStream*>::iterator ShTimeStream::getTimeBranchesBeginIterator()
{
    boost::shared_lock<boost::shared_mutex> lock(mutex);
    return timeBranches.begin();
}

std::list<ShTimeStream*>::iterator ShTimeStream::getTimeBranchesEndIterator()
{
    boost::shared_lock<boost::shared_mutex> lock(mutex);
    return timeBranches.end();
}

std::list<ShTimeEvent*>& ShTimeStream::getTimeEvents()
{
    boost::shared_lock<boost::shared_mutex> lock(mutex);
    return timeEvents;
}

void ShTimeStream::updateTimeVars(boost::chrono::steady_clock::time_point newTime)
{
    currentTime = newTime;

    if(newTime > mostFutureTime)
    {
        mostFutureTime = newTime;

        if(mostFutureTime > ShTimeStream::globalMostFutureTime)
            ShTimeStream::globalMostFutureTime = mostFutureTime;
    }
}

TimeSlice ShTimeStream::createTimeSlice(boost::chrono::steady_clock::time_point sliceTime)
{
    TimeSlice timeSlice = initialTimeSlice;

    std::list<ShTimeEvent*>::iterator timeIter = timeEvents.begin();

    while(timeIter != timeEvents.end()) // collect events of each type
    {
        if((*timeIter)->getTimeStamp() < sliceTime)
        {
            switch((*timeIter)->type())
            {
            case TerrainStepsType:
                timeSlice.softAddStepEvent(static_cast<TerrainStepsEvent*>(*timeIter));
                break;

            case TerrainHeightsType:
                timeSlice.softAddHeightEvent(static_cast<TerrainHeightsEvent*>(*timeIter));
                break;

            case AvatarType:
                timeSlice.avatarEvent = (static_cast<AvatarEvent*>(*timeIter));
                break;

            case SnakeAddType:
                //snakeAddEvent = *timeIter;
                break;

            case SnakeRemoveType:
                //snakeRemoveEvent = *timeIter;
                break;

            case TempoType:
                timeSlice.tempo = (static_cast<TempoEvent*>(*timeIter));
                break;
            }

            ++timeIter;
        }

        else
        {
            break; // break the while loop if we've reached the new time
        }
    }

    return timeSlice;
}

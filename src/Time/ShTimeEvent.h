#ifndef SHTIMEEVENT_H
#define SHTIMEEVENT_H

// System includes
#include <vector>

// Boost includes
#include "boost/chrono.hpp"
#include "boost/chrono/time_point.hpp"

// Shoggoth includes
#include "src/network/ShNetwork.h"
#include "src/Graphics/ShSnakeRange.h"


///////////////
// ShTimeEvent
///////////////

enum TimeEventType
{
    AbstractEventType,
    TerrainStepsType,
    TerrainHeightsType,
    AvatarType,
    SnakeAddType,
    SnakeRemoveType,
    SnakeMoveType,
    SnakeResizeType,
    TempoType
};

// Abstract call for time events. Stores information about a change in the piece (terrain steps, avatar position, etc..)
// When called it will set the global state for that information.
class ShTimeEvent
{
public:
    ShTimeEvent(boost::chrono::steady_clock::time_point timeStamp);

    virtual void call() = 0; // Calls the event to be called
    virtual void undo(); // Undo the event, some events will use this, others will not
    virtual TimeEventType type();
    boost::chrono::steady_clock::time_point getTimeStamp();

private:

    boost::chrono::steady_clock::time_point timeStamp;
};


/////////////////////
// TerrainStepsEvent
/////////////////////

class TerrainStepsEvent : public ShTimeEvent
{
public:

    TerrainStepsEvent(int islandID, ShNetwork::algo_pair stepEvent, boost::chrono::steady_clock::time_point timeStamp);

    void call();
    void undo();
    TimeEventType type();

    int islandID;
    ShNetwork::algo_pair stepEvent;
};

/////////////////////
// TerrainHeightEvent
/////////////////////

class TerrainHeightsEvent : public ShTimeEvent
{
public:

    TerrainHeightsEvent(int islandID, ShNetwork::algo_pair heightEvent, boost::chrono::steady_clock::time_point timeStamp);

    void call();
    void undo();
    TimeEventType type();

    int islandID;
    ShNetwork::algo_pair heightEvent;
};

/////////////////////
// AvatarEvent
/////////////////////

class AvatarEvent : public ShTimeEvent
{
public:

    AvatarEvent(std::string avatar, cinder::Vec3f position,
                cinder::Quatf rotation, boost::chrono::steady_clock::time_point timeStamp);

    void call();
    void undo();
    TimeEventType type();

    std::string avatar;
    cinder::Vec3f position;
    cinder::Quatf rotation;
};

/////////////////
// SnakeAddEvent
/////////////////

class SnakeAddEvent : public ShTimeEvent
{
public:

    SnakeAddEvent(snake_range_id_t snakeID, std::string synthName, cinder::Vec2i corner1, cinder::Vec2i corner2,
                  cinder::Color color, ShIsland* island, boost::chrono::steady_clock::time_point timeStamp);

    void call();
    void undo();
    TimeEventType type();

    snake_range_id_t snakeID;
    std::string synthName;
    cinder::Vec2i corner1, corner2;
    cinder::Color color;
    ShIsland* island;
};

/////////////////////
// SnakeRemoveEvent
/////////////////////

class SnakeRemoveEvent : public ShTimeEvent
{
public:

    SnakeRemoveEvent(snake_range_id_t snakeID, std::string synthName, cinder::Vec2i corner1, cinder::Vec2i corner2,
                  cinder::Color color, ShIsland* island, boost::chrono::steady_clock::time_point timeStamp);

    void call();
    void undo();
    TimeEventType type();

    snake_range_id_t snakeID;
    std::string synthName;
    cinder::Vec2i corner1, corner2;
    cinder::Color color;
    ShIsland* island;
};

//////////////////
// SnakeMoveEvent
//////////////////
class SnakeMoveEvent : public ShTimeEvent
{
public:

    SnakeMoveEvent(snake_range_id_t snakeID, cinder::Vec2i position, cinder::Vec2i previousPosition,
                   boost::chrono::steady_clock::time_point timeStamp);

    void call();
    void undo();
    TimeEventType type();

    snake_range_id_t snakeID;
    cinder::Vec2i position, previousPosition;
};

////////////////////
// SnakeResizeEvent
////////////////////
class SnakeResizeEvent : public ShTimeEvent
{
public:

    SnakeResizeEvent(snake_range_id_t snakeID, cinder::Vec2i corner, cinder::Vec2i previousCorner,
                   boost::chrono::steady_clock::time_point timeStamp);

    void call();
    void undo();
    TimeEventType type();

    snake_range_id_t snakeID;
    cinder::Vec2i corner, previousCorner;
};

//////////////
// TempoEvent
//////////////

class TempoEvent: public ShTimeEvent
{
public:
    TempoEvent(boost::chrono::milliseconds tempo, boost::chrono::steady_clock::time_point timeStamp);

    void call();
    void undo();
    TimeEventType type();

    boost::chrono::milliseconds tempo;
};

/////////////
// TimeSlice
/////////////

// A time slice is the collection of all the events that make up any given moment of time
// This includes steps and heights for all islands, correct numbers of snakes for all islands, and avatar positions etc...

class TimeSlice
{
public:
    TimeSlice(); // Automatically populates the islandSteps and islandHeights with their current states

    void softAddStepEvent(TerrainStepsEvent *event); // If this is more recent, add it
    void softAddHeightEvent(TerrainHeightsEvent* event); // If this is more recent, add it

    void call(); // Calls all the contained events;

    std::vector<TerrainStepsEvent*> islandSteps;
    std::vector<TerrainHeightsEvent*> islandHeights;
    AvatarEvent* avatarEvent;
    TempoEvent* tempo;
};

#endif // SHTIMEEVENT_H

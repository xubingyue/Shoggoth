// local includes
#include "ShTimeEvent.h"
#include "src/ShGlobals.h"
#include "src/network/ShNetwork.h"

///////////////
// ShTimeEvent
///////////////

ShTimeEvent::ShTimeEvent(boost::chrono::steady_clock::time_point timeStamp) :
    timeStamp(timeStamp)
{

}

void ShTimeEvent::call()
{
    std::cout << "TIME EVENT: Abstract Event" << std::endl;
}

void ShTimeEvent::undo()
{

}

TimeEventType ShTimeEvent::type()
{
    return AbstractEventType;
}

boost::chrono::steady_clock::time_point ShTimeEvent::getTimeStamp()
{
    return timeStamp;
}


/////////////////////
// TerrainStepsEvent
/////////////////////

TerrainStepsEvent::TerrainStepsEvent(int islandID, ShNetwork::algo_pair stepEvent,
                                     boost::chrono::steady_clock::time_point timeStamp) :
    ShTimeEvent(timeStamp),
    islandID(islandID),
    stepEvent(stepEvent)
{

}

void TerrainStepsEvent::call() // override parent call
{
    switch(stepEvent.first)
    {
    case ShNetwork::Empty:
        ShGlobals::ISLAND_GRID->emptySteps(islandID, false);
        break;

    case ShNetwork::DiamondSquare:
        ShGlobals::ISLAND_GRID->diamondSquareSteps(islandID, stepEvent.second, false);
        break;

    case ShNetwork::Wolfram:
        ShGlobals::ISLAND_GRID->wolframCASteps(islandID, stepEvent.second, false);
        break;

    case ShNetwork::StrangeAttractor:
        ShGlobals::ISLAND_GRID->strangeSteps(islandID, stepEvent.second, false);
        break;

    case ShNetwork::LSystem:
        ShGlobals::ISLAND_GRID->lSystemSteps(islandID, stepEvent.second, false);
        break;

    case ShNetwork::Flocking:
        ShGlobals::ISLAND_GRID->flockingSteps(islandID, stepEvent.second, false);
        break;

    case ShNetwork::WaveTable:
        break;

    case ShNetwork::Graphics:
        break;
    }
}

void TerrainStepsEvent::undo()
{
    // Nothing to undo
}

TimeEventType TerrainStepsEvent::type()
{
    return TerrainStepsType;
}

/////////////////////
// TerrainHeightsEvent
/////////////////////

TerrainHeightsEvent::TerrainHeightsEvent(int islandID, ShNetwork::algo_pair heightEvent,
                                         boost::chrono::steady_clock::time_point timeStamp) :
    ShTimeEvent(timeStamp),
    islandID(islandID),
    heightEvent(heightEvent)
{

}

void TerrainHeightsEvent::call() // override parent call
{
    switch(heightEvent.first)
    {
    case ShNetwork::Empty:
        ShGlobals::ISLAND_GRID->emptyHeights(islandID, false);
        break;

    case ShNetwork::DiamondSquare:
        ShGlobals::ISLAND_GRID->diamondSquareHeights(islandID, heightEvent.second, false);
        break;

    case ShNetwork::Wolfram:
        ShGlobals::ISLAND_GRID->wolframHeights(islandID, heightEvent.second, false);
        break;

    case ShNetwork::StrangeAttractor:
        ShGlobals::ISLAND_GRID->strangeHeights(islandID, heightEvent.second, false);
        break;

    case ShNetwork::LSystem:
        ShGlobals::ISLAND_GRID->lSystemHeights(islandID, heightEvent.second, false);
        break;

    case ShNetwork::Flocking:
        ShGlobals::ISLAND_GRID->flockingHeights(islandID, heightEvent.second, false);
        break;

    case ShNetwork::WaveTable:
        break;

    case ShNetwork::Graphics:
        break;
    }
}

void TerrainHeightsEvent::undo()
{
    // Nothing to undo
}

TimeEventType TerrainHeightsEvent::type()
{
    return TerrainHeightsType;
}

/////////////////////
// AvatarEvent
/////////////////////

AvatarEvent::AvatarEvent(std::string avatar, cinder::Vec3f position, cinder::Quatf rotation,
                         boost::chrono::steady_clock::time_point timeStamp) :
    ShTimeEvent(timeStamp),
    avatar(avatar),
    position(position),
    rotation(rotation)
{

}

void AvatarEvent::call() // override parent call
{

}

void AvatarEvent::undo()
{

}

TimeEventType AvatarEvent::type()
{
    return AvatarType;
}

/////////////////
// SnakeAddEvent
/////////////////

SnakeAddEvent::SnakeAddEvent(snake_range_id_t snakeID, std::string synthName, cinder::Vec2i corner1,
                             cinder::Vec2i corner2, cinder::Color color, ShIsland *island,
                             boost::chrono::steady_clock::time_point timeStamp) :
    ShTimeEvent(timeStamp),
    snakeID(snakeID),
    synthName(synthName),
    corner1(corner1),
    corner2(corner2),
    color(color),
    island(island)
{

}

void SnakeAddEvent::call()
{
    ShGlobals::ISLAND_GRID->addShSnakeRange(snakeID, synthName, corner1, corner2, false, ShNetwork::ONLINE);
}

void SnakeAddEvent::undo()
{
    ShGlobals::ISLAND_GRID->removeSnakeRange(snakeID, false, ShNetwork::ONLINE);
}

TimeEventType SnakeAddEvent::type()
{
    return SnakeAddType;
}

/////////////////////
// SnakeRemoveEvent
/////////////////////

SnakeRemoveEvent::SnakeRemoveEvent(snake_range_id_t snakeID, std::string synthName, cinder::Vec2i corner1,
                             cinder::Vec2i corner2, cinder::Color color, ShIsland *island,
                             boost::chrono::steady_clock::time_point timeStamp) :
    ShTimeEvent(timeStamp),
    snakeID(snakeID),
    synthName(synthName),
    corner1(corner1),
    corner2(corner2),
    color(color),
    island(island)
{

}

void SnakeRemoveEvent::call()
{
    ShGlobals::ISLAND_GRID->removeSnakeRange(snakeID, false, ShNetwork::ONLINE);
}

void SnakeRemoveEvent::undo()
{
    ShGlobals::ISLAND_GRID->addShSnakeRange(snakeID, synthName, corner1, corner2, false, ShNetwork::ONLINE);
}

TimeEventType SnakeRemoveEvent::type()
{
    return SnakeRemoveType;
}

//////////////////
// SnakeMoveEvent
//////////////////
SnakeMoveEvent::SnakeMoveEvent(snake_range_id_t snakeID, cinder::Vec2i position, cinder::Vec2i previousPosition,
                               boost::chrono::steady_clock::time_point timeStamp) :
    ShTimeEvent(timeStamp),
    snakeID(snakeID),
    position(position),
    previousPosition(previousPosition)
{

}

void SnakeMoveEvent::call()
{
    ShGlobals::ISLAND_GRID->setSnakeRangePosition(snakeID, position, false, ShNetwork::ONLINE);
}

void SnakeMoveEvent::undo()
{
    ShGlobals::ISLAND_GRID->setSnakeRangePosition(snakeID, previousPosition, false, ShNetwork::ONLINE);
}

TimeEventType SnakeMoveEvent::type()
{
    return SnakeMoveType;
}

////////////////////
// SnakeResizeEvent
////////////////////
SnakeResizeEvent::SnakeResizeEvent(snake_range_id_t snakeID, cinder::Vec2i corner, cinder::Vec2i previousCorner,
                                   boost::chrono::steady_clock::time_point timeStamp) :
    ShTimeEvent(timeStamp),
    snakeID(snakeID),
    corner(corner),
    previousCorner(previousCorner)
{

}

void SnakeResizeEvent::call()
{
    ShGlobals::ISLAND_GRID->setSnakeRangeCorner(snakeID, corner, false, ShNetwork::ONLINE);
}

void SnakeResizeEvent::undo()
{
    ShGlobals::ISLAND_GRID->setSnakeRangeCorner(snakeID, previousCorner, false, ShNetwork::ONLINE);
    //std::cout << "SnakeResizeEvent::undo" << std::endl;
}

TimeEventType SnakeResizeEvent::type()
{
    return SnakeResizeType;
}

//////////////
// TempoEvent
//////////////

TempoEvent::TempoEvent(boost::chrono::milliseconds tempo, boost::chrono::steady_clock::time_point timeStamp) :
    ShTimeEvent(timeStamp),
    tempo(tempo)
{

}

void TempoEvent::call()
{
    if(ShNetwork::ONLINE)
        ShNetwork::sendSetTempo(tempo.count());
    else
        ShGlobals::SEQUENCER->setStepQuant(tempo);
}

void TempoEvent::undo()
{

}

TimeEventType TempoEvent::type()
{
    return TempoType;
}

/////////////
// TimeSlice
/////////////

TimeSlice::TimeSlice() :
    avatarEvent(0),
    tempo(0)
{
    for(int i = 0; i < ShIslandGrid::NUM_ISLANDS; ++i) // Populate initial events
    {
        islandSteps.push_back(0);
        islandHeights.push_back(0);
    }
}

void TimeSlice::softAddStepEvent(TerrainStepsEvent* event)
{
    if(islandSteps.at(event->islandID))
    {
        if(islandSteps.at(event->islandID)->getTimeStamp() < event->getTimeStamp())
        {
            islandSteps[event->islandID] = event;
        }
    }

    else
    {
        islandSteps[event->islandID] = event;
    }
}

void TimeSlice::softAddHeightEvent(TerrainHeightsEvent *event)
{
    if(islandHeights.at(event->islandID))
    {
        if(islandHeights.at(event->islandID)->getTimeStamp() < event->getTimeStamp())
        {
            islandHeights[event->islandID] = event;
        }
    }

    else
    {
        islandHeights[event->islandID] = event;
    }
}

void TimeSlice::call()
{
    for(int i = 0; i < islandSteps.size(); ++i) // initialize islands to empty at 00:00
    {
        islandSteps.at(i)->call();
        islandHeights.at(i)->call();
    }

    if(avatarEvent)
        avatarEvent->call();

    if(tempo)
        tempo->call();
}

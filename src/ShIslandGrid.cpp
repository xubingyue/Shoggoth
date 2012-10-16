/*
 *  ShIslandGrid.cpp
 *  Shoggoth
 *
 *  Created by Chad McKinney on 4/18/12.
 *
 */
#include <iostream>


#include "src/ShIslandGrid.h"
#include "src/Graphics/ShIsland.h"
#include "src/ArtificialLife/CellularAutomata.h"
#include "src/shmath.h"
#include "src/Graphics/ShSeqPath.h"
#include "src/ShGlobals.h"
#include "src/Graphics/ShDiamondSquare.h"
#include "src/Fractal/Fractal.h"
#include "src/Fractal/LSystem.h"
#include "src/ArtificialLife/Flocking.h"
#include "src/Time/ShTimer.h"
#include "src/Time/ShTimeEvent.h"

using namespace ci;
using namespace gl;
using namespace alife;
using namespace cell;
using namespace std;
using namespace ShNetwork;
using namespace fractal;

ShIslandGrid::ShIslandGrid() :
    snakeRangeIDCounter(0),
    selectedSnakeRange(0)
{
	createIslands();

    for(int i = 0; i < NUM_ISLANDS; ++i)
    {
        snakeRangeGrid[i] = std::vector<ShSnakeRange*>();
    }

    ShGlobals::ISLAND_GRID = this;
}

ShIslandGrid::~ShIslandGrid()
{
    removeAllSnakeRanges();

    boost::upgrade_lock<boost::shared_mutex> lock(mutex);
    boost::upgrade_to_unique_lock<boost::shared_mutex> writeLock(lock);

    std::deque<ShSnakeRange*>::iterator iter = deleteSnakeQueue.begin();

    while(iter != deleteSnakeQueue.end())
    {
        delete *iter;
        ++iter;
    }

    deleteSnakeQueue.clear();

    // Delete islands
    for(int i = 0; i < NUM_ISLANDS; ++i)
    {
        delete islands[i];
        islands[i] = NULL;
    }

    delete[] islands;
}

void ShIslandGrid::drawIslands()
{
    boost::upgrade_lock<boost::shared_mutex> lock(mutex);
    boost::upgrade_to_unique_lock<boost::shared_mutex> writeLock(lock);

    glEnable(GL_CULL_FACE);
    cinder::gl::disableAlphaBlending();

	for(int i = 0; i < NUM_ISLANDS; ++i)
	{
		islands[i]->draw();
	}

    if(deleteSnakeQueue.size() > 0)
    {
        delete deleteSnakeQueue.front();
        deleteSnakeQueue.pop_front();
    }
}

void ShIslandGrid::drawSnakeRanges(bool drawActive)
{
    boost::upgrade_lock<boost::shared_mutex> lock(mutex);
    boost::upgrade_to_unique_lock<boost::shared_mutex> writeLock(lock);

    glDisable(GL_CULL_FACE);

    cinder::gl::enableAlphaBlending();

    for(int i = 0; i < NUM_ISLANDS; ++i)
    {
        for(int j = 0; j < snakeRangeGrid[i].size(); ++j)
        {
            snakeRangeGrid[i][j]->draw(drawActive);
        }
    }
}

void ShIslandGrid::drawSnakeRangeHilight()
{
    boost::upgrade_lock<boost::shared_mutex> lock(mutex);
    boost::upgrade_to_unique_lock<boost::shared_mutex> writeLock(lock);

    std::tr1::unordered_map<unsigned int, ShSnakeRange*>::iterator find = snakeRangeMap.find(selectedSnakeRange);
    if(find != snakeRangeMap.end())
    {
        find->second->drawHighlight();
    }
}

void ShIslandGrid::drawSnakeRangNames()
{
    boost::upgrade_lock<boost::shared_mutex> lock(mutex);
    boost::upgrade_to_unique_lock<boost::shared_mutex> writeLock(lock);

    for(int i = 0; i < NUM_ISLANDS; ++i)
    {
        for(int j = 0; j < snakeRangeGrid[i].size(); ++j)
        {
            snakeRangeGrid[i][j]->drawName();
        }
    }
}

void ShIslandGrid::drawBoundingBoxes()
{	
    boost::shared_lock<boost::shared_mutex> lock(mutex);

	for(int i = 0; i < NUM_ISLANDS; ++i)
	{
		gl::drawStrokedCube(islands[i]->mBoundingBox);
	}
}

void ShIslandGrid::drawBoundingBox(int id)
{
    boost::shared_lock<boost::shared_mutex> lock(mutex);
    gl::drawStrokedCube(islands[id]->mBoundingBox);
}

void ShIslandGrid::setup(cinder::Vec3f cameraPos)
{
    boost::shared_lock<boost::shared_mutex> lock(mutex);

	for(int i = 0; i < NUM_ISLANDS; ++i)
	{
		islands[i]->setup(cameraPos);
	}
}

void ShIslandGrid::update()
{
    boost::upgrade_lock<boost::shared_mutex> lock(mutex);
    boost::upgrade_to_unique_lock<boost::shared_mutex> writeLock(lock);

	for(int i = 0; i < NUM_ISLANDS; ++i)
	{
        islands[i]->update();
	}
}

void ShIslandGrid::createWaveTerrainBuffers()
{
    boost::upgrade_lock<boost::shared_mutex> lock(mutex);
    boost::upgrade_to_unique_lock<boost::shared_mutex> writeLock(lock);

    for(int i = 0; i < NUM_ISLANDS; ++i)
    {
        islands[i]->createWaveTerrainBuffer();
    }
}

void ShIslandGrid::freeWaveTerrainBuffers()
{
    boost::upgrade_lock<boost::shared_mutex> lock(mutex);
    boost::upgrade_to_unique_lock<boost::shared_mutex> writeLock(lock);

    for(int i = 0; i < NUM_ISLANDS; ++i)
    {
        islands[i]->freeWaveTerrainBuffer();
    }
}

bool ShIslandGrid::getTriCoor(int id, unsigned int index, SeqTri* pickedTri)
{
    boost::shared_lock<boost::shared_mutex> lock(mutex);
    return islands[id]->getTriCoord(index, pickedTri);
}

snake_range_id_t ShIslandGrid::addShSnakeRange(int islandID, string synthName, Vec2i corner1, Vec2i corner2,
                                               bool addTimeEvent, bool sendToNetwork)
{
    boost::upgrade_lock<boost::shared_mutex> lock(mutex);
    boost::upgrade_to_unique_lock<boost::shared_mutex> writeLock(lock);

    snake_range_id_t snakeID = std::make_pair(islandID, snakeRangeIDCounter);

    if(sendToNetwork)
    {
        ShNetwork::sendAddSnakeRange(snakeID, synthName, corner1, corner2);
        return snakeID;
    }

    else
    {
        std::cout << "Add Snake Range!" << std::endl;

        std::tr1::unordered_map<unsigned int, ShSnakeRange*>::iterator find = snakeRangeMap.find(snakeID.second);
        if(find == snakeRangeMap.end())
        {
            ShSnakeRange* snakeRange = new ShSnakeRange(
                        snakeID,
                        synthName,
                        corner1,
                        corner2,
                        cinder::ColorA(0.25, 0, 0, 0.05),
                        islands[islandID],
                        ShNetwork::ONLINE
            );

            snakeRangeGrid[islandID].push_back(snakeRange);
            snakeRangeMap[snakeID.second] = snakeRange;
            selectedSnakeRange = snakeID.second;
            ++snakeRangeIDCounter;

            if(addTimeEvent)
            {
                ShGlobals::TIME_STREAM_SCHEDULER->addTimeEvent(
                            new SnakeAddEvent(
                                snakeID,
                                synthName,
                                corner1,
                                corner2,
                                cinder::ColorA(0.25, 0, 0, 0.05),
                                islands[islandID],
                                ShGlobals::TIME_STREAM_TIMER->getTime()
                            )
                );
            }

            return snakeID;
        }
    }
}

void ShIslandGrid::addShSnakeRange(snake_range_id_t snakeID, std::string synthName, cinder::Vec2i corner1,
                     cinder::Vec2i corner2, bool addTimeEvent, bool sendToNetwork)
{
    boost::upgrade_lock<boost::shared_mutex> lock(mutex);
    boost::upgrade_to_unique_lock<boost::shared_mutex> writeLock(lock);

    if(sendToNetwork)
    {
        ShNetwork::sendAddSnakeRange(snakeID, synthName, corner1, corner2);
    }

    else
    {
        std::tr1::unordered_map<unsigned int, ShSnakeRange*>::iterator find = snakeRangeMap.find(snakeID.second);
        if(find == snakeRangeMap.end())
        {
            std::cout << "TimeEvent Add Snake Range Island: " << snakeID.first << " ID: " << snakeID.second << std::endl;
            ShSnakeRange* snakeRange = new ShSnakeRange(
                        snakeID,
                        synthName,
                        corner1,
                        corner2,
                        cinder::ColorA(0.25, 0, 0, 0.05),
                        islands[snakeID.first],
                        (!addTimeEvent) || ShNetwork::ONLINE
            );

            std::cout << "Done making time event snake range" << std::endl;

            snakeRangeGrid[snakeID.first].push_back(snakeRange);
            snakeRangeMap[snakeID.second] = snakeRange;
            selectedSnakeRange = snakeID.second;
            ++snakeRangeIDCounter;

            if(addTimeEvent)
            {
                ShGlobals::TIME_STREAM_SCHEDULER->addTimeEvent(
                            new SnakeAddEvent(
                                snakeID,
                                synthName,
                                corner1,
                                corner2,
                                cinder::ColorA(0.25, 0, 0, 0.05),
                                islands[snakeID.first],
                                ShGlobals::TIME_STREAM_TIMER->getTime()
                            )
                );
            }
        }
    }
}

void ShIslandGrid::removeSnakeRange(snake_range_id_t snakeID, bool addTimeEvent, bool sendToNetwork)
{
    boost::upgrade_lock<boost::shared_mutex> lock(mutex);
    boost::upgrade_to_unique_lock<boost::shared_mutex> writeLock(lock);

    if(sendToNetwork)
    {
        ShNetwork::sendRemoveSnakeRange(snakeID);
    }

    else
    {
        std::tr1::unordered_map<unsigned int, ShSnakeRange*>::iterator find = snakeRangeMap.find(snakeID.second);
        if(find != snakeRangeMap.end())
        {
            ShSnakeRange* snakeRange = find->second;

            snakeRangeMap.erase(snakeID.second);

            for(int i = 0; i < snakeRangeGrid[snakeID.first].size(); ++i)
            {
                if(snakeRangeGrid[snakeID.first].at(i)->getID() == snakeID)
                {
                    snakeRangeGrid[snakeID.first].erase(snakeRangeGrid[snakeID.first].begin() + i);
                    break;
                }
            }

            if(addTimeEvent)
            {
                ShGlobals::TIME_STREAM_SCHEDULER->addTimeEvent(
                            new SnakeRemoveEvent(
                                snakeID,
                                snakeRange->getSynthName(),
                                snakeRange->getCorner1(),
                                snakeRange->getCorner2(),
                                snakeRange->getColor(),
                                islands[snakeID.first],
                                ShGlobals::TIME_STREAM_TIMER->getTime()
                            )
                );
            }

            queueDeleteSnakeRange(snakeRange);
        }
    }
}

void ShIslandGrid::removeCurrentlySelectedSnakeRange()
{
    boost::shared_lock<boost::shared_mutex> lock(mutex);

    std::tr1::unordered_map<unsigned int, ShSnakeRange*>::iterator find = snakeRangeMap.find(selectedSnakeRange);
    if(find != snakeRangeMap.end())
    {
        ShSnakeRange* snakeRange = find->second;
        snake_range_id_t snakeID = snakeRange->getID();

        if(ShNetwork::ONLINE)
        {
            ShNetwork::sendRemoveSnakeRange(snakeID);
        }

        else
        {
            lock.unlock();
            removeSnakeRange(snakeID, true, ShNetwork::ONLINE);
        }
    }
}

void ShIslandGrid::setSnakeRangePosition(snake_range_id_t snakeID, cinder::Vec2i corner, bool addTimeEvent, bool sendToNetwork)
{
    boost::upgrade_lock<boost::shared_mutex> lock(mutex);
    boost::upgrade_to_unique_lock<boost::shared_mutex> writeLock(lock);

    std::tr1::unordered_map<unsigned int, ShSnakeRange*>::iterator find = snakeRangeMap.find(snakeID.second);

    if(find != snakeRangeMap.end())
    {
        ShSnakeRange* snakeRange = find->second;
        cinder::Vec2i previousPosition = snakeRange->getPosition();
        cinder::Vec2i currentCorner = snakeRange->getCorner2();

        if(sendToNetwork)
        {
            //cinder::Vec2i difference = corner - previousPosition;
            ShNetwork::sendSnakeRangePosition(snakeID, corner);
            //ShNetwork::sendSnakeRangeCorner(snakeID, currentCorner + difference);
        }

        else
        {
            snakeRange->move(corner, (!addTimeEvent) || ShNetwork::ONLINE);

            if(addTimeEvent)
            {
                ShGlobals::TIME_STREAM_SCHEDULER->addTimeEvent(
                            new SnakeMoveEvent(
                                snakeID,
                                snakeRange->getPosition(),
                                previousPosition,
                                ShGlobals::TIME_STREAM_TIMER->getTime()
                            )
                );
            }
        }
    }
}

void ShIslandGrid::setSnakeRangeCorner(snake_range_id_t snakeID, cinder::Vec2i corner, bool addTimeEvent, bool sendToNetwork)
{
    boost::upgrade_lock<boost::shared_mutex> lock(mutex);
    boost::upgrade_to_unique_lock<boost::shared_mutex> writeLock(lock);

    if(sendToNetwork)
    {
        ShNetwork::sendSnakeRangeCorner(snakeID, corner);
    }

    else
    {
        std::tr1::unordered_map<unsigned int, ShSnakeRange*>::iterator find = snakeRangeMap.find(snakeID.second);
        if(find != snakeRangeMap.end())
        {
            ShSnakeRange* snakeRange = find->second;
            cinder::Vec2i previousCorner = snakeRange->getCorner2();
            snakeRange->setCorner2(corner, (!addTimeEvent) || ShNetwork::ONLINE);

            if(addTimeEvent)
            {
                ShGlobals::TIME_STREAM_SCHEDULER->addTimeEvent(
                            new SnakeResizeEvent(
                                snakeID,
                                snakeRange->getCorner2(),
                                previousCorner,
                                ShGlobals::TIME_STREAM_TIMER->getTime()
                            )
                );
            }
        }
    }
}

snake_range_id_t ShIslandGrid::getCurrentlySelectedSnakeRangeID()
{
    boost::shared_lock<boost::shared_mutex> lock(mutex);

    std::tr1::unordered_map<unsigned int, ShSnakeRange*>::iterator find = snakeRangeMap.find(selectedSnakeRange);

    if(find != snakeRangeMap.end())
    {
        return find->second->getID();
    }

    else
    {
        return std::make_pair(0, 0);
    }

}

void ShIslandGrid::setSelectedSnakeRange(unsigned int id)
{
    boost::upgrade_lock<boost::shared_mutex> lock(mutex);
    boost::upgrade_to_unique_lock<boost::shared_mutex> writeLock(lock);

    std::tr1::unordered_map<unsigned int, ShSnakeRange*>::iterator find = snakeRangeMap.find(id);
    if(find != snakeRangeMap.end())
    {
        selectedSnakeRange = id;
    }
}

int ShIslandGrid::getNumSnakeRanges()
{
    boost::shared_lock<boost::shared_mutex> lock(mutex);
    return snakeRangeMap.size();
}

void ShIslandGrid::removeAllSnakeRanges()
{
    boost::upgrade_lock<boost::shared_mutex> lock(mutex);
    boost::upgrade_to_unique_lock<boost::shared_mutex> writeLock(lock);

    // delete snakeRanges
    for(int i = 0; i < NUM_ISLANDS; ++i)
    {
        for(int j = 0; j < snakeRangeGrid[i].size(); ++j)
        {
            delete snakeRangeGrid[i][j];
        }

        snakeRangeGrid[i].clear();
    }

    snakeRangeMap.clear();
    snakeRangeIDCounter = 0;
}

void ShIslandGrid::queueDeleteSnakeRange(ShSnakeRange* snakeRange)
{
    // boost::upgrade_lock<boost::shared_mutex> lock(mutex);
    // boost::upgrade_to_unique_lock<boost::shared_mutex> writeLock(lock);
    deleteSnakeQueue.push_back(snakeRange);
}

void ShIslandGrid::step(int stepDirection)
{
    boost::upgrade_lock<boost::shared_mutex> lock(mutex);
    boost::upgrade_to_unique_lock<boost::shared_mutex> writeLock(lock);

    for(int i = 0; i < NUM_ISLANDS; ++i)
    {
        for(int j = 0; j < snakeRangeGrid[i].size(); ++j)
        {
            snakeRangeGrid[i][j]->increment();
        }
    }
}

ShIsland* ShIslandGrid::getIsland(int id)
{
    boost::shared_lock<boost::shared_mutex> lock(mutex);

	if(id < NUM_ISLANDS)
		return islands[id];
	else
		return NULL;
}

ShIsland* ShIslandGrid::getIsland(int x, int y)
{
    boost::shared_lock<boost::shared_mutex> lock(mutex);

	int id = coordToID(x, y);
	
	if(id < NUM_ISLANDS)
		return islands[id];
	
	else
		return NULL;
}

ShIsland** ShIslandGrid::getIslands()
{
    boost::shared_lock<boost::shared_mutex> lock(mutex);
	return islands;
}

ShNetwork::algo_pair ShIslandGrid::getIslandStepGen(int id)
{
    boost::shared_lock<boost::shared_mutex> lock(mutex);
    return islands[id]->getStepGen();
}

ShNetwork::algo_pair ShIslandGrid::getIslandHeightGen(int id)
{
    boost::shared_lock<boost::shared_mutex> lock(mutex);
    return islands[id]->getTerrainGen();
}

void ShIslandGrid::emptySteps(int id, bool addTimeEvent) // Turn off all the steps
{
    boost::upgrade_lock<boost::shared_mutex> lock(mutex);
    boost::upgrade_to_unique_lock<boost::shared_mutex> writeLock(lock);

    algo_pair currentGen = islands[id]->getStepGen();
    algo_pair newGen = make_pair(ShNetwork::Empty, 0);
    bool update = (newGen.first != currentGen.first) || (newGen.second != currentGen.second);

    if(update)
    {
        islands[id]->clearValues();
        islands[id]->setScheduleBufferColors(true);
        islands[id]->setStepGen(newGen);

        if(addTimeEvent)
        {
            ShGlobals::TIME_STREAM_SCHEDULER->addTimeEvent(
                        new TerrainStepsEvent(
                            id,
                            newGen,
                            ShGlobals::TIME_STREAM_TIMER->getTime()
                        )
            );
        }
    }
}

void ShIslandGrid::diamondSquareSteps(int id, unsigned char seed, bool addTimeEvent)
{
    boost::upgrade_lock<boost::shared_mutex> lock(mutex);
    boost::upgrade_to_unique_lock<boost::shared_mutex> writeLock(lock);

    algo_pair currentGen = islands[id]->getStepGen();
    algo_pair newGen = make_pair(ShNetwork::DiamondSquare, seed);
    bool update = (newGen.first != currentGen.first) || (newGen.second != currentGen.second);

    if(update)
    {
        srand(seed);
        ShDiamondSquare terrain(seed, ShIsland::kTriangleGridWidth + 1, ShIsland::kTriangleGridHeight + 1, 0, 200);
        int minHeight = terrain.getMin();
        int maxHeight = terrain.getMax();
        //int threshold = (maxHeight - minHeight) / 2.0;
        double offsetMax = maxHeight - minHeight;
        double ratio = (double) ShIsland::kTriangleGridHeight / offsetMax;
        int skip = randomRange(2, 5);

        for(int y = 0; y < ShIsland::kTriangleGridHeight; ++y)
        {
            for(int x = 0; x < ShIsland::kTriangleGridWidth; ++x)
            {
                int value = 0;

                //if(terrain.getValue(x, y) - minHeight > threshold)
                //    value = 1;

                islands[id]->setValue(x, y, value);
            }
        }

        for(int i = 0; i < ShIsland::kGridDepth; ++i)
        {
            for(int x = 0; x < ShIsland::kGridWidth; ++x)
            {
                int value = ((((double) (terrain.getValue(x, i) - minHeight)) * ratio) - 34.0) * 33.0;

                if(value < ShIsland::kTriangleGridHeight && value > 0)
                {
                    if(x * skip < ShIsland::kTriGridWidth)
                        islands[id]->setValue((x * skip), value, 1);
                    //islands[id]->setValue((x * 2) + 1, value, 1);
                }
            }
        }

        islands[id]->setScheduleBufferColors(true);
        islands[id]->setStepGen(newGen);

        if(addTimeEvent)
        {
            ShGlobals::TIME_STREAM_SCHEDULER->addTimeEvent(
                        new TerrainStepsEvent(
                            id,
                            newGen,
                            ShGlobals::TIME_STREAM_TIMER->getTime()
                        )
            );
        }
    }
}

void ShIslandGrid::wolframCASteps(int id, unsigned char ruleSet, bool addTimeEvent)
{
    boost::upgrade_lock<boost::shared_mutex> lock(mutex);
    boost::upgrade_to_unique_lock<boost::shared_mutex> writeLock(lock);

    algo_pair currentGen = islands[id]->getStepGen();
    algo_pair newGen = make_pair(ShNetwork::Wolfram, ruleSet);
    bool update = (newGen.first != currentGen.first) || (newGen.second != currentGen.second);

    if(update)
    {
        Automata automata;
        WolframCA* ca;

        //was randomRange(0, 2)
        switch(0) // Initialize the CA to random settings
        {
        case 0:
            ca = new WolframCA(ruleSet, 2, 1, ShIsland::kTriangleGridWidth);
            break;

        case 1:
            ca = new WolframCA(randomRange(0, 1457), 3, randomRange(1, 2), ShIsland::kTriangleGridWidth);
            break;

        case 2:
            // Shouldn't be 10790979 but some actually correct number
            ca = new WolframCA(randomRange(0, 10790979), 4, randomRange(1, 3), ShIsland::kTriangleGridWidth);
            break;
        }

        for(int i = 0; i < ShIsland::kTriangleGridHeight; ++i)
        {
            automata.history.push_front(ca->getCurrentState());

            if(i < ShIsland::kTriangleGridHeight - 1)
                ca->advance();
        }

        for(int y = 0; y < ShIsland::kTriangleGridHeight; ++y)
        {
            for(int x = 0; x < ShIsland::kTriangleGridWidth; ++x)
            {
                islands[id]->setValue(x, y, automata.history[y][x]); // Set the triangle grid activity
            }
        }

        islands[id]->setScheduleBufferColors(true); // Update the colors of the island
        delete ca;
        islands[id]->setStepGen(newGen);

        if(addTimeEvent)
        {
            ShGlobals::TIME_STREAM_SCHEDULER->addTimeEvent(
                        new TerrainStepsEvent(
                            id,
                            newGen,
                            ShGlobals::TIME_STREAM_TIMER->getTime()
                        )
            );
        }
    }
}

void ShIslandGrid::strangeSteps(int id, unsigned char seed, bool addTimeEvent)
{
    boost::upgrade_lock<boost::shared_mutex> lock(mutex);
    boost::upgrade_to_unique_lock<boost::shared_mutex> writeLock(lock);

    algo_pair currentGen = islands[id]->getStepGen();
    algo_pair newGen = make_pair(ShNetwork::StrangeAttractor, seed);
    bool update = (newGen.first != currentGen.first) || (newGen.second != currentGen.second);

    if(update)
    {
        geometry::Array2D strangeArray(ShIsland::kTriangleGridWidth, ShIsland::kTriangleGridHeight);

        srand(seed);
        int skip = randomRange(1, 4);

        pickover2DFill(strangeArray, 40000, 10, ShIsland::kTriangleGridWidth / 3,
                   shmath::randomRange(-ShIsland::kTriangleGridWidth / 4, ShIsland::kTriangleGridWidth / 4),
                   shmath::randomRange(-ShIsland::kTriangleGridHeight / 4, ShIsland::kTriangleGridHeight / 4),
                   shmath::randomRange(-2000, 2000) / 100000.0 + -0.966918,
                   shmath::randomRange(-2000, 2000) / 100000.0 + 2.879879,
                   shmath::randomRange(-2000, 2000) / 1000.0,
                   shmath::randomRange(-2000, 2000) / 1000.0);

        for(int y = 0; y < ShIsland::kTriangleGridHeight; ++y)
        {
            for(int x = 0; x < ShIsland::kTriangleGridWidth; ++x)
            {
                if(x % skip == 0)
                    islands[id]->setValue(x, y, strangeArray[x][y]); // Set the triangle grid activity
                else
                    islands[id]->setValue(x, y, 0);

                /*
                if(strangeArray[x][y] > 0)
                {
                    if(x - 1 < ShIsland::kTriangleGridWidth && x - 1 >= 0)
                    {
                        islands[id]->setValue(x - 1, y, 1); // Set the triangle grid activity
                    }

                    if(x + 1 < ShIsland::kTriangleGridWidth && x + 1 >= 0)
                    {
                        islands[id]->setValue(x + 1, y, 1); // Set the triangle grid activity
                    }

                    if(y - 1 < ShIsland::kTriangleGridHeight && y - 1 >= 0)
                    {
                        islands[id]->setValue(x, y - 1, 1); // Set the triangle grid activity
                    }

                    if(y + 1 < ShIsland::kTriangleGridHeight && y + 1 >= 0)
                    {
                        islands[id]->setValue(x, y + 1, 1); // Set the triangle grid activity
                    }
                }*/
            }
        }

        islands[id]->setScheduleBufferColors(true);
        islands[id]->setStepGen(newGen);

        if(addTimeEvent)
        {
            ShGlobals::TIME_STREAM_SCHEDULER->addTimeEvent(
                        new TerrainStepsEvent(
                            id,
                            newGen,
                            ShGlobals::TIME_STREAM_TIMER->getTime()
                        )
            );
        }
    }
}

void ShIslandGrid::lSystemSteps(int id, unsigned char seed, bool addTimeEvent)
{
    boost::upgrade_lock<boost::shared_mutex> lock(mutex);
    boost::upgrade_to_unique_lock<boost::shared_mutex> writeLock(lock);

    algo_pair currentGen = islands[id]->getStepGen();
    algo_pair newGen = make_pair(ShNetwork::LSystem, seed);
    bool update = (newGen.first != currentGen.first) || (newGen.second != currentGen.second);

    if(update)
    {
        srand(seed);
        rule_set ruleSet;

        std::string currentRule("F+[+F-F-F]-[-F+F+F]");
        ruleSet.push_back(Rule(fractal::alphabet[randomRange(0, 5)], currentRule));
        currentRule.clear();

        for(int i = 0; i < randomRange(2, 5); ++i)
        {
            for(int j = 0; j < randomRange(7, 30); ++j)
            {
                currentRule.append(1, fractal::alphabet[randomRange(0, 5)]);
            }

            ruleSet.push_back(Rule(fractal::alphabet[randomRange(0, 5)], currentRule));
            currentRule.clear();
        }

        currentRule.append(&fractal::alphabet[randomRange(0, 5)]);

        for(int j = 0; j < randomRange(3, 17); ++j)
        {
            currentRule.append(1, fractal::alphabet[randomRange(0, 5)]);
        }

        fractal::LSystem lSystem(currentRule, ruleSet);

        std::string sentence;
        int sentenceLength;
        //std::cout << "L-System string length: " << sentenceLength << std::endl;

        islands[id]->clearValues();
        geometry::Vec2i coord(randomRange(0, (int) ShIsland::kTriangleGridWidth),
                             randomRange(0, (int) ShIsland::kTriangleGridHeight));
        geometry::Vec2i direction(randomRange(-1, 1), randomRange(-1, 1));

        std::vector< std::pair<geometry::Vec2i, geometry::Vec2i> > stack;
        stack.push_back(std::make_pair(coord, direction));

        if(direction == geometry::Vec2i(0, 0))
            direction = geometry::Vec2i(1, 0);

        islands[id]->setValue(coord.x, coord.y, 1);

        int length;

        for(int i = 3; i >= 0; --i)
        {
            lSystem.generate();
            sentence = lSystem.getSentence();
            sentenceLength = sentence.length();
            length = pow(2.0, i + 1) / 2;

            for(int j = 0; j < sentenceLength; ++j)
            {
                char c = sentence.at(j);

                switch(c)
                {
                case 'F':

                    for(int k = 0; k < length; ++k) // draw a line as along as our length
                    {
                        coord = coord + direction;

                        if(coord.x >= ShIsland::kTriangleGridWidth)
                            coord.x = 0;

                        else if(coord.x < 0)
                            coord.x = ShIsland::kTriangleGridWidth -1;

                        if(coord.y >= ShIsland::kTriangleGridHeight)
                            coord.y = 0;

                        else if(coord.y < 0)
                            coord.y = ShIsland::kTriangleGridHeight -1;

                        if(coord.x < ShIsland::kTriangleGridWidth && coord.x >= 0
                                && coord.y < ShIsland::kTriangleGridHeight && coord.y >= 0)
                        {
                            islands[id]->setValue(coord.x, coord.y, 1);
                        }
                    }

                    break;

                case 'G':

                    for(int k = 0; k < length; ++k) // draw a line as along as our length
                    {
                        coord += direction;

                        if(coord.x >= ShIsland::kTriangleGridWidth)
                            coord.x = 0;

                        else if(coord.x < 0)
                            coord.x = ShIsland::kTriangleGridWidth -1;

                        if(coord.y >= ShIsland::kTriangleGridHeight)
                            coord.y = 0;

                        else if(coord.y < 0)
                            coord.y = ShIsland::kTriangleGridHeight -1;

                        if(coord.x < ShIsland::kTriangleGridWidth && coord.x >= 0
                                && coord.y < ShIsland::kTriangleGridHeight && coord.y >= 0)
                        {
                            islands[id]->setValue(coord.x, coord.y, 1);
                        }
                    }

                    break;

                case '+':

                    // Rotate clockwise
                    if(direction == geometry::Vec2i(0, 1))
                        direction = geometry::Vec2i(1, 0);

                    //else if(direction == geometry::Vec2i(1, 1))
                    //        direction = geometry::Vec2i(1, 0);

                    else if(direction == geometry::Vec2i(1, 0))
                            direction = geometry::Vec2i(0, -1);

                    //else if(direction == geometry::Vec2i(1, -1))
                    //        direction = geometry::Vec2i(0, -1);

                    else if(direction == geometry::Vec2i(0, -1))
                            direction = geometry::Vec2i(-1, 0);

                    //else if(direction == geometry::Vec2i(-1, -1))
                    //        direction = geometry::Vec2i(-1, 0);

                    else if(direction == geometry::Vec2i(-1, 0))
                            direction = geometry::Vec2i(0, 1);

                    //else if(direction == geometry::Vec2i(-1, 1))
                    //        direction = geometry::Vec2i(0, 1);

                    break;

                case '-':

                    // Rotate counter clockwise
                    if(direction == geometry::Vec2i(0, 1))
                        direction = geometry::Vec2i(-1, 0);

                    //else if(direction == geometry::Vec2i(-1, 1))
                    //        direction = geometry::Vec2i(-1, 0);

                    else if(direction == geometry::Vec2i(-1, 0))
                            direction = geometry::Vec2i(0, -1);

                    //else if(direction == geometry::Vec2i(-1, -1))
                    //        direction = geometry::Vec2i(0, -1);

                    else if(direction == geometry::Vec2i(0, -1))
                            direction = geometry::Vec2i(1, 0);

                    //else if(direction == geometry::Vec2i(1, -1))
                    //        direction = geometry::Vec2i(1, 0);

                    else if(direction == geometry::Vec2i(1, 0))
                            direction = geometry::Vec2i(0, 1);

                    //else if(direction == geometry::Vec2i(1, 1))
                    //        direction = geometry::Vec2i(0, 1);

                    break;

                case '[': // Push Matrix
                    stack.push_back(std::make_pair(coord, direction));
                    break;

                case ']': // Pop Matrix

                    if(stack.size() > 0)
                    {
                        coord = stack.back().first;
                        direction = stack.back().second;
                        stack.pop_back();
                    }

                    break;

                default:
                    std::cout << "Default Char: " << c << std::endl;
                }
            }
        }

        islands[id]->setScheduleBufferColors(true);
        islands[id]->setStepGen(newGen);

        if(addTimeEvent)
        {
            ShGlobals::TIME_STREAM_SCHEDULER->addTimeEvent(
                        new TerrainStepsEvent(
                            id,
                            newGen,
                            ShGlobals::TIME_STREAM_TIMER->getTime()
                        )
            );
        }
    }
}

void ShIslandGrid::flockingSteps(int id, unsigned char seed, bool addTimeEvent)
{
    boost::upgrade_lock<boost::shared_mutex> lock(mutex);
    boost::upgrade_to_unique_lock<boost::shared_mutex> writeLock(lock);

    algo_pair currentGen = islands[id]->getStepGen();
    algo_pair newGen = make_pair(ShNetwork::Flocking, seed);
    bool update = (newGen.first != currentGen.first) || (newGen.second != currentGen.second);

    if(update)
    {
        srand(seed);
        alife::Boid::neighborDist = shmath::randomRange(1, 2);
        alife::Boid::desiredSeparation = alife::Boid::neighborDist * 2;

        alife::Flock flock(
                    geometry::Vec3i(0, 0, 0),
                    geometry::Vec3i(
                        ShIsland::kTriangleGridWidth,
                        ShIsland::kTriangleGridHeight,
                        ShIsland::kTriangleGridWidth
                    ),
                    true,
                    false);

        geometry::Vec3d location(
                    shmath::randomRange(0, ShIsland::kTriangleGridWidth),
                    shmath::randomRange(0, ShIsland::kTriangleGridHeight),
                    0);

        for(int i = 0; i < 3; ++i)
        {
            flock.addBoid(location + geometry::Vec3d(i, 0, i),
                          geometry::Vec3d(0, 0, 0),
                          geometry::Vec3d(
                              shmath::randomRange(-400, 400) / 100.0,
                              shmath::randomRange(-5, 5) / 100.0,
                              shmath::randomRange(-400, 400) / 100.0
                          ),
                          8.0,
                          0.1
            );
        }

        islands[id]->clearValues();
        int numRuns = 300;

        for(int i = 0; i < numRuns; ++i)
        {
            flock.run();

            const std::vector<alife::Boid*> boids = flock.getBoids();
            for(int j = 0; j < boids.size(); ++j)
            {
                geometry::Vec3d location = boids[j]->getLocation();

                if(location.x >= 0 && location.x < ShIsland::kTriangleGridWidth
                        && location.y >= 0 && location.y < ShIsland::kTriangleGridHeight)
                {
                    islands[id]->setValue(location.x, location.y, 1);
                }


                if(location.x >= 0 && location.x < ShIsland::kTriangleGridWidth
                        && location.y + 1 >= 0 && location.y + 1 < ShIsland::kTriangleGridHeight)
                {
                    islands[id]->setValue(round(location.x), round(location.y + 1), 1);
                }

                if(location.x + 1 >= 0 && location.x + 1 < ShIsland::kTriangleGridWidth
                        && location.y >= 0 && location.y < ShIsland::kTriangleGridHeight)
                {
                    islands[id]->setValue(round(location.x + 1), round(location.y), 1);
                }
            }
        }

        islands[id]->setScheduleBufferColors(true);
        islands[id]->setStepGen(newGen);

        if(addTimeEvent)
        {
            ShGlobals::TIME_STREAM_SCHEDULER->addTimeEvent(
                        new TerrainStepsEvent(
                            id,
                            newGen,
                            ShGlobals::TIME_STREAM_TIMER->getTime()
                        )
            );
        }
    }
}

void ShIslandGrid::gameOfLife(int id)
{
    boost::upgrade_lock<boost::shared_mutex> lock(mutex);
    boost::upgrade_to_unique_lock<boost::shared_mutex> writeLock(lock);

    std::vector< std::vector<unsigned int> > grid;

    // Fill the grid
    for(int x = 0; x < ShIsland::kTriangleGridWidth; ++x)
    {
        grid.push_back(std::vector<unsigned int>());

        for(int y = 0; y < ShIsland::kTriangleGridHeight; ++y)
        {
            unsigned int value = std::min<int>(islands[id]->getValue(x, y), 1);
            grid[x].push_back(value);
        }
    }

    // Operate on the grid
    GameOfLife::updateExternalGrid(&grid);

    // Update the island
    for(int x = 0; x < ShIsland::kTriangleGridWidth; ++x)
    {
        for(int y = 0; y < ShIsland::kTriangleGridHeight; ++y)
        {
            islands[id]->setValue(x, y, grid[x][y]); // Set the triangle grid activity
        }
    }

    islands[id]->setScheduleBufferColors(true); // Update the colors of the island
}

void ShIslandGrid::emptyHeights(int id, bool addTimeEvent)
{
    boost::shared_lock<boost::shared_mutex> lock(mutex);

    algo_pair currentGen = islands[id]->getTerrainGen();
    algo_pair newGen = make_pair(ShNetwork::Empty, 0);
    bool update = (newGen.first != currentGen.first) || (newGen.second != currentGen.second);

    if(update)
    {
        std::vector< std::vector<float> > heightMap;
        float minHeight = 0;
        float maxHeight = 0;

        for(int x = 0; x < ShIsland::kGridWidth + 1; ++x)
        {
            heightMap.push_back(std::vector<float>());
            for(int y = 0; y < ShIsland::kGridDepth + 1; ++y)
            {
                heightMap[x].push_back(0);
            }
        }

        //islands[id]->setTerrainHeightMap(heightMap, minHeight, maxHeight);
        createIslandAnimation(id, heightMap, minHeight, maxHeight);
        islands[id]->setTerrainGen(newGen);

        if(addTimeEvent)
        {
            ShGlobals::TIME_STREAM_SCHEDULER->addTimeEvent(
                        new TerrainHeightsEvent(
                            id,
                            newGen,
                            ShGlobals::TIME_STREAM_TIMER->getTime()
                        )
            );
        }
    }
}

void ShIslandGrid::diamondSquareHeights(int id, unsigned char seed, bool addTimeEvent)
{
    boost::upgrade_lock<boost::shared_mutex> lock(mutex);
    boost::upgrade_to_unique_lock<boost::shared_mutex> writeLock(lock);

    algo_pair currentGen = islands[id]->getTerrainGen();
    algo_pair newGen = make_pair(ShNetwork::DiamondSquare, seed);
    bool update = (newGen.first != currentGen.first) || (newGen.second != currentGen.second);

    if(update)
    {
        srand(seed);
        ShDiamondSquare terrain(seed, ShIsland::kGridWidth + 1, ShIsland::kGridDepth + 1, 0, 99);
        std::vector< std::vector<float> > heightMap;
        float minHeight = 0;
        float maxHeight = 1;

        for(int x = 0; x < ShIsland::kGridWidth + 1; ++x)
        {
            heightMap.push_back(std::vector<float>());
            for(int y = 0; y < ShIsland::kGridDepth + 1; ++y)
            {
                float value = terrain.getValue(x, y) / 25 * ShIsland::kGridSize;

                if(value < minHeight)
                    minHeight = value;

                if(value > maxHeight)
                    maxHeight = value;

                heightMap[x].push_back(value);
            }
        }

        //islands[id]->setTerrainHeightMap(heightMap, minHeight, maxHeight);
        createIslandAnimation(id, heightMap, minHeight, maxHeight);
        islands[id]->setTerrainGen(newGen);

        if(addTimeEvent)
        {
            ShGlobals::TIME_STREAM_SCHEDULER->addTimeEvent(
                        new TerrainHeightsEvent(
                            id,
                            newGen,
                            ShGlobals::TIME_STREAM_TIMER->getTime()
                        )
            );
        }
    }
}

void ShIslandGrid::wolframHeights(int id, unsigned char seed, bool addTimeEvent)
{
    boost::upgrade_lock<boost::shared_mutex> lock(mutex);
    boost::upgrade_to_unique_lock<boost::shared_mutex> writeLock(lock);

    algo_pair currentGen = islands[id]->getTerrainGen();
    algo_pair newGen = make_pair(ShNetwork::Wolfram, seed);
    bool update = (newGen.first != currentGen.first) || (newGen.second != currentGen.second);

    if(update)
    {
        // Seed our randomness
        srand(seed);

        Automata automata;
        WolframCA* ca;

        switch(randomRange(0, 2)) // Initialize the CA to random settings
        {
        case 0:
            ca = new WolframCA(randomRange(0, 255), 2, 1, ShIsland::kTriangleGridWidth + 1);
            break;

        case 1:
            ca = new WolframCA(randomRange(0, 1457), 3, randomRange(1, 2), ShIsland::kGridWidth + 1);
            break;

        case 2:
            // Shouldn't be 10790979 but some actually correct number
            ca = new WolframCA(randomRange(0, 10790979), 4, randomRange(1, 3), ShIsland::kGridWidth + 1);
            break;
        }

        for(int i = 0; i < ShIsland::kTriangleGridHeight + 1; ++i)
        {
            automata.history.push_front(ca->getCurrentState());

            if(i < ShIsland::kTriangleGridHeight - 1)
                ca->advance();
        }

        std::vector< std::vector<float> > heightMap;
        float minHeight = 0;
        float maxHeight = 0;

        for(int x = 0; x < ShIsland::kGridWidth + 1; ++x)
        {
            heightMap.push_back(std::vector<float>());
            for(int y = 0; y < ShIsland::kGridDepth + 1; ++y)
            {
                float value = automata.history[y][x] * ShIsland::kGridWidth;

                if(value < minHeight)
                    minHeight = value;

                if(value > maxHeight)
                    maxHeight = value;


                heightMap[x].push_back(value);
            }
        }

        //islands[id]->setTerrainHeightMap(heightMap, minHeight, maxHeight);
        createIslandAnimation(id, heightMap, minHeight, maxHeight);
        islands[id]->setTerrainGen(newGen);
        delete ca;

        if(addTimeEvent)
        {
            ShGlobals::TIME_STREAM_SCHEDULER->addTimeEvent(
                        new TerrainHeightsEvent(
                            id,
                            newGen,
                            ShGlobals::TIME_STREAM_TIMER->getTime()
                        )
            );
        }
    }
}

void ShIslandGrid::strangeHeights(int id, unsigned char seed, bool addTimeEvent)
{
    boost::upgrade_lock<boost::shared_mutex> lock(mutex);
    boost::upgrade_to_unique_lock<boost::shared_mutex> writeLock(lock);

    srand(seed);

    algo_pair currentGen = islands[id]->getTerrainGen();
    algo_pair newGen = make_pair(ShNetwork::StrangeAttractor, seed);
    bool update = (newGen.first != currentGen.first) || (newGen.second != currentGen.second);

    if(update)
    {
        Pickover3D strange(false, 10,
                   ShIsland::kGridWidth / 2,
                   ShIsland::kGridDepth / 2,
                   shmath::randomRange(-ShIsland::kGridDepth, ShIsland::kGridDepth),
                   shmath::randomRange(-2000, 2000) / 1000.0,
                   shmath::randomRange(-2000, 2000) / 1000.0,
                   shmath::randomRange(-2000, 2000) / 1000.0);

        std::vector< std::vector<float> > heightMap;
        float minHeight = 0;
        float maxHeight = 0;

        for(int x = 0; x < ShIsland::kGridWidth; ++x)
        {
            heightMap.push_back(std::vector<float>());
            for(int y = 0; y < ShIsland::kGridDepth; ++y)
            {
                heightMap[x].push_back(0);
            }
        }

        double scale = ShIsland::kGridWidth;
        double offset = ShIsland::kGridWidth / (randomRange(0, 100) / 100.0);

        int modX = randomRange(1, 20);
        int modY = randomRange(1, 20);

        for(int i = 0; i < 100; ++i)
        {
            geometry::Vec3d value = strange.update();

            // scale and offset
            value = (value * scale);
            //value.z /= 1.0;
            //value.z -= randomRange(0, 1000) / 100.0;

            for(int x = -72; x < 72; ++x)
            {
                for(int y = -72; y < 72; ++y)
                {
                    if((int) value.x + x < ShIsland::kGridWidth && (int) value.x + x >= 0 &&
                       (int) value.y + y < ShIsland::kGridDepth && (int) value.y + y >= 0)
                    {
                        //if(abs(x) % modX == 0 || abs(y) % modY == 0)
                        //{
                            float valueMod = (((int) value.z) / ((abs(x) + abs(y)) / 144.0 + 1.0)) / 2;
                            heightMap[(int) value.x + x][(int) value.y + y] += valueMod;

                            if(heightMap[(int) value.x + x][(int) value.y + y] < minHeight)
                                minHeight = heightMap[(int) value.x + x][(int) value.y + y];

                            if(heightMap[(int) value.x + x][(int) value.y + y] > maxHeight)
                                maxHeight = heightMap[(int) value.x + x][(int) value.y + y];
                        //}
                    }
                }
            }
        }

        //islands[id]->setTerrainHeightMap(heightMap, minHeight, maxHeight);
        createIslandAnimation(id, heightMap, minHeight, maxHeight);
        islands[id]->setTerrainGen(newGen);

        if(addTimeEvent)
        {
            ShGlobals::TIME_STREAM_SCHEDULER->addTimeEvent(
                        new TerrainHeightsEvent(
                            id,
                            newGen,
                            ShGlobals::TIME_STREAM_TIMER->getTime()
                        )
            );
        }
    }
}

void ShIslandGrid::lSystemHeights(int id, unsigned char seed, bool addTimeEvent)
{
    boost::upgrade_lock<boost::shared_mutex> lock(mutex);
    boost::upgrade_to_unique_lock<boost::shared_mutex> writeLock(lock);

    algo_pair currentGen = islands[id]->getTerrainGen();
    algo_pair newGen = make_pair(ShNetwork::LSystem, seed);
    bool update = (newGen.first != currentGen.first) || (newGen.second != currentGen.second);

    if(update)
    {
        srand(seed);
        std::vector< std::vector<float> > heightMap;
        float minHeight = 0;
        float maxHeight = 0;

        for(int x = 0; x < ShIsland::kGridWidth; ++x)
        {
            heightMap.push_back(std::vector<float>());
            for(int y = 0; y < ShIsland::kGridDepth; ++y)
            {
                heightMap[x].push_back(0);
            }
        }

        rule_set ruleSet;

        std::string currentRule("FF+[+F-F-F]-[-F+F+F]");
        ruleSet.push_back(Rule(fractal::alphabet[randomRange(0, 5)], currentRule));
        currentRule.clear();

        for(int i = 0; i < randomRange(0, 5); ++i)
        {
            for(int j = 0; j < randomRange(5, 10); ++j)
            {
                currentRule.append(1, fractal::alphabet[randomRange(0, 5)]);
            }

            ruleSet.push_back(Rule(fractal::alphabet[randomRange(0, 5)], currentRule));
            currentRule.clear();
        }

        currentRule.append(&fractal::alphabet[randomRange(0, 5)]);

        for(int j = 0; j < randomRange(3, 7); ++j)
        {
            currentRule.append(1, fractal::alphabet[randomRange(0, 5)]);
        }

        fractal::LSystem lSystem(currentRule, ruleSet);

        std::string sentence;
        int sentenceLength;
        //std::cout << "L-System string length: " << sentenceLength << std::endl;

        geometry::Vec3i coord(randomRange(0, (int) ShIsland::kGridWidth),
                             randomRange(0, (int) ShIsland::kGridDepth),
                             randomRange(0, (int) ShIsland::kGridDepth));

        geometry::Vec3i direction(1, 0, 1);

        std::vector< std::pair<geometry::Vec3i, geometry::Vec3i> > stack;
        stack.push_back(std::make_pair(coord, direction));

        int length;

        for(int i = 4; i >= 0; --i)
        {
            lSystem.generate();
            sentence = lSystem.getSentence();
            sentenceLength = sentence.length();
            length = pow(2.0, i + 1) / 2;

            for(int j = 0; j < sentenceLength; ++j)
            {
                char c = sentence.at(j);

                switch(c)
                {
                case 'F':

                    for(int k = 0; k < length; ++k) // draw a line as along as our length
                    {
                        coord = coord + direction;

                        if(coord.x >= ShIsland::kGridWidth)
                            coord.x = 0;

                        else if(coord.x < 0)
                            coord.x = ShIsland::kGridWidth -1;

                        if(coord.y >= ShIsland::kGridDepth)
                            coord.y = 0;

                        else if(coord.y < 0)
                            coord.y = ShIsland::kGridDepth -1;

                        if(coord.x < ShIsland::kGridWidth && coord.x >= 0
                                && coord.y < ShIsland::kGridDepth && coord.y >= 0)
                        {
                            heightMap[coord.x][coord.y] = coord.z;
                        }
                    }

                    break;

                case 'G':

                    for(int k = 0; k < length; ++k) // draw a line as along as our length
                    {
                        coord += direction;

                        if(coord.x >= ShIsland::kGridWidth)
                            coord.x = 0;

                        else if(coord.x < 0)
                            coord.x = ShIsland::kGridWidth -1;

                        if(coord.y >= ShIsland::kGridDepth)
                            coord.y = 0;

                        else if(coord.y < 0)
                            coord.y = ShIsland::kGridDepth -1;

                        if(coord.x < ShIsland::kGridWidth && coord.x >= 0
                                && coord.y < ShIsland::kGridDepth && coord.y >= 0)
                        {
                            heightMap[coord.x][coord.y] = coord.z;
                        }
                    }

                    break;

                case '+':

                    // Rotate clockwise
                    if(direction == geometry::Vec3i(0, 1, 0))
                        direction = geometry::Vec3i(1, 0, 1);

                    else if(direction == geometry::Vec3i(1, 0, 1))
                            direction = geometry::Vec3i(0, -1, 0);

                    else if(direction == geometry::Vec3i(0, -1, 0))
                            direction = geometry::Vec3i(-1, 0, -1);

                    else if(direction == geometry::Vec3i(-1, 0, -1))
                            direction = geometry::Vec3i(0, 1, 0);

                    break;

                case '-':

                    // Rotate counter clockwise
                    if(direction == geometry::Vec3i(0, 1, 0))
                        direction = geometry::Vec3i(-1, 0, -1);

                    else if(direction == geometry::Vec3i(-1, 0, -1))
                            direction = geometry::Vec3i(0, -1, 0);

                    else if(direction == geometry::Vec3i(0, -1, 0))
                            direction = geometry::Vec3i(1, 0, 1);

                    else if(direction == geometry::Vec3i(1, 0, 1))
                            direction = geometry::Vec3i(0, 1, 0);

                    break;

                case '[': // Push Matrix
                    stack.push_back(std::make_pair(coord, direction));
                    break;

                case ']': // Pop Matrix

                    if(stack.size() > 0)
                    {
                        coord = stack.back().first;
                        direction = stack.back().second;
                        stack.pop_back();
                    }

                    break;

                default:
                    std::cout << "Default Char: " << c << std::endl;
                }
            }
        }

        for(int x = 0; x < ShIsland::kGridWidth; ++x)
        {
            for(int y = 0; y < ShIsland::kGridDepth; ++y)
            {
                if(heightMap[x][y] < minHeight)
                    minHeight = heightMap[x][y];

                if(heightMap[x][y] > maxHeight)
                    maxHeight = heightMap[x][y];
            }
        }

        //islands[id]->setTerrainHeightMap(heightMap, minHeight, maxHeight);
        createIslandAnimation(id, heightMap, minHeight, maxHeight);
        islands[id]->setTerrainGen(newGen);

        if(addTimeEvent)
        {
            ShGlobals::TIME_STREAM_SCHEDULER->addTimeEvent(
                        new TerrainHeightsEvent(
                            id,
                            newGen,
                            ShGlobals::TIME_STREAM_TIMER->getTime()
                        )
            );
        }
    }
}

void ShIslandGrid::flockingHeights(int id, unsigned char seed, bool addTimeEvent)
{
    boost::upgrade_lock<boost::shared_mutex> lock(mutex);
    boost::upgrade_to_unique_lock<boost::shared_mutex> writeLock(lock);

    algo_pair currentGen = islands[id]->getTerrainGen();
    algo_pair newGen = make_pair(ShNetwork::Flocking, seed);
    bool update = (newGen.first != currentGen.first) || (newGen.second != currentGen.second);

    if(update)
    {
        std::vector< std::vector<float> > heightMap;
        float minHeight = 0;
        float maxHeight = 0;

        for(int x = 0; x < ShIsland::kGridWidth + 1; ++x)
        {
            heightMap.push_back(std::vector<float>());
            for(int y = 0; y < ShIsland::kGridDepth + 1; ++y)
            {
                heightMap[x].push_back(0);
            }
        }

        srand(seed);

        alife::Flock flock(
                    geometry::Vec3i(0, 0, -ShIsland::kGridWidth * 9999),
                    geometry::Vec3i(ShIsland::kGridWidth, ShIsland::kGridDepth, ShIsland::kGridWidth * 9999),
                    false,
                    false);

        alife::Boid::neighborDist = shmath::randomRange(1, 50);
        alife::Boid::desiredSeparation = alife::Boid::neighborDist * 2;

        for(int i = 0; i < 3; ++i)
        {
            flock.addBoid(geometry::Vec3d(
                              shmath::randomRange(0, ShIsland::kGridWidth),
                              shmath::randomRange(0, ShIsland::kGridDepth),
                              shmath::randomRange(-3000, 3000) / 10.0
                          ),
                          geometry::Vec3d(0, 0, 0),
                          geometry::Vec3d(
                              shmath::randomRange(-100, 100) / 100.0,
                              shmath::randomRange(-100, 100) / 100.0,
                              shmath::randomRange(-100, 100) / 100.0
                          ),
                          1,
                          0.05
            );
        }

        int numRuns = 200;

        for(int i = 0; i < numRuns; ++i)
        {
            flock.run();
            flock.seek(geometry::Vec3d(ShIsland::kGridWidth / 2, ShIsland::kGridDepth / 2, 0));

            const std::vector<alife::Boid*> boids = flock.getBoids();
            for(int j = 0; j < boids.size(); ++j)
            {
                geometry::Vec3d location = boids[j]->getLocation();

                for(int x = -i / 3; x < i / 3; ++x)
                {
                    for(int y = -i / 3; y < i / 3; ++y)
                    {
                        if((int) location.x + x < ShIsland::kGridWidth && (int) location.x + x >= 0 &&
                           (int) location.y + y < ShIsland::kGridDepth && (int) location.y + y >= 0)
                        {
                            if(heightMap[(int) location.x + x][(int) location.y + y] == 0)
                            {
                                float value = location.z / ((abs(x) + abs(y)) / 3.0 + 1.0);

                                heightMap[(int) location.x + x][(int) location.y + y] = value;

                                if(heightMap[(int) location.x + x][(int) location.y + y] < minHeight)
                                    minHeight = heightMap[(int) location.x + x][(int) location.y + y];

                                if(heightMap[(int) location.x + x][(int) location.y + y] > maxHeight)
                                    maxHeight = heightMap[(int) location.x + x][(int) location.y + y];
                            }
                        }
                    }
                }
            }
        }

        //islands[id]->setTerrainHeightMap(heightMap, minHeight, maxHeight);
        createIslandAnimation(id, heightMap, minHeight, maxHeight);
        islands[id]->setTerrainGen(newGen);

        if(addTimeEvent)
        {
            ShGlobals::TIME_STREAM_SCHEDULER->addTimeEvent(
                        new TerrainHeightsEvent(
                            id,
                            newGen,
                            ShGlobals::TIME_STREAM_TIMER->getTime()
                        )
            );
        }
    }
}

void ShIslandGrid::setTerrainHeightMap(int id, height_map_t &heightMap, float minHeight, float maxHeight)
{
    boost::upgrade_lock<boost::shared_mutex> lock(mutex);
    boost::upgrade_to_unique_lock<boost::shared_mutex> writeLock(lock);

    islands[id]->setTerrainHeightMap(heightMap, minHeight, maxHeight);
}

void ShIslandGrid::setAnimation(int id, std::deque<animation_frame_t>& animation)
{
    boost::upgrade_lock<boost::shared_mutex> lock(mutex);
    boost::upgrade_to_unique_lock<boost::shared_mutex> writeLock(lock);

    islands[id]->setAnimation(animation);
}

void ShIslandGrid::removeAnimationTimer(std::string name)
{
    boost::upgrade_lock<boost::shared_mutex> lock(mutex);
    boost::upgrade_to_unique_lock<boost::shared_mutex> writeLock(lock);

    delete animationTimers[name];
    animationTimers.erase(name);
}

void ShIslandGrid::addAnimationTimer(std::string name, AnimationTimer* timer)
{
    animationTimers[name] = timer;
}

void ShIslandGrid::createIslandAnimation(int id, height_map_t& newTerrain, float minHeight, float maxHeight)
{
    AnimationScheduler* scheduler = new AnimationScheduler(
                                        id,
                                        islands[id]->getTerrainHeightMap(),
                                        newTerrain,
                                        minHeight,
                                        maxHeight
    );

    AnimationTimer* timer = new AnimationTimer(scheduler);
    addAnimationTimer(timer->getName(), timer); // Add ourselves to the island grid map
    timer->start();
}

void ShIslandGrid::createIslands()
{
    boost::upgrade_lock<boost::shared_mutex> lock(mutex);
    boost::upgrade_to_unique_lock<boost::shared_mutex> writeLock(lock);

	islands = new ShIsland*[NUM_ISLANDS];
	
	for(int i = 0; i < NUM_ISLANDS; ++i)
	{
		cinder::Vec2i coord = idToCoord(i);
		
		cinder::Vec3f pos(coord.x * ShIsland::kGridSize * ShIsland::kGridWidth, 
						  0, 
						  coord.y * ShIsland::kGridSize * ShIsland::kGridDepth);
		
		ShIsland* island = new ShIsland(pos, i, coord);
		islands[i] = island;
		std::cout << "Island: " << i << " created." << std::endl;
	}
}

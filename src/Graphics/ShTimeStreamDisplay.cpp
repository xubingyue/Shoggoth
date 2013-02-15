// System includes
#include <sstream>
#include <cmath>

// Cinder includes
#include "cinder/gl/gl.h"

// Local includes
#include "ShTimeStreamDisplay.h"
#include "src/Time/shtimestream.h"
#include "src/ShGlobals.h"
#include "src/Resources.h"

ShTimeStreamDisplay::ShTimeStreamDisplay()
{
    mostFutureTime = boost::chrono::steady_clock::time_point(boost::chrono::seconds(0));
    width = (ShGlobals::SCREEN_SIZE.x / 2) - 10;
    height = (ShGlobals::SCREEN_SIZE.y / 2.0) * (2.0 / 3.0);
    this->bounds = cinder::Rectf(ShGlobals::SCREEN_SIZE.x - width - 5, ShGlobals::SCREEN_SIZE.y - 5 - height,
                           ShGlobals::SCREEN_SIZE.x - 5, ShGlobals::SCREEN_SIZE.y - 5);

#ifdef __APPLE__
    mFont = cinder::Font(cinder::app::loadResource(TEXT_TEXTURE), 12);
#else
    //mFont = cinder::Font(cinder::app::loadResource("./resources/OCRAEXT.ttf", 134, "TTF"), 12);
    mFont = cinder::Font("Ubuntu", 12);
#endif
}

void ShTimeStreamDisplay::draw()
{
    cinder::gl::color(cinder::ColorA(0.6, 0.6, 0.6, 0.6));
    cinder::gl::drawSolidRect(cinder::Rectf(bounds.x1, bounds.y2 - 15, bounds.x2, bounds.y2));
    //cinder::gl::color(cinder::ColorA(0, 0, 0, 1));
    //cinder::gl::drawStrokedRect(cinder::Rectf(bounds.x1, bounds.y2 - 15, bounds.x2, bounds.y2));
    cinder::gl::color(cinder::ColorA(0.7, 0, 0, 1));

    numBranches = 0;

    mostFutureTime = ShTimeStream::globalMostFutureTime;
    long seconds = mostFutureTime.time_since_epoch().count() / 1000000000;
    int minutes = seconds / 60;
    seconds = seconds % 60;
    drawBranches();
    //recursiveDrawBranch(ShTimeStream::root); //COMMENTED OUT FOR NOW!

    std::stringstream ss;
    ss << "Most Future Time: " << (minutes / 10) << (minutes % 10) << ":" << (seconds / 10) << (seconds %10);

    currentTime = ShGlobals::TIME_STREAM_SCHEDULER->getCurrentTimeStream()->getCurrentTime();
    seconds = currentTime.time_since_epoch().count() / 1000000000;
    minutes = seconds / 60;
    seconds = seconds % 60;

    std::stringstream ss2;
    ss2 << "Current Time: " << (minutes / 10) << (minutes % 10) << ":" << (seconds / 10) << (seconds %10);

    cinder::gl::drawString(ss.str(), cinder::Vec2f(bounds.x2 - 170, bounds.y2 - 12), cinder::ColorA::black(), mFont);
    cinder::gl::drawString(ss2.str(), cinder::Vec2f(bounds.x2 - 320, bounds.y2 - 12), cinder::ColorA::black(), mFont);

    std::string currentStreamName("Current Time Stream: ");
    currentStreamName.append(ShGlobals::TIME_STREAM_SCHEDULER->getCurrentTimeStream()->getID());

    cinder::gl::drawString(currentStreamName, cinder::Vec2f(bounds.x1 + 5, bounds.y2 - 12), cinder::ColorA::black(), mFont);
}

void ShTimeStreamDisplay::recursiveDrawBranch(ShTimeStream* stream)
{
    try
    {
        int lineOrigin, lineWidth, lineHeight;
        //lineOrigin = bounds.x1 + (
        //        (stream->getCreationTime().time_since_epoch().count()
        //         / (double) mostFutureTime.time_since_epoch().count()) * width);

        //lineWidth = (stream->getCurrentTime().time_since_epoch().count() / (double) mostFutureTime.time_since_epoch().count())
        // * width;

        lineOrigin = bounds.x1;
        lineWidth = width;

        lineHeight = bounds.y2 - 35 - (numBranches * 10);

        cinder::gl::drawLine(cinder::Vec3f(lineOrigin, lineHeight, 0), cinder::Vec3f(lineOrigin + lineWidth, lineHeight, 0));
        ++numBranches;

        //std::list<ShTimeStream*>& timeStreams = stream->getTimeBranches();

        if(stream->numTimeBranches() > 0)
        {
            std::cout << "Time Stream Drawing: " << stream->getID() << std::endl;
            // We're going to iterate backwards to prevent collisions in the graphics
            std::list<ShTimeStream*>::iterator iter = stream->getTimeBranchesEndIterator();
            std::list<ShTimeStream*>::iterator beginIter = stream->getTimeBranchesBeginIterator();
            --iter;

            do
            {
                recursiveDrawBranch(*iter);
                --iter;
            } while(iter != beginIter);
        }
    }

    catch(...)
    {
        std::cout << "Error drawing time branch" << std::endl;
    }
}

void ShTimeStreamDisplay::drawBranches()
{
    try
    {
        std::map<std::string, ShTimeStream*>& streamMap = ShGlobals::getTimeStreamMap();
        std::map<std::string, ShTimeStream*>::iterator streamIter = streamMap.begin();

        std::string currentStreamID = ShGlobals::TIME_STREAM_SCHEDULER->getCurrentTimeStream()->getID();

        while(streamIter != streamMap.end())
        {
            int lineOrigin, lineWidth, lineHeight;

            lineOrigin = bounds.x1 + (
                    (
                            streamIter->second->getCreationTime().time_since_epoch().count()
                                / (double) mostFutureTime.time_since_epoch().count()
                    ) * width
            );

            lineWidth = (
                        streamIter->second->getMostFutureTime().time_since_epoch().count()
                            / (double) mostFutureTime.time_since_epoch().count()
            ) * width;

            lineHeight = bounds.y2 - 35 - (numBranches * 10);

            cinder::gl::drawLine(cinder::Vec3f(lineOrigin, lineHeight, 0), cinder::Vec3f(lineOrigin + lineWidth, lineHeight, 0));

            cinder::gl::drawString(
                        streamIter->first,
                        cinder::Vec2f(lineOrigin - 1 - streamIter->first.size() * 7.5, lineHeight - 4),
                        cinder::Color::black(),
                        mFont
            );


            if(currentStreamID.compare(streamIter->first) == 0)
            {
                int currentLocation = bounds.x1 + (
                            currentTime.time_since_epoch().count()
                                / (double) mostFutureTime.time_since_epoch().count()
                ) * width;

                cinder::gl::color(cinder::Color::black());
                cinder::gl::drawSolidRect(cinder::Rectf(currentLocation - 2, lineHeight - 2, currentLocation + 2, lineHeight + 2));
                cinder::gl::color(cinder::ColorA(0.7, 0, 0, 1));
            }

            ++numBranches;

            ++streamIter;
        }

        //std::list<ShTimeStream*>& timeStreams = stream->getTimeBranches();

        /*
        if(stream->numTimeBranches() > 0)
        {
            std::cout << "Time Stream Drawing: " << stream->getID() << std::endl;
            // We're going to iterate backwards to prevent collisions in the graphics
            std::list<ShTimeStream*>::iterator iter = stream->getTimeBranchesEndIterator();
            std::list<ShTimeStream*>::iterator beginIter = stream->getTimeBranchesBeginIterator();
            --iter;

            do
            {
                recursiveDrawBranch(*iter);
                --iter;
            } while(iter != beginIter);
        }*/
    }

    catch(...)
    {
        std::cout << "Error drawing time branch" << std::endl;
    }
}

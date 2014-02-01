// System includes
#include <sstream>

// cinder includes
#include "cinder/gl/gl.h"

// local includes
#include "timequakedisplay.h"
#include "src/ShGlobals.h"
#include "src/Resources.h"
#include "src/Time/shtimestream.h"
#include "src/ShGlobals.h"

TimeQuakeDisplay::TimeQuakeDisplay() :
    displayText("time quake: "),
    countDownThread(0),
    running(false),
    countDownTime(30)
{
#ifdef __APPLE__
    // Font = cinder::Font(cinder::app::loadResource(TIME_QUAKE_TEXT), 75);
    mFont = cinder::Font("Menlo", 75);
#else
    // mFont = cinder::Font(cinder::app::loadResource("./resources/allusedup.ttf", 135, "TTF"), 75);
    mFont = cinder::Font("Ubuntu", 75);
#endif
}

TimeQuakeDisplay::~TimeQuakeDisplay()
{
    if(countDownThread)
    {
        stopThreading();
    }
}

void TimeQuakeDisplay::draw()
{
    boost::upgrade_lock<boost::shared_mutex> lock(mutex);
    boost::upgrade_to_unique_lock<boost::shared_mutex> writeLock(lock);

    if(countDownTime <= 30)
    {
        std::stringstream ss;
        ss << displayText << countDownTime;

        cinder::gl::drawStringCentered(
                    ss.str(),
                    (ShGlobals::SCREEN_SIZE / 2) - cinder::Vec2i(0, ShGlobals::SCREEN_SIZE.y / 2),
                    cinder::ColorA(0.7, 0, 0, 0.9),
                    mFont
        );
    }
}

void TimeQuakeDisplay::countDown()
{
    while(running)
    {
        decrementCountDownTime();
        boost::this_thread::sleep(boost::posix_time::seconds(1)); // Not perfect, but that's ok
    }

    countDownThread->join();
    delete countDownThread;
    countDownThread = 0;
}

void TimeQuakeDisplay::decrementCountDownTime()
{
    boost::upgrade_lock<boost::shared_mutex> lock(mutex);
    boost::upgrade_to_unique_lock<boost::shared_mutex> writeLock(lock);

    --countDownTime;

    if(countDownTime <= 0)
    {
        /*
        std::map<std::string, ShTimeStream*>& timeStreamMap = ShGlobals::getTimeStreamMap();
        std::map<std::string, ShTimeStream*>::iterator iter = timeStreamMap.begin();

        ShTimeStream* timeStream = timeStreamMap.begin()->second;*/

        /*
        int randCounter = rand() % timeStreamMap.size(); // Choose a random time stream


        while(randCounter >= 0)
        {
            if(randCounter == 0)
            {
                timeStream = iter->second;
                break;
            }

            --randCounter;
            ++iter;
        }*/

        boost::chrono::steady_clock::time_point newTime(boost::chrono::seconds(0));

        ShTimeStream* timeStream = ShGlobals::TIME_STREAM_SCHEDULER->getCurrentTimeStream();

        boost::chrono::seconds mostFuture = boost::chrono::duration_cast<boost::chrono::seconds>(
                    timeStream->getMostFutureTime().time_since_epoch()
        );

        newTime += boost::chrono::seconds(rand() % (mostFuture.count() / 2));

        countDownTime = 30 + (rand() % 30);

        /*
        ShGlobals::TIME_STREAM_SCHEDULER->getCurrentTimeStream()->moveCurrentTime(
                    boost::chrono::steady_clock::time_point(boost::chrono::seconds(0)),
                    true
        );*/

        ShGlobals::TIME_STREAM_TIMER->setTime(newTime);
        timeStream->moveCurrentTime(newTime, true);

        ShTimeStream* newTimeStream = ShGlobals::TIME_STREAM_SCHEDULER->getCurrentTimeStream();

        // Possibly pick a child branch
        if(rand() % 2 == 0)
        {
            std::list<ShTimeStream*> timeStreams = newTimeStream->getTimeBranches();
            if(timeStreams.size() > 0)
            {
                int random = rand() % timeStreams.size();
                std::list<ShTimeStream*>::iterator iter = timeStreams.begin();

                while(random > 0)
                {
                    ++iter;
                    --random;
                }

                ShTimeStream* randStream = *iter;
                newTime = randStream->getCreationTime();
                ShGlobals::TIME_STREAM_TIMER->setTime(newTime);
                newTimeStream->moveCurrentTime(newTime, true);
                ShGlobals::TIME_STREAM_SCHEDULER->setCurrentTimeStream(randStream);
                newTimeStream = randStream;
            }
        }

        if(timeStream != newTimeStream)
        {
            boost::chrono::seconds randTime = boost::chrono::duration_cast<boost::chrono::seconds>(
                        newTimeStream->getMostFutureTime().time_since_epoch()
            );

            randTime -= boost::chrono::duration_cast<boost::chrono::seconds>(newTime.time_since_epoch());
            newTime += boost::chrono::seconds(rand() % randTime.count());
            ShGlobals::TIME_STREAM_TIMER->setTime(newTime);
            newTimeStream->moveCurrentTime(newTime, true);
        }
    }
}

void TimeQuakeDisplay::startThreading()
{
    if(!running)
    {
        running = true;
        countDownThread = new boost::thread(boost::bind(&TimeQuakeDisplay::countDown, this));
    }
}

void TimeQuakeDisplay::stopThreading()
{
    if(running)
    {
        running = false;
        countDownTime = 0;
    }
}

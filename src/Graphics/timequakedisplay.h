#ifndef TIMEQUAKEDISPLAY_H
#define TIMEQUAKEDISPLAY_H

// system includes
#include <string>

// Boost includes
#include "boost/thread.hpp"
#include "boost/thread/shared_mutex.hpp"

// local includes
#include "cinder/Font.h"

class TimeQuakeDisplay
{
public:
    TimeQuakeDisplay();
    ~TimeQuakeDisplay();

    void draw();
    void countDown();
    void decrementCountDownTime();
    void startThreading();
    void stopThreading();

private:

    int countDownTime;
    std::string displayText;
    cinder::Font mFont;
    boost::thread* countDownThread;
    boost::shared_mutex mutex;
    bool running;
};

#endif // TIMEQUAKEDISPLAY_H

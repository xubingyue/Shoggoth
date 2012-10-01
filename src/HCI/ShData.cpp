#include <iostream>
#include <stdlib.h>

#include "boost/date_time/posix_time/posix_time.hpp"
#include "boost/date_time/microsec_time_clock.hpp"

#include "ShData.h"
#include "src/ShGlobals.h"

#include "libraries/jsoncpp/include/json/json.h"

using namespace std;
using namespace boost::posix_time;
using namespace Json;

ShData::ShData()
{
    boost::shared_lock<boost::shared_mutex> lock(mMutex);
    writing = true;
    ShGlobals::DATA = this;
    mRoot["Shoggoth"]["Application Usage"]["Open Time"] = timeStamp();
}

ShData::~ShData()
{
    boost::shared_lock<boost::shared_mutex> lock(mMutex);
    createDocument();
}

void ShData::initializeEntry()
{
    boost::shared_lock<boost::shared_mutex> lock(mMutex);
}

void ShData::finalizeEntry()
{
    boost::shared_lock<boost::shared_mutex> lock(mMutex);
}

void ShData::queueChatStore(std::string message)
{
    boost::shared_lock<boost::shared_mutex> lock(mMutex);

    //mChatQueue.push_back(make_pair(message, timeStamp()));
    mRoot["Shoggoth"]["Chat"][timeStamp()] = message;
}

void ShData::queueKeyStore(cinder::app::KeyEvent key, KeyState state)
{
    boost::shared_lock<boost::shared_mutex> lock(mMutex);

    //KeyData keyData = {key, state};
    //pair<KeyData, string> data = make_pair(keyData, timeStamp());
    //mKeyQueue.push_back(data);

    std::string time = timeStamp();

    mRoot["Shoggoth"]["Keyboard"][time]["Key"] = key.getNativeKeyCode();

    if(state == Pressed)
        mRoot["Shoggoth"]["Keyboard"][time]["State"] = "Pressed";
    else
        mRoot["Shoggoth"]["Keyboard"][time]["State"] = "Released";
}

void ShData::queueMouseMoveStore(cinder::Vec2i mouse)
{
    boost::shared_lock<boost::shared_mutex> lock(mMutex);

    //mMouseQueue.push_back(make_pair(mouse, timeStamp()));

    std::string time = timeStamp();
    mRoot["Shoggoth"]["Mouse"]["Move"][time]["X"] = mouse.x;
    mRoot["Shoggoth"]["Mouse"]["Move"][time]["Y"] = mouse.y;
}

void ShData::queueMouseButtonStore(MouseButton button, MouseState state)
{
    boost::shared_lock<boost::shared_mutex> lock(mMutex);

    std::string buttonString;
    std::string stateString;

    if(button == Left)
        buttonString = "Left";
    else
        buttonString = "Right";

    if(state == Down)
        stateString = "Down";
    else
        stateString = "Up";

    mRoot["Shoggoth"]["Mouse"]["Button"][buttonString][timeStamp()] = stateString;
}

void ShData::queueUserLogin(std::string userName)
{
    boost::shared_lock<boost::shared_mutex> lock(mMutex);
    mRoot["Shoggoth"]["Users"][userName]["Login"] = timeStamp();
}

void ShData::queueUserLogout(std::string userName)
{
    boost::shared_lock<boost::shared_mutex> lock(mMutex);
    mRoot["Shoggoth"]["Users"][userName]["Logout"] = timeStamp();
}

void ShData::queueAvatarPosition(std::string avatarName, cinder::Vec3f position, cinder::Quatf rotation)
{
    boost::shared_lock<boost::shared_mutex> lock(mMutex);

    //AvatarData data = { avatarName, position, rotation };
    //mAvatarQueue.push_back(make_pair(data, timeStamp()));
    std::string time = timeStamp();
    mRoot["Shoggoth"]["Avatar"][avatarName][time]["Position"]["X"] = position.x;
    mRoot["Shoggoth"]["Avatar"][avatarName][time]["Position"]["Y"] = position.y;
    mRoot["Shoggoth"]["Avatar"][avatarName][time]["Position"]["Z"] = position.z;
    mRoot["Shoggoth"]["Avatar"][avatarName][time]["Rotation"]["W"] = rotation.w;
    mRoot["Shoggoth"]["Avatar"][avatarName][time]["Rotation"]["X"] = rotation.v.x;
    mRoot["Shoggoth"]["Avatar"][avatarName][time]["Rotation"]["Y"] = rotation.v.y;
    mRoot["Shoggoth"]["Avatar"][avatarName][time]["Rotation"]["Z"] = rotation.v.z;
}

void ShData::queueTerrainStep(uint8_t islandID, cinder::Vec2i gridPosition, StepActivation activated)
{
    boost::shared_lock<boost::shared_mutex> lock(mMutex);

    //TerrainStepData data = {islandID, gridPosition, activated};
    //mStepQueue.push_back(make_pair(data, timeStamp()));

    std::string step;

    if(activated == Activated)
        step = "Activated";
    else
        step = "Deactivated";

    mRoot["Shoggoth"]["Terrain"][islandID]["Step"][gridPosition.x][gridPosition.y][timeStamp()] = step;
}

void ShData::queueSynthTrigger(std::string synthName, unsigned char islandID, cinder::Vec2i gridPosition)
{
    boost::shared_lock<boost::shared_mutex> lock(mMutex);

    //SynthTriggerData data = {synthName, islandID, gridPosition};
    //mSynthQueue.push_back(make_pair(data, timeStamp()));

    mRoot["Shoggoth"]["Synth"][islandID][gridPosition.x][gridPosition.y][timeStamp()] = synthName;
}

void ShData::writeQueueEntries()
{
    boost::shared_lock<boost::shared_mutex> lock(mMutex);
}

std::string ShData::timeStamp()
{
    boost::shared_lock<boost::shared_mutex> lock(mMutex);
    std::string timeStamp;
    boost::posix_time::ptime pt(boost::posix_time::microsec_clock::local_time());
    timeStamp.append(boost::gregorian::to_simple_string(pt.date()));
    timeStamp.append(":");
    timeStamp.append(boost::posix_time::to_simple_string(pt.time_of_day()));

    return timeStamp;
}

bool ShData::createDocument()
{
    boost::shared_lock<boost::shared_mutex> lock(mMutex);

    std::string time = timeStamp();
    mRoot["Shoggoth"]["Application Usage"]["Close Time"] = time;

    // Make a new JSON document for the configuration. Preserve original comments.
    std::string outputConfig = mWriter.write(mRoot);

    std::string fileName("../../../Logs/");
    fileName.append(time);

    size_t found = fileName.find(":");
    fileName.replace(fileName.begin() + found, fileName.begin() + found + 1, "-");
    found = fileName.find(":");
    fileName.replace(fileName.begin() + found, fileName.begin() + found + 1, "-");
    found = fileName.find(":");
    fileName.replace(fileName.begin() + found, fileName.begin() + found + 1, "-");

    fileName.append(".shog");

    file = fopen(fileName.c_str(), "w");

    if(file == 0)
    {
        std::cerr << "Could not create: " << fileName << std::endl;
        return false;
    }

    fputs(outputConfig.c_str(), file);
    fclose(file);
    return true;
}

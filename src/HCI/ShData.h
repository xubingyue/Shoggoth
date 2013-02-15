#ifndef SHDATA_H
#define SHDATA_H

#include <deque>
#include <string>
#include <cstdio>

#include "boost/thread.hpp"
#include "boost/thread/shared_mutex.hpp"
#include "boost/date_time.hpp"

#include "cinder/app/AppBasic.h"
#include "cinder/Vector.h"
#include "cinder/Quaternion.h"

#include "libraries/jsoncpp/include/json/json.h"
#include "libraries/jsoncpp/include/json/jsonvalue.h"
#include "libraries/jsoncpp/include/json/jsonwriter.h"
#include "libraries/jsoncpp/include/json/jsonreader.h"

// Used to store information about usage in a JSON format
class ShData
{
public:

    enum KeyState // Differentiate between press/release
    {
        Pressed,
        Released
    };

    struct KeyData // tracks key press/release data
    {
        cinder::app::KeyEvent key;
        KeyState state;
    };

    struct AvatarData // Used for tracking information about player movement
    {
        std::string name;
        cinder::Vec3f position;
        cinder::Quatf rotation;
    };

    enum StepActivation // Used for differentating step activation/deactivation
    {
        Activated,
        Deactivated
    };

    struct TerrainStepData // tracks the creation/deletion of steps on the terrain
    {
        unsigned char islandID;
        cinder::Vec2i gridPosition;
        StepActivation activated;
    };

    struct SynthTriggerData // tracks synth triggering by snakes
    {
        std::string synthName;
        TerrainStepData step;
    };

    enum MouseButton
    {
        Left,
        Right
    };

    enum MouseState
    {
        Down,
        Up
    };

    ShData();
    ~ShData();

    void initializeEntry();
    void finalizeEntry();

    void queueChatStore(std::string message);
    void queueKeyStore(cinder::app::KeyEvent key, KeyState state);
    void queueMouseMoveStore(cinder::Vec2i mouse);
    void queueMouseButtonStore(MouseButton button, MouseState state);
    void queueUserLogin(std::string userName);
    void queueUserLogout(std::string userName);
    void queueAvatarPosition(std::string avatarName, cinder::Vec3f position, cinder::Quatf rotation);
    void queueTerrainStep(uint8_t islandID, cinder::Vec2i gridPosition, StepActivation activated);
    void queueSynthTrigger(std::string synthName, unsigned char islandID, cinder::Vec2i gridPosition);

    void writeQueueEntries();

    static const long int kSleepTime = 1000000; // in useconds, 1,000,000 useconds(microseconds) = 1 second

    // Data types
    typedef std::deque< std::pair< std::string, std::string > > chat_data;
    typedef std::deque< std::pair< KeyData, std::string > > key_data;
    typedef std::deque< std::pair< cinder::Vec2f, std::string > > mouse_data;
    typedef std::deque< std::pair< AvatarData, std::string > > avatar_data;
    typedef std::deque< std::pair< TerrainStepData, std::string > > step_data;
    typedef std::deque< std::pair< SynthTriggerData, std::string > > synth_data;

    // Data iterator types
    typedef std::deque< std::pair< std::string, std::string > >::iterator chat_iter;
    typedef std::deque< std::pair< KeyData, std::string > >::iterator key_iter;
    typedef std::deque< std::pair< cinder::Vec2f, std::string > >::iterator mouse_iter;
    typedef std::deque< std::pair< AvatarData, std::string > >::iterator avatar_iter;
    typedef std::deque< std::pair< TerrainStepData, std::string > >::iterator step_iter;
    typedef std::deque< std::pair< SynthTriggerData, std::string > >::iterator synth_iter;

private:

    std::string timeStamp(); // return a formatted time stamp
    bool createDocument(); // Create document and write to file

    chat_data mChatQueue; // value/Date+Time pairs
    key_data mKeyQueue; // value/Date+Time pairs
    mouse_data mMouseQueue; // value/Date+Time pairs
    avatar_data mAvatarQueue; // value/Date+Time pairs
    step_data mStepQueue; // value/Date+Time pairs
    synth_data mSynthQueue; // value/Date+Time pairs

    boost::shared_mutex mMutex; // synchronizes access
    boost::thread* mWriteThread; // writes input information to file

    Json::Value mRoot; // Format in JSON
    Json::Reader mReader; // Read JSON
    Json::StyledWriter mWriter; // Write JSON

    FILE* file; // Actual file that is written to
    bool writing; // Writing bool for thread
};

#endif // SHDATA_H

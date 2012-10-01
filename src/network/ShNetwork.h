#ifndef SHNETWORK_H
#define SHNETWORK_H

// Standard includes
#include <vector>

// Cinder includes
#include "cinder/Vector.h"
#include "cinder/Quaternion.h"

class ShClient;
class ShPacketListener;
class ShChat;

namespace ShNetwork {

    enum Algorithm
    {
        Empty,
        DiamondSquare,
        Wolfram,
        StrangeAttractor,
        LSystem,
        Flocking,
        WaveTable,
        Graphics
    };

    enum StepModulation
    {
        Rotation,
        GameOfLife
    };

    typedef std::pair<Algorithm, unsigned char> algo_pair;

    extern const int PACKET_BUFFER_SIZE; // The buffer size for packets sent to OSCthulhu
    extern bool ONLINE; // Online status of the program
    extern ShClient* client; // Pointer to the active client, for sending
    extern ShPacketListener* listener; // Pointer to the active listener, for receiving
    extern ShChat* chat;

    ////////////////////////
    // ShClient OSC sending
    ////////////////////////

    /** login the ShClient piece (not networking in general) */
    void sendLogin();

    /** logout of the ShClient piece (not networking in general) */
    void sendLogout();

    /** move the avatar */
    void sendMoveAvatar(cinder::Vec3f pos);

    /** rotate the avatar */
    void sendRotateAvatar(cinder::Quatf rot);

    /** add random seed (which everyone will use for terrain generation. Terrain won't be generated until we get this BACK */
    void sendSetRandomSeed();

    /** start sequencing the snakes */
    void sendStartSequencing();

    /** end sequencing the snakes*/
    void sendEndSequencing();

    /** send the client a chat message */
    void sendChatMessage(const char* message);

    /** send the terrain steps to the client using bit packing */
    void sendTerrainSteps(unsigned char islandNum, Algorithm algorithm, unsigned char genArgument);

    /** receive terrain step update from the network */
    void receiveTerrainSteps(unsigned char islandNum, int arg);

    /** send the terrain heights to the client using bit packing */
    void sendTerrainHeights(unsigned char islandNum, Algorithm algorithm, unsigned char genArgument);

    /** receive terrain height map update from the network */
    void receiveTerrainHeights(unsigned char islandNum, int arg);

    const char* snakeIDtoString(std::pair<unsigned int, unsigned int> id);
    std::pair<unsigned int, unsigned int> snakeStringToID(const char* id);
    void sendAddSnakeRange(std::pair<unsigned int, unsigned int> id, std::string synthName, cinder::Vec2i corner1,
                           cinder::Vec2i corner2);

    void sendRemoveSnakeRange(std::pair<unsigned int, unsigned int> id);
    void sendSnakeRangePosition(std::pair<unsigned int, unsigned int> id, cinder::Vec2i corner);
    void sendSnakeRangeCorner(std::pair<unsigned int, unsigned int> id, cinder::Vec2i corner);

    /** set tempo */
    void sendSetTempo(int milliseconds);

    /**
    *   sendCthulhu sends takes a command, packages it as an osc packet and gives it to the client to send to OSCthulhu
    *   @param cont char* command The command as a string to be sent to the local OSCthulhu client over osc
    */
    void sendCthulhu(const char* command);

    /**
    *   sendCthulhu sends takes a command, packages it as an osc packet and gives it to the client to send to OSCthulhu
    *   @param cont char* command The command as a string to be sent to the local OSCthulhu client over osc
    *   @param cont char* value The value as an int to be sent
    */
    void sendCthulhu(const char* command, const char* value);


    /**
    *   sendCthulhu sends takes a command, packages it as an osc packet and gives it to the client to send to OSCthulhu
    *   @param float command The command as a float to be sent to the local OSCthulhu client over osc
    */
    void sendCthulhu(const char* command, float value);

    /**
    *   sendCthulhu sends takes a command, packages it as an osc packet and gives it to the client to send to OSCthulhu
    *   @param cont char* object The object name as an string to be sent
    *   @param cont char* Subtype The Subtype as a string to be sent
    *   @param int value The value as an int to be sent
    */
    void sendCthulhuAddObject(const char* object, const char* subType, int value);

    /**
    *   sendCthulhu sends takes a command, packages it as an osc packet and gives it to the client to send to OSCthulhu
    *   @param cont char* object The object name to be sent
    *   @param cont char* Subtype The Subtype as a string to be sent
    *   @param int value The value as an int to be sent
    */
    void sendCthulhuAddIntObject(const char* object, const char* subType, long value);

    /**
    *   sendCthulhu sends takes a command, packages it as an osc packet and gives it to the client to send to OSCthulhu
    *   @param const char* object The object name as an string to be sent
    *   @param const char* Subtype The Subtype as a string to be sent
    *   @param std::vector<int> arguments The arguments in a vector;
    */
    void sendCthulhuAddObject(const char* object, const char* subType, std::vector<int>& arguments);

    /**
    *   sendCthulhu sends takes a command, packages it as an osc packet and gives it to the client to send to OSCthulhu
    *   @param const char* object The object name as an string to be sent
    *   @param const char* Subtype The Subtype as a string to be sent
    *   @param std::vector<float> arguments The arguments in a vector;
    */
    void sendCthulhuAddObject(const char* object, const char* subType, std::vector<float>& arguments);

    /**
    *   sendCthulhu sends takes a command, packages it as an osc packet and gives it to the client to send to OSCthulhu
    *   @param cont char* object The object name as an string to be removed from synchronization
    */
    void sendCthulhuRemoveObject(const char* object);

    /**
    *   sendCthulhu sends takes a command, packages it as an osc packet and gives it to the client to send to OSCthulhu
    *   @param cont char* object The object name as an string to be sent
    *   @param float value The value as an int to be sent
    *   @param int bounceBack 0: The server bounces back 1: no bounce back
    */
    void sendCthulhuSetArg(const char* object, int argNum, float value, int bounceBack = 0);

    /**
    *   sendCthulhu sends takes a command, packages it as an osc packet and gives it to the client to send to OSCthulhu
    *   @param cont char* object The object name as an string to be sent
    *   @param int value The value as an int to be sent
    *   @param int bounceBack 0: The server bounces back 1: no bounce back
    */
    void sendCthulhuSetIntArg(const char* object, int argNum, int value, int bounceBack = 0);


    ///////////////////////////////////
    // ShPacketListener OSC receiving
    ///////////////////////////////////

    /**
    *   emitted anytime the server replies with a /status message
    *   @param const char* The current boot status of the sc synth server: "inactive", "booting", or "running"
    *   @param int The current number of synths running on the server
    *   @param float The average CPU taken up by the server
    *   @param float The Peak CPU taken up by the server
    */
    void receiveServerStatus(const char* serverBootStatus, int numSynths, float avgCPU, float peakCPU);

    /**
    *   emitted when a new chat message comes in over osc
    *   @param const char* The new message
    */
    void receiveChatMessage(const char* message);

    /**
    *   addPeer emitted when a new peer logs on to OSCthulhu
    *   @param const char* the screen name of the user to add
    */
    void receiveAddPeer(const char* userName);

    /**
    *   removePeer emitted when a current peer logs off OSCthulhu
    *   @param const char* the screen name of the user to remove
    */
    void receiveRemovePeer(std::string userName);

    /** called when we get a reply for the user name */
    void receiveUserNameReply(std::string userName);

    /** create a new avatar instance */
    void receiveAddAvatar(const char* avatar, float x, float y, float z);

    /** move the avatar */
    void receiveMoveAvatar(const char* avatar, int dimensionIndex, float val);

    /** remove the avatar */
    void receiveRemoveAvatar(const char* avatar);

    /** add random seed (which everyone will use for terrain generation. Terrain won't be generated until we get this BACK */
    void receiveSetRandomSeed(unsigned int seed);

    /** set start/stop sequencing the snakes */
    void receiveSetSequencing(int sequencing);

    void receiveAddSnakeRange(const char* id, const char* synthName, int position, int corner);
    void receiveRemoveSnakeRange(const char* id);
    void receiveSnakeRangePosition(const char* id, int position);
    void receiveSnakeRangeCorner(const char* id, int corner);
    void receiveSetTempo(int milliseconds);
}

#endif // SHNETWORK_H

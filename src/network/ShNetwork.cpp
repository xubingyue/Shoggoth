// System includes
#include <time.h>
#include <sstream>

// Local includes
#include "cinder/Vector.h"
#include "src/network/ShNetwork.h"
#include "src/network/ShClient.h"
#include "src/network/ShPacketListener.h"
#include "src/ShGlobals.h"
#include "src/Graphics/ShAvatar.h"
#include "src/ShChat.h"
#include "src/Graphics/ShIsland.h"
#include "src/network/ShCompress.h"

namespace ShNetwork {

const int PACKET_BUFFER_SIZE = 1024; // The buffer size for packets sent to OSCthulhu
bool ONLINE = false; // Online status of the program
ShClient* client = 0; // Pointer to the active client, for sending
ShPacketListener* listener = 0; // Pointer to the active listener, for receiving
ShChat* chat = new ShChat();
int statusCounter = 0;

void sendLogin()
{
    sendCthulhu("/changePorts", 32244);
    sendCthulhu("/login", "Shoggoth");
    sendChatMessage("Shoggoth client logging into OSCthulhu");
    sendCthulhuAddObject("Sequencing", "ShGlobal", 0);
    sendCthulhuAddObject("Tempo", "ShGlobal", 100);
    sendCthulhuAddObject("SectionNumber", "ShGlobal", 0);

    std::vector<int> islandArgs;
    islandArgs.push_back(0); // Terrain Steps
    islandArgs.push_back(0); // Terrain Heights

    sendCthulhuAddObject("0", "Islands", islandArgs);
    sendCthulhuAddObject("1", "Islands", islandArgs);
    sendCthulhuAddObject("2", "Islands", islandArgs);
    sendCthulhuAddObject("3", "Islands", islandArgs);
}

void sendLogout()
{
    sendChatMessage("Shoggoth client logging out of OSCthulhu");
    sendCthulhuRemoveObject(ShGlobals::USER_NAME.c_str());
    sendCthulhu("/cleanup", "Shoggoth");
}

void sendMoveAvatar(cinder::Vec3f pos)
{
    std::cout << "SEND MOVE AVATAR: " << pos << std::endl;
    pos /= 4;
    pos += cinder::Vec3i(512, 512, 512);
    sendCthulhuSetIntArg(ShGlobals::USER_NAME.c_str(), 0, compressVec3(pos), 0);
    // receiveMoveAvatar(ShGlobals::USER_NAME.c_str(), compressVec3(pos));
    //sendCthulhuSetArg(ShGlobals::USER_NAME.c_str(), 0, pos.x, 1);
    //sendCthulhuSetArg(ShGlobals::USER_NAME.c_str(), 1, pos.y, 1);
    //sendCthulhuSetArg(ShGlobals::USER_NAME.c_str(), 2, pos.z, 1);
}

void sendRotateAvatar(cinder::Quatf rot)
{
    //sendCthulhuSetArg(ShGlobals::USER_NAME.c_str(), 3, rot.v.x, 1);
    //sendCthulhuSetArg(ShGlobals::USER_NAME.c_str(), 4, rot.v.y, 1);
    //sendCthulhuSetArg(ShGlobals::USER_NAME.c_str(), 5, rot.v.z, 1);
    //sendCthulhuSetArg(ShGlobals::USER_NAME.c_str(), 6, rot.w, 1);
}

void sendSetRandomSeed()
{
    sendCthulhuSetArg("Seed", 0, time(0));
}

void sendStartSequencing()
{
    sendCthulhuSetIntArg("Sequencing", 0, 1);
}

void sendEndSequencing()
{
    sendCthulhuSetIntArg("Sequencing", 0, 0);
}

void sendChatMessage(const char* message)
{
    sendCthulhu("/chat", message);
}

void sendTerrainSteps(unsigned char islandNum, Algorithm algorithm, unsigned char genArgument)
{
    int arg = compressSteps(algorithm, genArgument);

    std::stringstream ss;
    ss << (short) islandNum;

    char buffer[PACKET_BUFFER_SIZE];
    osc::OutboundPacketStream packet( buffer, PACKET_BUFFER_SIZE );
    packet << osc::BeginMessage("/setSyncArg") << ss.str().c_str() << 0 << arg << 0 << osc::EndMessage;
    client->sendCthulhu(packet);
}

void receiveTerrainSteps(unsigned char islandNum, int arg)
{
    unsigned char algorithm;
    unsigned char genArgument;

    decompressSteps(arg, algorithm, genArgument);

    switch(algorithm)
    {
    case Empty:
        ShGlobals::ISLAND_GRID->emptySteps(islandNum);
        break;

    case DiamondSquare:
        ShGlobals::ISLAND_GRID->diamondSquareSteps(islandNum, genArgument);
        break;

    case Wolfram:
        ShGlobals::ISLAND_GRID->wolframCASteps(islandNum, genArgument);
        break;

    case StrangeAttractor:
        ShGlobals::ISLAND_GRID->strangeSteps(islandNum, genArgument);
        break;

    case LSystem:
        ShGlobals::ISLAND_GRID->lSystemSteps(islandNum, genArgument);
        break;

    case Flocking:
        ShGlobals::ISLAND_GRID->flockingSteps(islandNum, genArgument);
        break;

    case WaveTable:
        break;

    case Graphics:
        break;
    }
}

void sendTerrainHeights(unsigned char islandNum, Algorithm algorithm, unsigned char genArgument)
{
    int arg = compressTerrain(algorithm, genArgument);

    std::stringstream ss;
    ss << (short) islandNum;

    char buffer[PACKET_BUFFER_SIZE];
    osc::OutboundPacketStream packet( buffer, PACKET_BUFFER_SIZE );
    packet << osc::BeginMessage("/setSyncArg") << ss.str().c_str() << 1 << arg << 0 << osc::EndMessage;
    client->sendCthulhu(packet);
}

void receiveTerrainHeights(unsigned char islandNum, int arg)
{
    unsigned char algorithm;
    unsigned char genArgument;

    decompressTerrain(arg, algorithm, genArgument);

    switch(algorithm)
    {
    case Empty:
        ShGlobals::ISLAND_GRID->emptyHeights(islandNum);
        break;

    case DiamondSquare:
        ShGlobals::ISLAND_GRID->diamondSquareHeights(islandNum, genArgument);
        break;

    case Wolfram:
        ShGlobals::ISLAND_GRID->wolframHeights(islandNum, genArgument);
        break;

    case StrangeAttractor:
        ShGlobals::ISLAND_GRID->strangeHeights(islandNum, genArgument);
        break;

    case LSystem:
        ShGlobals::ISLAND_GRID->lSystemHeights(islandNum, genArgument);
        break;

    case Flocking:
        ShGlobals::ISLAND_GRID->flockingHeights(islandNum, genArgument);
        break;

    case WaveTable:
        break;

    case Graphics:
        break;
    }
}

void sendSCStatusRequest()
{
    if(statusCounter == 0)
    {
        char buffer[PACKET_BUFFER_SIZE];
        osc::OutboundPacketStream packet( buffer, PACKET_BUFFER_SIZE );
        packet << osc::BeginMessage("/status") << osc::EndMessage;
        client->send("127.0.0.1", packet, 57110);
    }

    statusCounter = (statusCounter + 1) % 5;
}

const char* snakeIDtoString(std::pair<unsigned int, unsigned int> id)
{
    std::stringstream ss;
    ss << id.first << "|" << id.second;
    return ss.str().c_str();
}

std::pair<unsigned int, unsigned int> snakeStringToID(const char* id)
{
    std::string snakeID(id);
    size_t divider = snakeID.find("|");
    int id1 = 0;
    int id2 = 0;

    if(divider != snakeID.size())
    {
        std::stringstream ss;
        ss << snakeID.substr(0, divider);
        ss >> id1;

        std::stringstream ss2;
        ss2 << snakeID.substr(divider + 1);
        ss2 >> id2;
    }

    return std::make_pair(id1, id2);
}

void sendAddSnakeRange(std::pair<unsigned int, unsigned int> id, std::string synthName, cinder::Vec2i corner1,
                       cinder::Vec2i corner2)
{
    int corner1Int = compressVec2(corner1);
    int corner2Int = compressVec2(corner2);

    char buffer[PACKET_BUFFER_SIZE];
    osc::OutboundPacketStream packet( buffer, PACKET_BUFFER_SIZE );
    packet << osc::BeginMessage("/addSyncObject") << snakeIDtoString(id) << "Shoggoth" << "SnakeRange"
           << synthName.c_str() << corner1Int << corner2Int << osc::EndMessage;

    client->sendCthulhu(packet);
}

void sendRemoveSnakeRange(std::pair<unsigned int, unsigned int> id)
{
    sendCthulhuRemoveObject(snakeIDtoString(id));
}

void sendSnakeRangePosition(std::pair<unsigned int, unsigned int> id, cinder::Vec2i corner)
{
    sendCthulhuSetIntArg(snakeIDtoString(id), 1, compressVec2(corner));
}

void sendSnakeRangeCorner(std::pair<unsigned int, unsigned int> id, cinder::Vec2i corner)
{
    sendCthulhuSetIntArg(snakeIDtoString(id), 2, compressVec2(corner));
}

void sendCreateTimeStream(const char* id, long time)
{
    // sendCthulhuAddIntObject(id, "TimeSteam", time);
}

void sendSetTempo(int milliseconds)
{
    sendCthulhuSetIntArg("Tempo", 0, milliseconds);
}

void sendSetSection(int sectionNumber)
{
    sendCthulhuSetIntArg("SectionNumber", 0, sectionNumber);
}

void sendCthulhu(const char *command)
{
    char buffer[PACKET_BUFFER_SIZE];
    osc::OutboundPacketStream packet( buffer, PACKET_BUFFER_SIZE );
    packet << osc::BeginMessage(command) << osc::EndMessage;
    client->sendCthulhu(packet);
}

void sendCthulhu(const char *command, const char *value)
{
    char buffer[PACKET_BUFFER_SIZE];
    osc::OutboundPacketStream packet( buffer, PACKET_BUFFER_SIZE );
    packet << osc::BeginMessage(command) << value << osc::EndMessage;
    client->sendCthulhu(packet);
}

void sendCthulhu(const char *command, float value)
{
    char buffer[PACKET_BUFFER_SIZE];
    osc::OutboundPacketStream packet( buffer, PACKET_BUFFER_SIZE );
    packet << osc::BeginMessage(command) << value << osc::EndMessage;
    client->sendCthulhu(packet);
}

void sendCthulhuAddObject(const char* object, const char* subType, int value)
{
    char buffer[PACKET_BUFFER_SIZE];
    osc::OutboundPacketStream packet( buffer, PACKET_BUFFER_SIZE );
    packet << osc::BeginMessage("/addSyncObject") << object << "Shoggoth" << subType << value << osc::EndMessage;
    client->sendCthulhu(packet);
}

void sendCthulhuAddObject(const char* object, const char* subType, std::vector<int>& arguments)
{
    char buffer[PACKET_BUFFER_SIZE];
    osc::OutboundPacketStream packet( buffer, PACKET_BUFFER_SIZE );

    packet << osc::BeginMessage("/addSyncObject") << object << "Shoggoth" << subType;

    for(int i = 0; i < arguments.size(); ++i)
    {
        packet << arguments[i];
    }

    packet << osc::EndMessage;
    client->sendCthulhu(packet);
}

void sendCthulhuAddObject(const char* object, const char* subType, std::vector<float> &arguments)
{
    char buffer[PACKET_BUFFER_SIZE];
    osc::OutboundPacketStream packet( buffer, PACKET_BUFFER_SIZE );

    packet << osc::BeginMessage("/addSyncObject") << object << "Shoggoth" << subType;

    for(int i = 0; i < arguments.size(); ++i)
    {
        packet << arguments[i];
    }

    packet << osc::EndMessage;
    client->sendCthulhu(packet);
}

void sendCthulhuAddIntObject(const char* object, const char* subType, long value)
{
    char buffer[PACKET_BUFFER_SIZE];
    osc::OutboundPacketStream packet( buffer, PACKET_BUFFER_SIZE );
    packet << osc::BeginMessage("/addSyncObject") << object << "Shoggoth" << subType << value << osc::EndMessage;
    client->sendCthulhu(packet);
}

void sendCthulhuRemoveObject(const char* object)
{
    char buffer[PACKET_BUFFER_SIZE];
    osc::OutboundPacketStream packet( buffer, PACKET_BUFFER_SIZE );
    packet << osc::BeginMessage("/removeSyncObject") << object << osc::EndMessage;
    client->sendCthulhu(packet);
}

void sendCthulhuSetArg(const char* object, int argNum, float value, int bounceBack)
{
    char buffer[PACKET_BUFFER_SIZE];
    osc::OutboundPacketStream packet( buffer, PACKET_BUFFER_SIZE );
    packet << osc::BeginMessage("/setSyncArg") << object << argNum << value << bounceBack << osc::EndMessage;
    client->sendCthulhu(packet);
}

void sendCthulhuSetIntArg(const char* object, int argNum, int value, int bounceBack)
{
    char buffer[PACKET_BUFFER_SIZE];
    osc::OutboundPacketStream packet( buffer, PACKET_BUFFER_SIZE );
    packet << osc::BeginMessage("/setSyncArg") << object << argNum << value << bounceBack << osc::EndMessage;
    client->sendCthulhu(packet);
}

void receiveServerStatus(const char* serverBootStatus, int numSynths, float avgCPU, float peakCPU)
{

}

void receiveChatMessage(const char* message)
{
    if(chat != 0)
        chat->queueMessage(message);

    // ShGlobals::DATA->queueChatStore(message);
}

void receiveAddPeer(const char* userName)
{
    // ShGlobals::DATA->queueUserLogin(userName);
}

void receiveRemovePeer(std::string userName)
{
    // ShGlobals::DATA->queueUserLogout(userName);
}

void receiveUserNameReply(std::string userName)
{
    ShGlobals::USER_NAME = userName;

    /*
    std::vector<float> dimensions;

    for(int i = 0; i < 7; ++i)
    {
        dimensions.push_back(0);
    }*/

    std::cout << "USER NAME: " << userName << std::endl;
    sendCthulhuAddObject(ShGlobals::USER_NAME.c_str(), "Avatars", 0);
}

void receiveAddAvatar(const char* avatar, float x, float y, float z)
{
    if(!ShAvatar::avatarMap.contains(avatar))
        ShAvatar::avatarMap.add(avatar, cinder::Vec3f(x, y, z));
}

void receiveAddAvatar(const char* avatar, int compressedPos)
{
    if(!ShAvatar::avatarMap.contains(avatar))
    {
        std::cout << "ADD AVATAR: " << avatar << std::endl;
        cinder::Vec3i pos = decompressVec3(compressedPos);
        pos -= cinder::Vec3i(512, 512, 512);
        pos *= 4;
        ShAvatar::avatarMap.add(avatar, pos);
    }
}

void receiveMoveAvatar(const char* avatar, int dimensionIndex, float val)
{
    if(ShAvatar::avatarMap.contains(avatar))
    {
        switch(dimensionIndex)
        {
        case 0:
            ShAvatar::avatarMap.setPosX(avatar, val);
            break;

        case 1:
            ShAvatar::avatarMap.setPosY(avatar, val);
            break;

        case 2:
            ShAvatar::avatarMap.setPosZ(avatar, val);
            break;

        case 3:
            ShAvatar::avatarMap.setRotX(avatar, val);
            break;

        case 4:
            ShAvatar::avatarMap.setRotY(avatar, val);
            break;

        case 5:
            ShAvatar::avatarMap.setRotZ(avatar, val);
            break;

        case 6:
            ShAvatar::avatarMap.setRotW(avatar, val);
            break;
        }
    }
}

void receiveMoveAvatar(const char* avatar, int compressedPos)
{
    cinder::Vec3i pos = decompressVec3(compressedPos);
    pos -= cinder::Vec3i(512, 512, 512);
    pos *= 4;
    // std::cout << "Move Avatar" << pos << std::endl;

    ShAvatar::avatarMap.move(avatar, pos);
}

void receiveRemoveAvatar(const char* avatar)
{
    if(ShAvatar::avatarMap.contains(avatar))
        ShAvatar::avatarMap.remove(avatar);
}

void receiveSetRandomSeed(unsigned int seed)
{
    ShGlobals::RAND_SEED = seed;
}

void receiveSetSequencing(int sequencing)
{
    if(sequencing == 1 && !ShGlobals::SEQUENCER->isPlaying)
    {
        ShGlobals::SEQUENCER->play();
        // ShGlobals::TIME_QUAKE_DISPLAY->startThreading();
    }

    else if(sequencing == 0 && ShGlobals::SEQUENCER->isPlaying)
    {
        ShGlobals::SEQUENCER->stop();
        // ShGlobals::TIME_QUAKE_DISPLAY->stopThreading();
    }
}

void receiveAddSnakeRange(const char *id, const char *synthName, int position, int corner)
{
    std::pair<unsigned int, unsigned int> snakeID = snakeStringToID(id);

    ShGlobals::ISLAND_GRID->addShSnakeRange(
                snakeID,
                synthName,
                decompressVec2(position),
                decompressVec2(corner)
    );
}

void receiveSnakeRangePosition(const char* id, int position)
{
    ShGlobals::ISLAND_GRID->setSnakeRangePosition(snakeStringToID(id), decompressVec2(position));
}

void receiveSnakeRangeCorner(const char *id, int corner)
{
    ShGlobals::ISLAND_GRID->setSnakeRangeCorner(snakeStringToID(id), decompressVec2(corner));
}

void receiveRemoveSnakeRange(const char* id)
{
    ShGlobals::ISLAND_GRID->removeSnakeRange(snakeStringToID(id));
}

void receiveSetTempo(int milliseconds)
{
    boost::chrono::milliseconds tempo(milliseconds);
    ShGlobals::SEQUENCER->setStepQuant(tempo);
    // ShGlobals::TIME_STREAM_SCHEDULER->addTimeEvent(new TempoEvent(tempo, ShGlobals::TIME_STREAM_TIMER->getTime()));
}

void receiveSetSectionNumber(int sectionNumber)
{
    ShGlobals::setSectionNumber(sectionNumber, true);
}

} // Close out ShNetwork namespace

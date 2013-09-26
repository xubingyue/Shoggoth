// System includes
#include <iostream>

// Local includes
#include "ShPacketListener.h"
#include "src/ShGlobals.h"
#include "src/network/ShNetwork.h"

ShPacketListener::ShPacketListener() :
    osc::OscPacketListener()
{
    ShNetwork::listener = this; // Set the ShNetwork::listener pointer to point to this instance
}

void ShPacketListener::ProcessMessage(const osc::ReceivedMessage &message, const IpEndpointName &remoteEndpoint)
{

    try {

        // Status Reply from SCSynth
        if( strcmp( message.AddressPattern(), "/status.reply" ) == 0 ) {

            osc::ReceivedMessageArgumentStream args = message.ArgumentStream();
            osc::int32 un, numUGens, numSynths, numGroups, numSynthDefs;

            float avgCPU,peakCPU;
            double nominalSR,actualSR;

            args >> un >> numUGens >> numSynths >> numGroups >> numSynthDefs
                    >> avgCPU >> peakCPU >> nominalSR >> actualSR;

            // ShNetwork::receiveServerStatus("running", numSynths, avgCPU, peakCPU);
            serverpanel::update(numUGens, numSynths, avgCPU, peakCPU);

            /*
            std::cout << "Number Of Ugens: " << numUGens << " Number Of Synths: " << numSynths
                      << " Number Of Groups: " <<  numGroups << " Number Of Synth Defs: " << numSynthDefs
                      << " Avg CPU: " << avgCPU << " PeakCPU: " << peakCPU
                      << " Nominal Sample Rate: " << nominalSR << " Actual Sample Rate: " << actualSR
                      << std::endl;*/


        }

        if(ShNetwork::ONLINE)
        {
            if(strcmp( message.AddressPattern(), "/addSyncObject" ) == 0) {

                osc::ReceivedMessage::const_iterator arg = message.ArgumentsBegin();

                const char* objectName = (arg++)->AsString();
                const char* objectType = (arg++)->AsString();
                const char* objectSubType = (arg++)->AsString();

                if(strcmp(objectSubType, "SnakeRange") == 0)
                {
                    const char* synthName = (arg++)->AsString();
                    int position = (arg++)->AsInt32();
                    int corner = (arg++)->AsInt32();

                    ShNetwork::receiveAddSnakeRange(objectName, synthName, position, corner);
                }

                else if(strcmp(objectSubType, "Avatars") == 0)
                {
                    /*
                    int x = (arg++)->AsFloat();
                    int y = (arg++)->AsFloat();
                    int z = (arg++)->AsFloat();

                    ShNetwork::receiveAddAvatar(objectName, x, y, z);*/
                    ShNetwork::receiveAddAvatar(objectName, (arg++)->AsInt32());
                }

                else if(strcmp(objectSubType, "ShGlobal") == 0)
                {
                    int val = (arg++)->AsInt32();

                    if(strcmp(objectName, "Sequencing") == 0)
                    {
                        ShNetwork::receiveSetSequencing(val);
                    }

                    else if(strcmp(objectName, "Seed") == 0)
                    {
                        ShNetwork::receiveSetRandomSeed(val);
                    }
                }

            } else if(strcmp( message.AddressPattern(), "/removeSyncObject" ) == 0) {

                osc::ReceivedMessage::const_iterator arg = message.ArgumentsBegin();

                const char* objectName = (arg++)->AsString();
                const char* objectType = (arg++)->AsString();
                const char* objectSubType = (arg++)->AsString();

                if(strcmp(objectSubType, "SnakeRange") == 0)
                {
                    ShNetwork::receiveRemoveSnakeRange(objectName);
                }

                else if(strcmp(objectSubType, "Avatars") == 0)
                {

                    ShNetwork::receiveRemoveAvatar(objectName);
                }

            } else if(strcmp( message.AddressPattern(), "/setSyncArg" ) == 0) {

                osc::ReceivedMessage::const_iterator typeArg = message.ArgumentsBegin();
                const char* objectSubType;

                int numArgs = message.ArgumentCount();

                for(int i = 0; i < numArgs; i++)
                {

                    if(i == (numArgs-1))
                    {
                        objectSubType = (typeArg++)->AsString();
                    }

                    else
                    {
                        typeArg++;
                    }
                }

                osc::ReceivedMessage::const_iterator arg = message.ArgumentsBegin();

                const char* objectName = (arg++)->AsString();
                int argNum = (arg++)->AsInt32();

                if(strcmp(objectSubType, "Avatars") == 0)
                {
                    // float val = (arg++)->AsFloat();
                    int val = (arg++)->AsInt32();

                    if(argNum == 0)
                        ShNetwork::receiveMoveAvatar(objectName, val);
                    else
                        ShNetwork::receiveRotateAvatar(objectName, val);
                    // ShNetwork::receiveMoveAvatar(objectName, argNum, val);
                }

                else if(strcmp(objectSubType, "SnakeRange") == 0)
                {
                    switch(argNum)
                    {
                    case 0: // SynthName
                        break;
                    case 1: // Position
                        ShNetwork::receiveSnakeRangePosition(objectName, (arg++)->AsInt32());
                        break;
                    case 2: // Corner
                        ShNetwork::receiveSnakeRangeCorner(objectName, (arg++)->AsInt32());
                        break;
                    }
                }

                else if(strcmp(objectSubType, "ShGlobal") == 0)
                {
                    if(strcmp(objectName, "Tempo") == 0)
                    {
                        ShNetwork::receiveSetTempo((arg++)->AsInt32());
                    }

                    else if(strcmp(objectName, "Sequencing") == 0)
                    {
                        int val = (arg++)->AsInt32();
                        ShNetwork::receiveSetSequencing(val);
                    }

                    else if(strcmp(objectName, "SectionNumber") == 0)
                    {
                        int val = (arg++)->AsInt32();
                        ShNetwork::receiveSetSectionNumber(val);
                    }
                }

                else if(strcmp(objectSubType, "Islands") == 0)
                {
                    int value = (arg++)->AsInt32();

                    switch(argNum)
                    {
                    case 0: // Terrain Steps
                        ShNetwork::receiveTerrainSteps(atoi(objectName), value);
                        break;

                    case 1: // Terrain Heights
                        ShNetwork::receiveTerrainHeights(atoi(objectName), value);
                        break;
                    }
                }

            } else if(strcmp( message.AddressPattern(), "/chat" ) == 0) {

                osc::ReceivedMessageArgumentStream args = message.ArgumentStream();
                const char* message;
                args >> message >> osc::EndMessage;
                ShNetwork::receiveChatMessage(message);

            } else if(strcmp( message.AddressPattern(), "/addPeer" ) == 0) {

                osc::ReceivedMessageArgumentStream args = message.ArgumentStream();
                const char* userName;
                args >> userName >> osc::EndMessage;
                ShNetwork::receiveAddPeer(userName);

            } else if(strcmp( message.AddressPattern(), "/removePeer" ) == 0) {

                osc::ReceivedMessageArgumentStream args = message.ArgumentStream();
                const char* userName;
                args >> userName >> osc::EndMessage;
                ShNetwork::receiveRemovePeer(userName);

            } else if( strcmp( message.AddressPattern(), "/userName" ) == 0 ) {

                osc::ReceivedMessage::const_iterator arg = message.ArgumentsBegin();
                ShGlobals::USER_NAME = (arg++)->AsString();
                std::cout << "userName is: " << ShGlobals::USER_NAME << std::endl;
                ShNetwork::receiveUserNameReply(ShGlobals::USER_NAME);

            } else if( strcmp( message.AddressPattern(), "/ports" ) == 0 ) {

            } else if( strcmp( message.AddressPattern(), "/status.reply") != 0) {

                std::cout << "OSC message not understood: " << message.AddressPattern() << std::endl;
            }
        }

    } catch( osc::Exception& e ) {

        std::cerr << "error while parsing message: "
                << message.AddressPattern( ) <<": " << e.what( ) << std::endl;
    }
}

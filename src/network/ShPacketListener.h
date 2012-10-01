#pragma once

// System includes
#include <oscpack/osc/OscPacketListener.h>

/**
*   ShPacketListener
*   Listenes for and parses OSC messages
*/
class ShPacketListener : public osc::OscPacketListener
{

public:

    ShPacketListener();

protected:

    /** parses the incoming osc messages */
    void ProcessMessage(const osc::ReceivedMessage &message, const IpEndpointName &remoteEndpoint);
};

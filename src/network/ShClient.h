#pragma once

// System includes
#include "boost/thread.hpp"
#include "boost/thread/shared_mutex.hpp"

// Local includes
#include "oscpack/ip/IpEndpointName.h"
#include "oscpack/ip/UdpSocket.h"
#include "oscpack/osc/OscOutboundPacketStream.h"
#include "src/network/ShPacketListener.h"


/**
*   ShClient
*   Maintains persistent local user status with networked data, also handles multithread data access
*/
class ShClient
{

public:

    /**
    *   ShClient Constructor
    *   @param const char *ipAddress to send messages to
    *   @param int receivePort Port to send messages on
    */
    ShClient(const char *ipAddress = "127.0.0.1", int receivePort = 32244);

    /**
    *   ShClient deconstructor
    */
    ~ShClient();

    /**
    *   send Sends the packet stream to the stored ip address/port number
    *   @param osc::OutboundPacketStream packetStream the message to be sent
    *   @param int sendPort Port to send messages to
    */
    void send(osc::OutboundPacketStream packetStream, int sendPort = 67110);

    /**
    *   send Sends the packet stream to the stored ip address/port number
    *   @param ip the ip address to send the packet
    *   @param osc::OutboundPacketStream packetStream the message to be sent
    *   @param int sendPort Port to send messages to
    */
    void send(const char* ip, osc::OutboundPacketStream packetStream, int sendPort = 67110);

    /**
    *   send Sends the packet stream to the stored ip address/port number
    *   @param osc::OutboundPacketStream packetStream the message to be sent
    */
    void sendCthulhu(osc::OutboundPacketStream packetStream);

    /** starts the internal thread and begins networking */
    void start();

    /** stops the internal thread and ends networking */
    void stop();

    /**
    *   run Start this thread
    */
    void run();

    /**
    *   Returns a pointer to the packet listener. used for Signals/Slots
    *   @return YigPacketListener* The pointer to the listener
    */
    ShPacketListener* getPacketListener();

    /**
    *   getReceiveSocket
    *   @return UdpReceiveSocket* Returns a pointer to the thread's receive socket
    */
    UdpReceiveSocket* getReceiveSocket();

private:

    /**
    *   quitConnection
    *   closes the socket and ends networking
    */
    void quitConnection();

    /** ip address this client communicates with */
    const char* mIpAddress;
    /** the ports that we send to and receive on */
    int mReceivePort;
    /** The client osc thread that actually sends/receives osc messages */
    boost::thread* oscThread;
    /** locks down resources */
    boost::shared_mutex oscMutex;
    /** packet listener used for parsing messages */
    ShPacketListener listener;
    /** the socket this client sends/receives on */
    UdpReceiveSocket* receiveSocket;
    /** synchronizes the out/in port */
    SocketReceiveMultiplexer mux;
};

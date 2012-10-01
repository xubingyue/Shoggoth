// System includes

// Local includes
#include "ShClient.h"
#include "src/ShGlobals.h"
#include "src/network/ShNetwork.h"


///////////////
// ShClient
//////////////

ShClient::ShClient(const char *ipAddress, int receivePort) :
    mIpAddress(ipAddress)
{
    oscThread = 0;
    mReceivePort = receivePort;
    receiveSocket = new UdpReceiveSocket(IpEndpointName( IpEndpointName::ANY_ADDRESS, receivePort));
    ShNetwork::client = this; // Set the namespace client pointer to point to this instance
}

ShClient::~ShClient()
{
    if(ShNetwork::ONLINE)
    {
        stop();
    }

    delete receiveSocket;
}

void ShClient::send(osc::OutboundPacketStream packetStream, int sendPort)
{
    receiveSocket->SendTo(
            IpEndpointName(
                mIpAddress,
                sendPort
                ),
            packetStream.Data(),packetStream.Size()
    );
}


void ShClient::send(const char* ip, osc::OutboundPacketStream packetStream, int sendPort)
{
    receiveSocket->SendTo(
            IpEndpointName(
                ip,
                sendPort
                ),
            packetStream.Data(),packetStream.Size()
    );
}

void ShClient::sendCthulhu(osc::OutboundPacketStream packetStream)
{
    receiveSocket->SendTo(
            IpEndpointName(
                mIpAddress,
                ShGlobals::OSCTHULHU_PORT
                ),
            packetStream.Data(),packetStream.Size()
    );
}


void ShClient::start()
{
    ShNetwork::ONLINE = true;
    oscThread = new boost::thread(boost::bind(&ShClient::run, this));
}

void ShClient::stop()
{
    quitConnection();
    ShNetwork::ONLINE = false;
}

void ShClient::run() {
    mux.AttachSocketListener(receiveSocket,&listener);
    mux.Run();
    //exec();
    //mux.RunUntilSigInt();
}

void ShClient::quitConnection() {
    mux.DetachSocketListener(receiveSocket, &listener);
    mux.AsynchronousBreak();
    this->oscThread->join();

    if(oscThread != 0)
        delete oscThread;

    oscThread = 0;
    //mux.Break();
}

UdpReceiveSocket* ShClient::getReceiveSocket() {
    return receiveSocket;
}

ShPacketListener* ShClient::getPacketListener()
{
    return &listener;
}

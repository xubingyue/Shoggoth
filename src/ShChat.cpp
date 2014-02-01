#include "cinder/gl/gl.h"
#include "cinder/CinderResources.h"

#include "ShChat.h"
#include "ShGlobals.h"
#include "src/network/ShNetwork.h"
#include "Resources.h"

ShChat::ShChat()
{
    boost::shared_lock<boost::shared_mutex> lock(chatMutex);
    messageEntryTexture = 0;
    talkTexture = 0;
    editEntry = false;
}

ShChat::~ShChat()
{
    boost::shared_lock<boost::shared_mutex> lock(chatMutex);
    std::deque<cinder::gl::Texture*>::iterator iter = messages.begin();
    while(iter != messages.end())
    {
        delete *iter;
        ++iter;
    }
    messages.clear();
    if(talkTexture != 0)
        delete talkTexture;
}

void ShChat::update()
{
    boost::shared_lock<boost::shared_mutex> lock(chatMutex);
    if(ShNetwork::ONLINE && messageQueue.size() > 0)
    {
        addMessage(messageQueue.front());
        messageQueue.pop_front();
    }
}

void ShChat::draw()
{
    boost::shared_lock<boost::shared_mutex> lock(chatMutex);
    cinder::gl::color(cinder::Color::white());

    int index = 0;
    std::deque<cinder::gl::Texture*>::iterator iter = messages.begin();
    while(iter != messages.end())
    {
        cinder::gl::draw(*(*iter), cinder::Vec2f(50, ShGlobals::SCREEN_SIZE.y - 40 - (index * 16)));

        ++iter;
        ++index;
    }

    if(editEntry)
    {
        cinder::gl::draw(*talkTexture, cinder::Vec2f(50, ShGlobals::SCREEN_SIZE.y - 20));
        cinder::gl::draw(*messageEntryTexture, cinder::Vec2f(87, ShGlobals::SCREEN_SIZE.y - 20));
    }

}

void ShChat::addMessage(std::string message)
{
    boost::shared_lock<boost::shared_mutex> lock(chatMutex);
    if(messages.size() >= NUM_DISPLAY_LINES)
    {
        delete messages.back();
        messages.pop_back();
    }

    messages.push_front(renderString(message));
}

void ShChat::addMessageEntry(char character)
{
    boost::shared_lock<boost::shared_mutex> lock(chatMutex);
    messageEntry.push_back(character);
    resetMessageEntryTexture();
    messageEntryTexture = renderString(messageEntry);
}

void ShChat::backspaceMessageEntry()
{
    boost::shared_lock<boost::shared_mutex> lock(chatMutex);
    if(messageEntry.size() > mMinMessageSize)
    {
        messageEntry.resize(messageEntry.size() - 1);
        resetMessageEntryTexture();
        messageEntryTexture = renderString(messageEntry);
    }
}

void ShChat::beginEditEntry()
{
    boost::shared_lock<boost::shared_mutex> lock(chatMutex);
    resetMessageEntry();
    setEditEntry(true);
}

void ShChat::finishEditEntry()
{
    boost::shared_lock<boost::shared_mutex> lock(chatMutex);
    if(ShNetwork::ONLINE)
        ShNetwork::sendChatMessage(messageEntry.c_str());
    else
        addMessage(messageEntry);

    setEditEntry(false);
}

void ShChat::setEditEntry(bool edit)
{
    boost::shared_lock<boost::shared_mutex> lock(chatMutex);
    editEntry = edit;
}

bool ShChat::getEditEntry()
{
    boost::shared_lock<boost::shared_mutex> lock(chatMutex);
    return editEntry;
}

void ShChat::resetMessageEntry()
{
    boost::shared_lock<boost::shared_mutex> lock(chatMutex);
    messageEntry.clear();
    //messageEntry = std::string(ShGlobals::USER_NAME + ": ");
    //mMinMessageSize = messageEntry.size();
    mMinMessageSize = 0;
    resetMessageEntryTexture();
    messageEntryTexture = renderString(messageEntry);
}

void ShChat::loadTexture(cinder::app::AppBasic *app)
{
    boost::shared_lock<boost::shared_mutex> lock(chatMutex);
#ifdef __APPLE__
    // mFont = cinder::Font(cinder::app::loadResource(TEXT_TEXTURE), 12);
    mFont = cinder::Font("Menlo", 12);
#else
    // mFont = cinder::Font(cinder::app::loadResource("./resources/OCRAEXT.ttf", 134, "TTF"), 12);
    mFont = cinder::Font("Ubuntu", 12);
#endif
    resetMessageEntry();
    talkTexture = renderString("say: ");
}

void ShChat::queueMessage(std::string message)
{
    boost::shared_lock<boost::shared_mutex> lock(chatMutex);
    messageQueue.push_back(message);
}

cinder::gl::Texture* ShChat::renderString(std::string message)
{
    boost::shared_lock<boost::shared_mutex> lock(chatMutex);
    try {
        cinder::TextLayout layout;
        layout.clear(cinder::ColorA(0, 0, 0, 0.85));
        layout.setColor(cinder::Color::white());
        layout.setFont(mFont);
        layout.addLine(message);

        cinder::Surface8u rendered = layout.render(true);

        return new cinder::gl::Texture(rendered);
    }

    catch(...)
    {
        return new cinder::gl::Texture();
    }
}

void ShChat::resetMessageEntryTexture()
{
    boost::shared_lock<boost::shared_mutex> lock(chatMutex);
    if(messageEntryTexture != 0)
        delete messageEntryTexture;

    messageEntryTexture = 0;
}

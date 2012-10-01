#ifndef SHCHAT_H
#define SHCHAT_H

#include <string>
#include <deque>
#include "cinder/Text.h"
#include "cinder/gl/Texture.h"
#include "cinder/gl/TextureFont.h"
#include "cinder/app/AppBasic.h"
#include "cinder/Surface.h"
#include "boost/thread/shared_mutex.hpp"


class ShChat
{
public:

    ShChat();
    ~ShChat();

    void update();
    void draw();
    void addMessage(std::string message);
    void addMessageEntry(char character);
    void backspaceMessageEntry();
    void resetMessageEntry();

    static const int NUM_DISPLAY_LINES = 10;
    void beginEditEntry();
    void finishEditEntry();
    void setEditEntry(bool edit);
    bool getEditEntry();
    void loadTexture(cinder::app::AppBasic* app);
    void queueMessage(std::string message);

private:

    cinder::gl::Texture* renderString(std::string message);
    void resetMessageEntryTexture();

    std::deque<cinder::gl::Texture*> messages;
    int mMinMessageSize;
    std::string messageEntry;
    bool editEntry;
    cinder::gl::Texture* messageEntryTexture;
    cinder::gl::Texture* talkTexture;
    cinder::Font mFont;
    boost::shared_mutex chatMutex;
    std::deque<std::string> messageQueue;
};

#endif // SHCHAT_H

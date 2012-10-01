#ifndef LUACONSOLE_H
#define LUACONSOLE_H

// System includes
#include <string>
#include <deque>

// Cinder includes
#include "cinder/Font.h"
#include "cinder/Vector.h"

// Boost includes
#include "boost/thread/shared_mutex.hpp"

class LuaConsole
{
public:
    LuaConsole();

    void draw();
    void addMessage(std::string message);
    void addConsoleEntry(char character);
    void backspaceConsoleEntry();
    void resetConsoleEntry();
    void updatePosition(); // Necessary to get location according to screen size which isn't set until later during setup

    static const int NUM_DISPLAY_LINES = 10;
    void beginEditEntry();
    void finishEditEntry();
    void setEditEntry(bool edit);
    bool getEditEntry();

private:

    void resetConsoleEntryTexture();

    std::deque<std::string> messages;
    std::string consoleEntry, luaPrependString;
    bool editEntry;
    cinder::Font mFont;
    boost::shared_mutex consoleMutex;
    cinder::Vec2i position;
};

#endif // LUACONSOLE_H

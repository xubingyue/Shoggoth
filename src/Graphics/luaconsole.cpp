// Local includes
#include "luaconsole.h"
#include "src/Resources.h"
#include "src/ShGlobals.h"
#include "src/Script/script.h"

// Cinder includes
#include "cinder/gl/gl.h"
#include "cinder/app/App.h"

LuaConsole::LuaConsole()
{
    boost::shared_lock<boost::shared_mutex> lock(consoleMutex);
    editEntry = false;
#ifdef __APPLE__
    mFont = cinder::Font(cinder::app::loadResource(TEXT_TEXTURE), 12);
#else
    //mFont = cinder::Font(cinder::app::loadResource("./resources/OCRAEXT.ttf", 134, "TTF"), 12);
    mFont = cinder::Font("Ubuntu", 12);
#endif
    luaPrependString = "Lua> ";
    consoleEntry = "";
    ShGlobals::LUA_CONSOLE = this;
    updatePosition();
}

void LuaConsole::draw()
{
    boost::shared_lock<boost::shared_mutex> lock(consoleMutex);

    int index = 0;
    std::deque<std::string>::iterator iter = messages.begin();
    cinder::gl::color(cinder::ColorA(0, 0, 0, 0.85));
    int offset;

    while(iter != messages.end())
    {
        offset = index * 16;

        cinder::gl::drawSolidRect(
                    cinder::Rectf(
                        position.x - 2,
                        position.y - offset - 2,
                        position.x + (iter->size() * 7.5) + 4,
                        position.y - offset + 12
                    )
        );

        cinder::gl::drawString(
                    *iter,
                    cinder::Vec2f(position.x, position.y - offset),
                    cinder::Color::white(),
                    mFont
        );

        ++iter;
        ++index;
    }

    if(editEntry)
    {
        cinder::gl::drawSolidRect(
                    cinder::Rectf(
                        position.x - 2,
                        position.y + 18,
                        position.x + ((consoleEntry.size() + luaPrependString.size()) * 7.5) + 4,
                        position.y + 18 + 12
                    )
        );


        cinder::gl::drawString(
                    luaPrependString,
                    cinder::Vec2f(position.x, position.y + 20),
                    cinder::Color::white(),
                    mFont
        );

        cinder::gl::drawString(
                    consoleEntry,
                    cinder::Vec2f(position.x + 37, position.y + 20),
                    cinder::Color::white(),
                    mFont
        );
    }
}

void LuaConsole::addMessage(std::string message)
{
    boost::shared_lock<boost::shared_mutex> lock(consoleMutex);

    if(message.compare("\n") != 0)
    {
        if(messages.size() >= NUM_DISPLAY_LINES)
        {
            messages.pop_back();
        }

        messages.push_front(message);
    }
}

void LuaConsole::addConsoleEntry(char character)
{
    boost::shared_lock<boost::shared_mutex> lock(consoleMutex);
    consoleEntry.push_back(character);
}

void LuaConsole::backspaceConsoleEntry()
{
    boost::shared_lock<boost::shared_mutex> lock(consoleMutex);

    if(consoleEntry.size() > 0)
        consoleEntry.resize(consoleEntry.size() - 1);
}

void LuaConsole::beginEditEntry()
{
    boost::shared_lock<boost::shared_mutex> lock(consoleMutex);
    resetConsoleEntry();
    setEditEntry(true);
}

void LuaConsole::finishEditEntry()
{
    boost::shared_lock<boost::shared_mutex> lock(consoleMutex);
    addMessage(consoleEntry);
    // script::interpret(consoleEntry.c_str());
    setEditEntry(false);
}

void LuaConsole::setEditEntry(bool edit)
{
    boost::shared_lock<boost::shared_mutex> lock(consoleMutex);
    editEntry = edit;
}

bool LuaConsole::getEditEntry()
{
    boost::shared_lock<boost::shared_mutex> lock(consoleMutex);
    return editEntry;
}

void LuaConsole::resetConsoleEntry()
{
    boost::shared_lock<boost::shared_mutex> lock(consoleMutex);
    consoleEntry.clear();
}

void LuaConsole::updatePosition()
{
    /*
    position = cinder::Vec2i(
                ShGlobals::SCREEN_SIZE.x - (ShGlobals::SCREEN_SIZE.y / 2),
                ShGlobals::SCREEN_SIZE.y - ((ShGlobals::SCREEN_SIZE.y / 2.0) * (2.0 / 3.0)) - 50
    );*/
}

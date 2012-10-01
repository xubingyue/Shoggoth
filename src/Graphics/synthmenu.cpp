// System includes
#include <fstream>
#include <streambuf>

// Shoggoth includes
#include "synthmenu.h"
#include "src/ShGlobals.h"

using namespace std;

//////////////////
// SynthMenuItem
//////////////////

SynthMenuItem::SynthMenuItem(std::string synthName, cinder::Rectf bounds) :
    synthName(synthName),
    bounds(bounds),
    hilighted(false)
{

    try {
        cinder::TextLayout layout;
        //layout.clear(cinder::ColorA(0, 0, 0, 0));
        layout.setColor(cinder::Color::white());
        layout.setFont(ShGlobals::FONT);
        layout.addLine(synthName);

        cinder::Surface8u rendered = layout.render(true);

        synthNameTexture = cinder::gl::Texture(rendered);
    }

    catch(...)
    {
        synthNameTexture =  cinder::gl::Texture();
    }

    coordinates[0] = bounds.getCenter().x;
    coordinates[1] = bounds.getCenter().y;
}

void SynthMenuItem::draw()
{
    cinder::gl::color(cinder::ColorA(0, 0, 0, 0.75));
    cinder::gl::drawSolidRect(bounds);
    cinder::gl::color(cinder::Color::white());
    cinder::gl::draw(synthNameTexture, bounds.getUpperLeft() + cinder::Vec2i(4, 4));
}

void SynthMenuItem::drawHighlight()
{
    cinder::gl::color(cinder::Color(0.8, 0, 0));
    cinder::gl::drawStrokedRect(bounds);
}

bool SynthMenuItem::checkMouseCoor(cinder::Vec2i mouseCoord, std::string* string)
{
    if(mouseCoord.x > bounds.x1 && mouseCoord.x < bounds.x2
            && mouseCoord.y > bounds.y1 && mouseCoord.y < bounds.y2)
    {
        *string = synthName;
        return true;
    }
}

double* SynthMenuItem::getCoordinates()
{
    return coordinates;
}

std::string SynthMenuItem::getSynthName()
{
    return synthName;
}

void SynthMenuItem::setBounds(cinder::Rectf bounds)
{
    this->bounds = bounds;
    coordinates[0] = bounds.getCenter().x;
    coordinates[1] = bounds.getCenter().y;
}

void SynthMenuItem::moveBounds(cinder::Vec2f moveCoord)
{
    bounds.offset(moveCoord);
    coordinates[0] = bounds.getCenter().x;
    coordinates[1] = bounds.getCenter().y;
}


/////////////
// SynthMenu
/////////////

SynthMenu::SynthMenu()
{
    synthItemTree = 0;
    currentlySelectedItem = 0;
    currentColumn = 0;
    currentRow = 0;
    createSynthMenuItems();
}

SynthMenu::~SynthMenu()
{
    kd_clear(synthItemTree);
    kd_free(synthItemTree);

    for(int i = 0; i < synthMenuItems.size(); ++i)
    {
        delete synthMenuItems[i];
    }

    synthMenuItems.clear();
}

void SynthMenu::draw()
{
    for(int i = 0; i < synthMenuItems.size(); ++i)
    {
        synthMenuItems[i]->draw();
    }

    if(currentlySelectedItem)
        currentlySelectedItem->drawHighlight();
}

void SynthMenu::checkMouseCoordinates(cinder::Vec2i mouseCoord)
{
    double coordinate[2] = {mouseCoord.x, mouseCoord.y};
    kdres* res = kd_nearest(synthItemTree, coordinate);
    currentlySelectedItem = (SynthMenuItem*) kd_res_item_data(res);
}

std::string SynthMenu::getCurrentlySelectedSynth()
{
    if(currentlySelectedItem)
        return currentlySelectedItem->getSynthName();
    else
        return "";
}

void SynthMenu::createSynthMenuItems()
{
    synthItemTree = kd_create(kDimensions);

    const char* fileName = "../Resources/Synths.shog";

    ifstream fileStream(fileName);

    if(fileStream.is_open())
    {
        std::cout << "FILE STREAM OPEN" << std::endl;
        std::string fileString((istreambuf_iterator<char>(fileStream)),
                               istreambuf_iterator<char>());

        char lineEnd = '\n';
        int beginLine, endLine;
        beginLine = endLine = 0;

        // Create SynthMenuItems
        for(int i = 0; i < fileString.size(); ++i)
        {
            if(fileString.at(i) == lineEnd || i == fileString.size() - 1) // End of line!
            {
                if(i == fileString.size() - 1)
                    ++endLine;

                std::string synthName = fileString.substr(beginLine, endLine - beginLine);

                SynthMenuItem* synthItem = new SynthMenuItem(
                            synthName,
                            cinder::Rectf(
                                currentColumn * itemWidth,
                                currentRow * itemHeight,
                                (currentColumn + 1) * itemWidth,
                                (currentRow + 1) * itemHeight
                            )
                );

                synthMenuItems.push_back(synthItem);

                ++currentRow;

                if(currentRow > numSynthsInColumn)
                {
                    currentRow = 0;
                    ++currentColumn;
                }

                ++endLine;
                beginLine = endLine;
            }

            else
            {
                ++endLine;
            }
        }

        // Offset to center of screen
        cinder::Vec2f offset(
                    ShGlobals::SCREEN_SIZE.x / 2 - (currentColumn / 2.0 * itemWidth),
                    ShGlobals::SCREEN_SIZE.y / 2 - (numSynthsInColumn / 2.0 * itemHeight)
        );

        for(int i = 0; i < synthMenuItems.size(); ++i)
        {
            synthMenuItems[i]->moveBounds(offset);
            kd_insert(synthItemTree, synthMenuItems[i]->getCoordinates(), synthMenuItems[i]);
        }
    }
}


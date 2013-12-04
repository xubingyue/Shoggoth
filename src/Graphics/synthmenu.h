#ifndef SYNTHMENU_H
#define SYNTHMENU_H

// system includes
#include <string>
#include <vector>

// kdtree
#include "kdtree/kdtree.h"

// cinder includes
#include "cinder/gl/Texture.h"
#include "cinder/Vector.h"
#include "cinder/Rect.h"

class SynthMenuItem;

/////////////
// SynthMenu
/////////////

class SynthMenu
{
public:

    SynthMenu();
    ~SynthMenu();

    void draw();
    void checkMouseCoordinates(cinder::Vec2i mouseCoord);
    std::string getCurrentlySelectedSynth();

    static const int kDimensions = 2;
    static const int numSynthsInColumn = 20;
    static const int itemWidth = 150;
    static const int itemHeight = 20;

private:

    void createSynthMenuItems();

    std::vector<SynthMenuItem*> synthMenuItems;
    kdtree* synthItemTree;
    SynthMenuItem* currentlySelectedItem;
    int currentColumn, currentRow;
};

/////////////////
// SynthMenuItem
/////////////////

class SynthMenuItem
{
public:

    SynthMenuItem(std::string synthName, cinder::Rectf bounds);

    void draw();
    void drawHighlight();
    bool checkMouseCoor(cinder::Vec2i mouseCoord, std::string* string); // Checks for hit, if true, sets string
    double* getCoordinates();
    std::string getSynthName();
    void setBounds(cinder::Rectf bounds);
    void moveBounds(cinder::Vec2f moveCoord);

private:

    std::string synthName;
    cinder::Rectf bounds;
    cinder::gl::Texture synthNameTexture;
    bool hilighted;
    double coordinates[SynthMenu::kDimensions];
};

#endif // SYNTHMENU_H

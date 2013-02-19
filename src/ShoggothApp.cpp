// System includes
#include <iostream>
#include <cstdlib>
#include <time.h>
#include <vector>
#include <list>
#include <cmath>
#include "boost/unordered_map.hpp"
#include <stdio.h>
#include <unistd.h>
#define GetCurrentDir getcwd
#ifdef __APPLE__
#include "CoreFoundation/CoreFoundation.h"
#endif

// Local includes
#include "cinder/app/AppBasic.h"
#include "cinder/gl/gl.h"
#include "cinder/gl/GlslProg.h"
#include "cinder/Ray.h"
//#include "ShRay.h"
#include "cinder/gl/Vbo.h"
#include "cinder/gl/Fbo.h"
#include "cinder/gl/Light.h"
#include "cinder/gl/Material.h"
#include "src/Graphics/ShIsland.h"
#include "src/ShCamera.h"
//#include "kdtree.h"
#include "src/Graphics/ShSeqPath.h"
#include "src/Time/ShSequencer.h"
#include "src/Audio/ShAudioSequence.h"
#include "src/Graphics/ShColor.h"
#include "src/ShIslandGrid.h"
#include "src/Graphics/ShSnake.h"
#include "src/ShSnakePit.h"
#include "src/Graphics/ShAvatar.h"
#include "src/network/ShClient.h"
#include "src/network/ShPacketListener.h"
#include "src/network/ShNetwork.h"
#include "src/ShGlobals.h"
#include "src/ShChat.h"
#include "src/HCI/ShData.h"
#include "src/ArtificialLife/CellularAutomata.h"
#include "src/shmath.h"
#include "src/ArtificialLife/Flocking.h"
#include "src/Time/shtimestream.h"
#include "src/Time/ShScheduler.h"
#include "src/Time/ShTimer.h"
#include "src/Graphics/ShTimeStreamDisplay.h"
#include "src/Script/script.h"
#include "src/Graphics/luaconsole.h"
#include "src/Graphics/synthmenu.h"
#include "src/Graphics/timequakedisplay.h"

#include "sc.h"
#include "Server.h"
#include "Node.h"

#include "src/Graphics/shaders.h"

#ifdef __LINUX__
#include <qapplication.h>
#include "X11/Xlib.h"
#include <GL/gl.h>
#include <GL/glu.h>
#include <cinder/app/AppImplQtBasic.h>
#endif

using namespace ci;
using namespace gl;
using namespace ci::app;

enum EditMode {
    IslandPicking,
    SnakePicking,
    SynthSelection
};

class ShoggothApp : public AppBasic {

public:

    ShoggothApp() : wDown(false), aDown(false), sDown(false), dDown(false), qDown(false), eDown(false), mPickMode(true),
        spaceDown(false), mCamera(Vec3f(500.0f, 500.0f, 500.0f)), mChainEdit(false), testSine(false),
        mActivePath(NULL), tempo(boost::chrono::milliseconds(100)), mSequencer(boost::chrono::milliseconds(100)),
        mRecording(false), mPickedTri(0), mSelectedIsland(0), mCurrentSelectedStepValue(1),mRootTimeStream(0),
        timeStreamScheduler(0), timeStreamTimer(0, boost::chrono::milliseconds(100)), timeStreamDisplay(0),
        editSnakeRange(false), moveSnakeRange(false), synthMenu(0), editMode(IslandPicking), currentSynthName("ShoggothBassDrum"),
        cursorPosition(0, 0) {}
    // gameOfLife(200, 120)
    // flock(0)

    ~ShoggothApp();

    void prepareSettings(Settings *settings);
    void setup();
    void quit();
    void mouseDown(MouseEvent event);
    void mouseUp(MouseEvent event);
    void mouseMove(MouseEvent event);
    void keyDown(KeyEvent event);
    void keyUp(KeyEvent event);
    void resize(ResizeEvent event);

    void update();
    void initRender();
    void finishRender();
    void renderIslands();
    void renderPicking();
    void renderScene();
    void draw();

    bool colorPicking(Vec3f *pickedPoint, Vec3f *pickedNormal, SeqTri *pickedTri);

    void beginSequence();
    void finishSequence();
    void play();
    void stop();

    // NETWORKING
    void beginNetworking();
    void endNetworking();
    void drawAutomata();

    ShIslandGrid islands;
    std::list<ShSeqPath*> seqPaths;

    Vec2f mScreenCenter, direction;
    ShCamera mCamera;
    bool wDown, aDown, sDown, dDown, qDown, eDown, mPickMode,spaceDown, mMouseMove, mDrawPick, mChainEdit;
    ShSeqPath* mActivePath;
#ifdef __APPLE__
    CGPoint mCenterPoint;
#elif __LINUX__
    _XDisplay* display;
    Window rootWindow;
#endif
    sc::Server mServer;
    sc::Synth* testSine;
    ShSequencer mSequencer;
    boost::chrono::milliseconds tempo;
    std::list<ShAudioSequence*> audioSequences;

    gl::Fbo mFbo; // main framebuffer (AA)

    AxisAlignedBox3f mPickBox;
    Vec3f mPickedPoint, mPickedNormal;
    SeqTri* mPickedTri;
    unsigned int mPickedIndex;
    bool mRecording;
    Material stepMaterial;
    ShSnakePit snakePit;
    ShClient mOscClient;
    ShData mData;
    uint8_t mSelectedIsland;
    //alife::cell::GameOfLife gameOfLife;
    alife::cell::WolframCA* ca;
    unsigned int mCurrentSelectedStepValue;
    //alife::Flock* flock;
    ShTimeStream* mRootTimeStream;
    TimeStreamScheduler* timeStreamScheduler;
    ShTimer timeStreamTimer;
    ShTimeStreamDisplay* timeStreamDisplay;
    LuaConsole luaConsole;
    SynthMenu* synthMenu;
    snake_range_id_t targetSnakeRange;
    bool editSnakeRange;
    bool moveSnakeRange;
    EditMode editMode;
    std::string currentSynthName;
    cinder::Vec2i cursorPosition;
    TimeQuakeDisplay timeQuakeDisplay;
};

ShoggothApp::~ShoggothApp()
{
    if(ShNetwork::ONLINE)
    {
        endNetworking();
    }

    if(testSine != NULL)
    {
        delete testSine;
        testSine = NULL;
    }

    for(std::list<ShSeqPath*>::iterator iter = seqPaths.begin(); iter != seqPaths.end(); ++iter)
    {
        delete *iter;
    }

    seqPaths.clear();


    for(std::list<ShAudioSequence*>::iterator iter = audioSequences.begin(); iter != audioSequences.end(); ++iter)
    {
        delete *iter;
    }

    audioSequences.clear();

    if(mPickedTri)
        delete mPickedTri;


    delete timeStreamDisplay;
    delete mRootTimeStream;
    delete timeStreamScheduler;
    delete synthMenu;

    islands.freeWaveTerrainBuffers();

#ifdef __LINUX__
    // XUngrabKeyboard(display, CurrentTime);
    XCloseDisplay(display);
#endif

    //if(flock)
    //    delete flock;
}

void ShoggothApp::prepareSettings(Settings *settings)
{
    float screenX = getDisplay().getWidth();
    float screenY = getDisplay().getHeight();
    settings->setWindowSize(screenX, screenY);
    mScreenCenter = Vec2f(screenX / 2, screenY / 2);

    //mScreenCenter = Vec2f(584, 365);
    //settings->setFullScreen(true);
    settings->setFrameRate(30.0f);
}

void ShoggothApp::setup()
{
    setFullScreen(true);
    // STARTUP SC
    //sc::startup();
    ShGlobals::SCREEN_SIZE = Vec2i(this->getDisplay().getWidth(), this->getDisplay().getHeight());
    ShGlobals::CAMERA = &mCamera;
    ShShaders::loadShaders(this);
#ifdef __APPLE__
    ShGlobals::FONT = cinder::Font(cinder::app::loadResource(TEXT_TEXTURE), 12);
#else
    // ShGlobals::FONT = cinder::Font(cinder::app::loadResource("./resources/OCRAEXT.ttf", 134, "TTF"), 12);
    ShGlobals::FONT = cinder::Font("Ubuntu", 12);
#endif
    hideCursor();
    std::cout << "Screen Center Vec: (" << mScreenCenter.x << ", " << mScreenCenter.y << ")" << std::endl;
#ifdef __APPLE__
    CGSetLocalEventsSuppressionInterval(0);
    //CGEventSourceRef evsrc = CGEventSourceCreate(kCGEventSourceStateCombinedSessionState);
    //CGEventSourceSetLocalEventsSuppressionInterval(evsrc, 0);

    mCenterPoint.x = mScreenCenter.x;
    mCenterPoint.y = mScreenCenter.y;

    CGWarpMouseCursorPosition(mCenterPoint);
#elif __LINUX__
    display = XOpenDisplay(0);
    rootWindow = DefaultRootWindow(display);
    XWarpPointer(display, None, rootWindow, 0, 0, 0, 0, mScreenCenter.x, mScreenCenter.y);
    qApp->setOverrideCursor(QCursor(Qt::BlankCursor));
    // qApp->focusWidget();
    // XGrabKeyboard(display, rootWindow, 1, GrabModeAsync, GrabModeAsync, CurrentTime);
#endif
    direction = Vec2f(0.0f, 0.0f);
    //srand(666);
    mMouseMove = false;
    mPickedTri = new SeqTri();
    mPickedPoint = Vec3f(0, 0, 0);
    mPickedNormal = Vec3f(0, 0, 0);
    mDrawPick = false;
    mPickedIndex = 0;

    stepMaterial.setAmbient(Color(0.75, 0.75, 0.75));
    stepMaterial.setDiffuse(Color(0.75, 0.75, 0.75));
    stepMaterial.setSpecular(Color(0.25, 0.25, 0.25));
    stepMaterial.setShininess(0.5f);
    stepMaterial.setEmission(Color::white());


    ////////////
    // Islands
    ///////////

    islands.setup(mCamera.getEye());

    /////////////
    // Snakes
    /////////////
    /*ShSnake::createMesh();

    for(int i = 0; i < ShIslandGrid::NUM_ISLANDS; ++i)
    {
        //snakes[i] = new ShSnake(islands.getIsland(i));
        snakePit.add(i, new ShSnake(islands.getIsland(i)));
    }

    mSequencer.scheduleSequence(&snakePit);*/
    mSequencer.scheduleSequence(&islands);
    mPickBox = islands.getIsland(0)->mBoundingBox;

    //glClearDepth(1);
    //glEnable(GL_DEPTH_TEST);
    //glEnable(GL_CULL_FACE);
    glEnable(GL_MULTISAMPLE);

#ifdef __APPLE__

    // Change the working directory
    CFBundleRef mainBundle = CFBundleGetMainBundle();
    CFURLRef mainBundleURL = CFBundleCopyBundleURL(mainBundle);
    char cCurrentPath[PATH_MAX];
    if (!CFURLGetFileSystemRepresentation(mainBundleURL, TRUE, (UInt8 *)cCurrentPath, PATH_MAX))
    {
        std::cerr << "ShoggothApp::setup - CURRENT DIRECTORY NOT FOUND." << std::endl;
        return;
    }

    CFRelease(mainBundleURL);
    std::string workingDirectory(cCurrentPath);
    workingDirectory.append("/Contents/MacOS/");
    chdir(workingDirectory.c_str());
#endif

    //std::string resourcePath(workingDirectory);
    //resourcePath.append("../Resources/entropy_resources.cfg");
    //std::string pluginPath(workingDirectory);
    //pluginPath.append("../Resources/plugins.cfg");
    //std::cout << "Current working directory: " << workingDirectory << std::endl;
    //std::cout << "Resources path: " << resourcePath << std::endl;

    //mResourcesCfg = resourcePath.c_str();
    //mPluginsCfg = pluginPath.c_str();
    //sc::ServerOptions serverOptions;

    sc::startup();
    mServer.boot();
    synthMenu = new SynthMenu();
    // Initialize Networking
    ShNetwork::chat->loadTexture(this);
    ShAvatar::createMesh();
    //gameOfLife.runUnitTest();
    //gameOfLife.print();
    //gameOfLife.randomize();
    //ca = new alife::cell::WolframCA(919665559, 5, 4, getWindowWidth());
    //ca = new alife::cell::WolframCA(10790979, 4, 3, getWindowWidth());
    //ca = new alife::cell::WolframCA(9999999999999999999999999, 7, 6, getWindowWidth());
    //ca = new alife::cell::WolframCA(9999999999999999999999999, 6, 5, getWindowWidth());
    //ca = new alife::cell::WolframCA(8076543210987604441098765, 5, 4, getWindowWidth());
    //ca = new alife::cell::WolframCA(8076543210987604441098765, 5, 4, getWindowWidth());
    //ca = new alife::cell::WolframCA(912, 3, 2, getWindowWidth());
    //ca = new alife::cell::WolframCA(110, 2, 1, getWindowWidth());
    //ca = new alife::cell::WolframCA(30, 2, 1, getWindowWidth());

    /* FLOCKING STUFF
    flock = new alife::Flock(geometry::Vec3i(-1000, 0, -1000), geometry::Vec3i(1000, 2000, 1000), false, true);


    for(int i = 0; i < 300; ++i)
    {
        flock->addBoid(geometry::Vec3d(shmath::randomRange(0, 500), shmath::randomRange(0, 500),
                        shmath::randomRange(0, 500)));
    }*/

    //gl::clear(Color::white());

    // Time Stream Management
    mRootTimeStream = new ShTimeStream("0", boost::chrono::steady_clock::time_point(boost::chrono::milliseconds(1000)));
    timeStreamScheduler = new TimeStreamScheduler(mRootTimeStream);
    ShGlobals::TIME_STREAM_SCHEDULER = timeStreamScheduler;
    timeStreamTimer.setScheduler(timeStreamScheduler);
    ShGlobals::TIME_STREAM_TIMER = &timeStreamTimer;
    //timeStreamTimer.start();
    timeStreamDisplay = new ShTimeStreamDisplay();
    targetSnakeRange = std::make_pair(0, 0);
    islands.setSelectedSnakeRange(targetSnakeRange.second);

    luaConsole.updatePosition();
    ShGlobals::LUA_CONSOLE = &luaConsole;
    script::initialize();
    ShGlobals::TIME_QUAKE_DISPLAY = &timeQuakeDisplay;
    mOscClient.start();
}

void ShoggothApp::quit()
{	
    if(timeStreamTimer.getRunning())
    {
        timeStreamTimer.stop();

    }

    if(mSequencer.isPlaying)
    {
        mSequencer.stop();
    }

    // SHUTDOWN SC
    sc::shutdown();

    ShShaders::unbindWireframe();
    ShShaders::unbindPhong();

    mServer.quit();
    // mOscClient.stop();
    cinder::app::AppBasic::quit();
}

void ShoggothApp::keyDown(KeyEvent event)
{	
    if(!ShNetwork::chat->getEditEntry() && !luaConsole.getEditEntry())
    {
        switch(event.getCode())
        {
        case KeyEvent::KEY_w:
            wDown = true;
            break;

        case KeyEvent::KEY_a:
            aDown = true;
            break;

        case KeyEvent::KEY_s:
            sDown = true;
            break;

        case KeyEvent::KEY_d:
            dDown = true;
            break;

        case KeyEvent::KEY_q:
            qDown = true;

            if(event.isControlDown() || event.isMetaDown())
            {
                this->quit();
            }

            break;

        case KeyEvent::KEY_e:
            eDown = true;
            break;

        case KeyEvent::KEY_SPACE:
            //spaceDown = true;
            //pickIslands = !pickIslands;

            if(editMode == IslandPicking)
            {
                editMode = SnakePicking;
            }

            else
            {
                editMode = IslandPicking;
            }

            break;

        case KeyEvent::KEY_f:
            mPickMode = !mPickMode;
            break;

        case KeyEvent::KEY_p: // Play the sequencer if it isn't playing, otherwise stop it
            if(!mSequencer.isPlaying)
                play();
            else
                stop();
            break;

        case KeyEvent::KEY_o:
            // finishSequence();
            break;

        case KeyEvent::KEY_UP:

            if(!ShNetwork::ONLINE)
            {
                tempo = mSequencer.getStepQuant() - boost::chrono::milliseconds(15);
                mSequencer.setStepQuant(tempo);
                // ShGlobals::TIME_STREAM_SCHEDULER->addTimeEvent(new TempoEvent(tempo, ShGlobals::TIME_STREAM_TIMER->getTime()));
            }

            else
            {
                ShNetwork::sendSetTempo((mSequencer.getStepQuant() - boost::chrono::milliseconds(15)).count());
            }

            break;

        case KeyEvent::KEY_DOWN:

            if(!ShNetwork::ONLINE)
            {
                tempo = mSequencer.getStepQuant() + boost::chrono::milliseconds(15);
                mSequencer.setStepQuant(tempo);
                // ShGlobals::TIME_STREAM_SCHEDULER->addTimeEvent(new TempoEvent(tempo, ShGlobals::TIME_STREAM_TIMER->getTime()));
            }

            else
            {
                ShNetwork::sendSetTempo((mSequencer.getStepQuant() + boost::chrono::milliseconds(15)).count());
            }

            break;

        case KeyEvent::KEY_r:
            if(!mRecording)
            {
                mServer.record();
                mRecording = true;
            }

            else
            {
                mServer.stopRecording();
                mRecording = false;
            }

            break;

        case KeyEvent::KEY_l:

            if(ShNetwork::ONLINE)
            {
                endNetworking();
            }

            else
            {
                beginNetworking();
            }

            break;

        case KeyEvent::KEY_t:
            ShNetwork::chat->beginEditEntry();
            break;

        case KeyEvent::KEY_c:
            luaConsole.beginEditEntry();
            break;

        case KeyEvent::KEY_1:

            srand(time(0) + shmath::randomRange(0, 255));

            if(event.isShiftDown() || event.isControlDown()) // If shift down, height map generation
            {
                std::cout << "SHIFT DOWN!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!" << std::endl;

                if(ShNetwork::ONLINE)
                    ShNetwork::sendTerrainHeights(mSelectedIsland, ShNetwork::DiamondSquare, shmath::randomRange(0, 255));
                else
                    islands.diamondSquareHeights(mSelectedIsland, shmath::randomRange(0, 255));
            }

            else // Else Step generation
            {
                if(mPickMode)
                {
                    if(ShNetwork::ONLINE)
                        ShNetwork::sendTerrainSteps(mSelectedIsland, ShNetwork::DiamondSquare, shmath::randomRange(0, 255));
                    else
                        islands.diamondSquareSteps(mSelectedIsland, shmath::randomRange(0, 255));
                }
            }

            break;

        case KeyEvent::KEY_2:

            srand(time(0) + shmath::randomRange(0, 255));

            if(event.isShiftDown() || event.isControlDown()) // If shift down, height map generation
            {
                if(ShNetwork::ONLINE)
                    ShNetwork::sendTerrainHeights(mSelectedIsland, ShNetwork::Wolfram, shmath::randomRange(0, 255));
                else
                    islands.wolframHeights(mSelectedIsland, shmath::randomRange(0, 255));
            }

            else // Else Step generation
            {
                if(mPickMode)
                {
                    if(ShNetwork::ONLINE)
                        ShNetwork::sendTerrainSteps(mSelectedIsland, ShNetwork::Wolfram, shmath::randomRange(0, 255));
                    else
                        islands.wolframCASteps(mSelectedIsland, shmath::randomRange(0, 255));

                    //if(ShNetwork::ONLINE)
                    //ShNetwork::sendTerrainSteps(mSelectedIsland, ShNetwork::GameOfLife, shmath::randomRange(0, 255));
                    //else
                    //islands.gameOfLife(mSelectedIsland);
                }
            }

            break;

        case KeyEvent::KEY_3:

            srand(time(0) + shmath::randomRange(0, 255));

            if(event.isShiftDown() || event.isControlDown()) // If shift down, height map generation
            {
                if(ShNetwork::ONLINE)
                    ShNetwork::sendTerrainHeights(mSelectedIsland, ShNetwork::StrangeAttractor,
                                                  shmath::randomRange(0, 255));
                else
                    islands.strangeHeights(mSelectedIsland, shmath::randomRange(0, 255));
            }

            else // Else Step generation
            {
                if(mPickMode)
                {
                    if(ShNetwork::ONLINE)
                        ShNetwork::sendTerrainSteps(mSelectedIsland, ShNetwork::StrangeAttractor,
                                                    shmath::randomRange(0, 255));
                    else
                        islands.strangeSteps(mSelectedIsland, shmath::randomRange(0, 255));
                }
            }

            break;

        case KeyEvent::KEY_4:

            srand(time(0) + shmath::randomRange(0, 255));

            if(event.isShiftDown() || event.isControlDown()) // If shift down, height map generation
            {
                if(ShNetwork::ONLINE)
                    ShNetwork::sendTerrainHeights(mSelectedIsland, ShNetwork::LSystem,
                                                  shmath::randomRange(0, 255));
                else
                    islands.lSystemHeights(mSelectedIsland, shmath::randomRange(0, 255));
            }

            else // Else Step generation
            {
                if(mPickMode)
                {
                    if(ShNetwork::ONLINE)
                        ShNetwork::sendTerrainSteps(mSelectedIsland, ShNetwork::LSystem, shmath::randomRange(0, 255));
                    else
                        islands.lSystemSteps(mSelectedIsland, shmath::randomRange(0, 255));
                }
            }

            break;

        case KeyEvent::KEY_5:

            srand(time(0) + shmath::randomRange(0, 255));

            if(event.isShiftDown() || event.isControlDown()) // If shift down, height map generation
            {
                if(ShNetwork::ONLINE)
                    ShNetwork::sendTerrainHeights(mSelectedIsland, ShNetwork::Flocking,
                                                  shmath::randomRange(0, 255));
                else
                    islands.flockingHeights(mSelectedIsland, shmath::randomRange(0, 255));
            }

            else // Else Step generation
            {
                if(mPickMode)
                {
                    if(ShNetwork::ONLINE)
                        ShNetwork::sendTerrainSteps(mSelectedIsland, ShNetwork::Flocking, shmath::randomRange(0, 255));
                    else
                        islands.flockingSteps(mSelectedIsland, shmath::randomRange(0, 255));
                }
            }

            break;

        case KeyEvent::KEY_0:

            if(event.isShiftDown() || event.isAltDown()) // If shift down, height map generation
            {
                if(ShNetwork::ONLINE)
                    ShNetwork::sendTerrainHeights(mSelectedIsland, ShNetwork::Empty, 0);
                else
                    islands.emptyHeights(mSelectedIsland);
            }

            else // Else Step generation
            {
                if(mPickMode)
                {
                    if(ShNetwork::ONLINE)
                        ShNetwork::sendTerrainSteps(mSelectedIsland, ShNetwork::Empty, 0);
                    else
                        islands.emptySteps(mSelectedIsland);
                }
            }

            break;

        case KeyEvent::KEY_DELETE:
            if(editMode == SnakePicking)
                islands.removeCurrentlySelectedSnakeRange();
            break;

        case KeyEvent::KEY_x:

            if(event.isMetaDown() || event.isControlDown())
                islands.removeCurrentlySelectedSnakeRange();

            break;
        }
    }

    else if(ShNetwork::chat->getEditEntry())
    {
        if(event.getCode() == KeyEvent::KEY_RETURN)
            ShNetwork::chat->finishEditEntry();

        else if(event.getCode() == KeyEvent::KEY_DELETE || event.getCode() == KeyEvent::KEY_BACKSPACE)
            ShNetwork::chat->backspaceMessageEntry();

        else
            ShNetwork::chat->addMessageEntry(event.getChar());
    }

    else
    {
        if(event.getCode() == KeyEvent::KEY_RETURN)
            luaConsole.finishEditEntry();

        else if(event.getCode() == KeyEvent::KEY_DELETE || event.getCode() == KeyEvent::KEY_BACKSPACE)
            luaConsole.backspaceConsoleEntry();
        else
            luaConsole.addConsoleEntry(event.getChar());
    }

    //gameOfLife.update();
    mData.queueKeyStore(event, ShData::Pressed);
    /*
    std::cout << "KeyDown Number: " << event.getCode()
              << std::endl << "is accel Down" << event.isAccelDown() << std::endl
              << std::endl << "is alt Down" << event.isAltDown() << std::endl
              << std::endl << "is control Down" << event.isControlDown() << std::endl
              << std::endl << "is meta Down" << event.isMetaDown() << std::endl
              << std::endl << "is shift Down" << event.isShiftDown() << std::endl;*/
}

void ShoggothApp::keyUp(KeyEvent event)
{
    switch(event.getCode())
    {
    case KeyEvent::KEY_w:
        wDown = false;
        break;

    case KeyEvent::KEY_a:
        aDown = false;
        break;

    case KeyEvent::KEY_s:
        sDown = false;
        break;

    case KeyEvent::KEY_d:
        dDown = false;
        break;

    case KeyEvent::KEY_q:
        qDown = false;
        break;

    case KeyEvent::KEY_e:
        eDown = false;
        break;

    case KeyEvent::KEY_SPACE:
        //spaceDown = false;
        break;
    }

    mData.queueKeyStore(event, ShData::Released);
}

void ShoggothApp::resize(ResizeEvent event)
{
    mCamera.setup(event.getAspectRatio());

    // create / resize framebuffer
    if(!mFbo || mFbo.getWidth() != event.getWidth() || mFbo.getHeight() != event.getHeight())
    {
        gl::Fbo::Format fmt;
        fmt.enableColorBuffer(true, 1);
        fmt.setSamples(0);
        fmt.setCoverageSamples(0);
        fmt.enableMipmapping(false);
        mFbo = gl::Fbo(event.getWidth(), event.getHeight(), fmt);
    }
}

void ShoggothApp::mouseDown(MouseEvent event)
{
    if(mPickMode)
    {
        if(editMode == IslandPicking)
        {
            if(event.isLeft())
            {
                //cinder::Vec2i coord = ShIsland::vertexToCoord(mPickedIndex);
                cinder::Vec2i coord = mPickedTri->getMapCoord();

                if(!editSnakeRange && !moveSnakeRange)
                {
                    targetSnakeRange = islands.addShSnakeRange(
                                mSelectedIsland,
                                currentSynthName,
                                coord,
                                coord + cinder::Vec2i(2, 2),
                                true,
                                ShNetwork::ONLINE
                    );

                    editSnakeRange = true;
                    moveSnakeRange = false;
                }

                else if(editSnakeRange)
                {
                    islands.setSnakeRangeCorner(targetSnakeRange, coord, true, true);
                    editSnakeRange = false;
                    moveSnakeRange = false;
                }

                else if(moveSnakeRange)
                {
                    islands.setSnakeRangePosition(targetSnakeRange, coord, true, true);
                    moveSnakeRange = false;
                    editSnakeRange = false;
                }
            }

            else if(!editSnakeRange && !moveSnakeRange)
            {
                editMode = SynthSelection;
                cursorPosition = ShGlobals::SCREEN_SIZE / 2;
            }

            else
            {
                editSnakeRange = false;
                moveSnakeRange = false;
            }
        }

        else if(editMode == SnakePicking)
        {
            if(event.isRight())
            {
                if(islands.getNumSnakeRanges() > 0)
                {
                    editSnakeRange = true;
                    targetSnakeRange = islands.getCurrentlySelectedSnakeRangeID();
                }

                else
                {
                    editSnakeRange = false;
                }

                moveSnakeRange = false;
                editMode = IslandPicking;
            }

            else if(event.isLeft())
            {
                if(islands.getNumSnakeRanges() > 0)
                {
                    moveSnakeRange = true;
                    targetSnakeRange = islands.getCurrentlySelectedSnakeRangeID();
                }

                else
                {
                    moveSnakeRange = false;
                }

                editSnakeRange = false;
                editMode = IslandPicking;
            }
        }

        else if(editMode == SynthSelection)
        {
            if(event.isLeft())
            {
                currentSynthName = synthMenu->getCurrentlySelectedSynth();
            }
#ifdef __APPLE__
            CGWarpMouseCursorPosition(mCenterPoint);
#elif __LINUX__
            XSelectInput(display, rootWindow, KeyReleaseMask);
            XWarpPointer(display, None, rootWindow, 0, 0, 0, 0, mScreenCenter.x, mScreenCenter.y);
            XFlush(display);
#endif
            editMode = IslandPicking;
        }


        /*
        islands.getIsland(mSelectedIsland)->toggleValue(coord.x % ShIsland::kTriangleGridWidth,
                                                     coord.y % ShIsland::kTriangleGridHeight);
        islands.getIsland(mSelectedIsland)->bufferActivityColor();
        */
    }

    if(event.isLeft())
        mData.queueMouseButtonStore(ShData::Left, ShData::Down);
    else
        mData.queueMouseButtonStore(ShData::Right, ShData::Down);

    //flock->addBoid(geometry::Vec3d(event.getX(), event.getY(), 0));
}

void ShoggothApp::mouseUp(MouseEvent event)
{
    if(event.isLeft())
        mData.queueMouseButtonStore(ShData::Left, ShData::Up);
    else
        mData.queueMouseButtonStore(ShData::Right, ShData::Up);
}

void ShoggothApp::mouseMove(MouseEvent event)
{
    //CGEventSourceRef evsrc = CGEventSourceCreate(kCGEventSourceStateCombinedSessionState);
    //CGEventSourceSetLocalEventsSuppressionInterval(evsrc, 0);
    // Get a vector represent the direction we are moving the mouse towards
    //std::cout << "Mouse Center Vec: (" << event.getX() << ", " << event.getY() << ")" << std::endl;

    if(editMode == SynthSelection)
    {
        synthMenu->checkMouseCoordinates(event.getPos());
        cursorPosition = event.getPos();
    }

    else
    {
        mCamera.mouseInput(event.getPos() - mScreenCenter);
        // reposition the mouse in the center of the screen so we don't have to deal with screen clipping of mouse coordinates
#ifdef __APPLE__
        CGWarpMouseCursorPosition(mCenterPoint);
        //CGDisplayMoveCursorToPoint(mCenterPoint);
#elif __LINUX__
        XSelectInput(display, rootWindow, KeyReleaseMask);
        XWarpPointer(display, None, rootWindow, 0, 0, 0, 0, mScreenCenter.x, mScreenCenter.y);
        XFlush(display);
#endif
        mMouseMove = true;
        //CFRelease(evsrc);
        if(ShNetwork::ONLINE)
            ShNetwork::sendRotateAvatar(mCamera.getCam().getOrientation());
    }

    mData.queueMouseMoveStore(event.getPos());
}

void ShoggothApp::update()
{
    //gl::pushProjection(mCamera.getCam());
    mCamera.keyboardInput(wDown, aDown, sDown, dDown, qDown, eDown, spaceDown);
    mCamera.update();

    islands.update();

    if(wDown || aDown || sDown || dDown) // If the camera has moved, recalculate the distance of the islands for LOD
    {
        Vec3f cameraPos = mCamera.getEye();

        if(ShNetwork::ONLINE)
            ShNetwork::sendMoveAvatar(cameraPos);

    }

    if(qDown || eDown)
    {
        if(ShNetwork::ONLINE)
            ShNetwork::sendRotateAvatar(mCamera.getCam().getOrientation());
    }

    if(mPickMode)
    {
        if(aDown || dDown || mMouseMove)
        {
            mMouseMove = false;
        }
    }

    ShNetwork::chat->update();
    ShAvatar::avatarMap.update();

    if(editSnakeRange)
    {
        islands.setSnakeRangeCorner(targetSnakeRange, mPickedTri->getMapCoord());
    }

    else if(moveSnakeRange)
    {
        islands.setSnakeRangePosition(targetSnakeRange, mPickedTri->getMapCoord());
    }

    ShNetwork::sendSCStatusRequest();

    /*
    flock->run();
    cinder::Vec3f target = mCamera.getEye() + (mCamera.getCam().getViewDirection() * 2000);

    if(spaceDown)
        flock->seek(geometry::Vec3d(target.x, target.y, target.z));*/
}

void ShoggothApp::initRender()
{
    gl::clear(Color(1, 1, 1));

    gl::pushMatrices();
    gl::setMatrices(mCamera.getCam());

    gl::Light light(gl::Light::SPOTLIGHT, 0);
#ifdef __APPLE__
    /*
    light.setAmbient(Color(0.9f, 0.9f, 0.9f));
    light.setDiffuse(Color::white());
    light.setSpecular(Color::white());*/
    light.setAmbient(Color(0.5f, 0.5f, 0.5f));
    light.setDiffuse(Color(0.8, 0.8, 0.8));
    light.setSpecular(Color(0.9, 0.9, 0.9));
#elif __LINUX__
    light.setAmbient(Color(0.5, 0.5f, 0.5f));
    light.setDiffuse(Color(0.8, 0.8, 0.8));
    light.setSpecular(Color(0.9, 0.9, 0.9));
#endif
    light.setPosition(mCamera.getCam().getEyePoint());
    light.setDirection(mCamera.getCam().getViewDirection());
    // light.setPosition(Vec3f(500.0f, 500.0f, 500.0f));

    glPushAttrib(GL_CURRENT_BIT | GL_ENABLE_BIT | GL_DEPTH_BUFFER_BIT);
    gl::enableDepthRead();
    gl::enableDepthWrite();
}

void ShoggothApp::finishRender()
{
    glPopAttrib();
    gl::popMatrices();
}

void ShoggothApp::renderIslands()
{
    islands.drawIslands();
}

void ShoggothApp::renderPicking()
{
    ShShaders::bindPicking();

    gl::clear(Color::black());

    if(editMode == IslandPicking)
        renderIslands();
    else if(editMode == SnakePicking)
        islands.drawSnakeRanges(false);

    ShShaders::unbindPicking();
}

void ShoggothApp::renderScene()
{
    ShShaders::bindPhong();

    ShIsland::material.apply();
    renderIslands();
    islands.drawSnakeRanges(true);

    if(editMode == SnakePicking)
        islands.drawSnakeRangeHilight();

    if(ShNetwork::ONLINE)
        ShAvatar::avatarMap.draw();

    stepMaterial.apply();


    if(mDrawPick && editMode == IslandPicking) // Draw Picking Triangle
    {
        gl::color(Color(1, 0, 0));

        // Draw Picked Triangle

        glBegin(GL_TRIANGLES);
        glVertex3f(mPickedTri->v0().x, mPickedTri->v0().y + 2, mPickedTri->v0().z);
        glVertex3f(mPickedTri->v1().x, mPickedTri->v1().y + 2, mPickedTri->v1().z);
        glVertex3f(mPickedTri->v2().x, mPickedTri->v2().y + 2, mPickedTri->v2().z);
        glEnd();

        gl::color(Color(0, 0, 0));
        islands.drawBoundingBox(mSelectedIsland);
    }

    //snakePit.draw();

    //ShShaders::bindWireframe();

    /*
    for(std::list<ShSeqPath*>::iterator iter = seqPaths.begin(); iter != seqPaths.end(); ++iter)
    {
        if(*iter != NULL)
        {
            (*iter)->draw();
        }
    }*/

    //if(mDrawPick) // Draw Picking Triangle
    //    mPickedTri->draw();

    //ShShaders::unbindWireframe();
    ShShaders::unbindPhong();
}

void ShoggothApp::draw()
{	

    // render scene with individual colors for 3d picking
    if(mPickMode)
    {
        mFbo.bindFramebuffer();
        initRender();
        renderPicking();
        finishRender();
        mDrawPick = colorPicking(&mPickedPoint, &mPickedNormal, mPickedTri);
        mFbo.unbindFramebuffer();
    }

    initRender();
    renderScene();
    // cinder::gl::color(cinder::Color(0, 0, 255));
    // cinder::gl::drawSphere(mCamera.frustumSphere.getCenter(), mCamera.frustumSphere.getRadius());

    gl::color(cinder::ColorA(0, 0, 0, 1));


    /*
    const std::vector<alife::Boid*> boids = flock->getBoids();

    for(int i = 0; i < boids.size(); ++i)
    {
        geometry::Vec3d location = boids[i]->getLocation();
        gl::drawSphere(cinder::Vec3f(location.x, location.y, location.z), 3);
    }*/

    finishRender();
    cinder::gl::enableAlphaBlending();
    islands.drawSnakeRangNames();
    ShAvatar::avatarMap.drawName();
    ShNetwork::chat->draw();
    serverpanel::draw();
    // luaConsole.draw();
    // timeStreamDisplay->draw();

    if(editMode == SynthSelection)
    {
        synthMenu->draw();
        gl::color(ColorA(1, 0, 0));
        cinder::Rectf cursorRect(-2, -2, 2, 2);
        cursorRect.offset(cursorPosition);
        cinder::gl::drawSolidRect(cursorRect);
    }

    else if(editMode == SnakePicking)
    {
        gl::color(ColorA(1, 0, 0));
        //cinder::gl::drawSolidCircle(cinder::Vec2i(ShGlobals::SCREEN_SIZE.x / 2 - 5, ShGlobals::SCREEN_SIZE.y / 2), 1);
        cinder::gl::drawStrokedCircle(cinder::Vec2i(ShGlobals::SCREEN_SIZE.x / 2 - 5, ShGlobals::SCREEN_SIZE.y / 2), 2);

        /*
        glBegin(GL_LINE_LOOP);
        glVertex3f(ShGlobals::SCREEN_SIZE.x / 2 - 5, ShGlobals::SCREEN_SIZE.y / 2 - 5, 0);
        glVertex3f(ShGlobals::SCREEN_SIZE.x / 2 + 5, ShGlobals::SCREEN_SIZE.y / 2 - 5, 0);
        glVertex3f(ShGlobals::SCREEN_SIZE.x / 2 + 5, ShGlobals::SCREEN_SIZE.y / 2 + 5, 0);
        glVertex3f(ShGlobals::SCREEN_SIZE.x / 2 - 5, ShGlobals::SCREEN_SIZE.y / 2 + 5, 0);
        glEnd();*/
    }

    // timeQuakeDisplay.draw();

    //cinder::gl::disableAlphaBlending();
    //drawAutomata();
}

bool ShoggothApp::colorPicking(Vec3f *pickedPoint, Vec3f *pickedNormal, SeqTri *pickedTri)
{
    if(!mFbo)
    {
        std::cerr << "Error. No Fbo for picking." << std::endl;
        return false;
    }

    GLubyte buffer[4];
    glReadBuffer(GL_COLOR_ATTACHMENT0_EXT);
    glReadPixels(mScreenCenter.x, mScreenCenter.y, 1, 1, GL_RGBA, GL_UNSIGNED_BYTE, (void*)buffer);

    mPickedIndex = shcolor::charToInt(buffer[0], buffer[1], buffer[2]);

    if(editMode == IslandPicking)
    {
        mSelectedIsland = ShIsland::pickingIndexToIslandID(mPickedIndex);

        return islands.getIsland(mSelectedIsland)->getTriCoord(
                    mPickedIndex - (mSelectedIsland * ShIsland::kNumIndexes),
                    pickedTri
                    );
    }

    else
    {
        islands.setSelectedSnakeRange(mPickedIndex);
        return true;
    }
}

void ShoggothApp::beginSequence()
{

}

void ShoggothApp::finishSequence()
{
    ShAudioSequence* sequence = new ShAudioSequence("ShoggothPerc", seqPaths.back()->eventSet);
    audioSequences.push_back(sequence);
    //audioSequences.push_back(seqPaths.back()); ShSeqPath sequencing NOT IMPLEMENTED YET
    mSequencer.scheduleSequence(audioSequences.back());
    mChainEdit = false;
}

void ShoggothApp::play()
{
    if(ShNetwork::ONLINE)
    {
        ShNetwork::sendStartSequencing();
    }

    else
    {
        mSequencer.play();
        // timeQuakeDisplay.startThreading();
    }
}

void ShoggothApp::stop()
{
    if(ShNetwork::ONLINE)
        ShNetwork::sendEndSequencing();

    else
        mSequencer.stop();

    // timeQuakeDisplay.stopThreading();
}

void ShoggothApp::beginNetworking()
{
    ShNetwork::ONLINE = true;
    islands.removeAllSnakeRanges(); // Cleanup before logging in
    ShNetwork::sendLogin();
}

void ShoggothApp::endNetworking()
{
    ShNetwork::sendLogout();
    ShAvatar::avatarMap.clear();
    ShNetwork::ONLINE = false;
}

void ShoggothApp::drawAutomata()
{
    /* UNCOMMENT FOR GAME OF LIFE DRAWING
    gl::clear(Color::white());
    glPushMatrix();
    glTranslatef(40, 25, 0);
    gl::color(Color(0, 0, 0));

    for(int y = 0; y < gameOfLife.height; ++y)
    {
        for(int x = 0; x < gameOfLife.width; ++x)
        {
            if(gameOfLife(x, y) == 1)
            {
                glPushMatrix();
                glTranslatef(x * 6, y * 6, 0);

                glBegin(GL_POLYGON);
                glVertex2i(0, 0);
                glVertex2i(6, 0);
                glVertex2i(6, 6);
                glVertex2i(0, 6);
                glEnd();

                glPopMatrix();

            }
        }
    }

    for(int y = 0; y <= gameOfLife.height; ++y)
    {
        glBegin(GL_LINE_STRIP);
        glVertex2i(0, y * 6);
        glVertex2i(gameOfLife.width * 6, y * 6);
        glEnd();
    }

    for(int x = 0; x <= gameOfLife.width; ++x)
    {
        glBegin(GL_LINE_STRIP);
        glVertex2i(x * 6, 0);
        glVertex2i(x * 6, gameOfLife.height * 6);
        glEnd();
    }

    glPopMatrix();
    */

    std::vector<unsigned int> currentGeneration(ca->getCurrentState());
    unsigned int possibleStates = ca->getPossibleStates();

    gl::color(Color(0, 0, 0));

    for(int i = 0; i < currentGeneration.size(); ++i)
    {
        unsigned int state = currentGeneration[i];
        if(state > 0)
        {
            if(possibleStates > 2)
            {
                double shade = 1 - (state / ((double) possibleStates - 1));
                gl::color(Color(shade, shade, shade));
            }

            glBegin(GL_POINTS);
            glVertex2i(i, ca->iteration);
            glEnd();
        }
    }

    ca->advance();
}

CINDER_APP_BASIC( ShoggothApp, RendererGl )

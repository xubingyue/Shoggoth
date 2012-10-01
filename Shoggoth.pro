#---------------------------------------------------------------------------------------------------------------
#    Shoggoth, A multiplayer rhythm summoning program
#    Chad McKinney, 2012
#
#    Licensed under GNU GPL 3.0
#    See COPYING for licensing details
#---------------------------------------------------------------------------------------------------------------

QT     -= core gui opengl
TARGET = Shoggoth

###########################################################################################################################
# libsc++ variables CHANGE THESE TO THE CORRECT PATHS AND VERSIONS
###########################################################################################################################

LIBSCPP_SOURCE = /Users/curtismckinney/Documents/C++Dev/SC++
# Currently these should be from SC version 3.5.0
SUPERCOLLIDER_SOURCE = /Users/curtismckinney/Documents/SuperColliderSource/SuperCollider-Source-3.5
LIBSCSYNTH = /Users/curtismckinney/Documents/SuperColliderSource/SuperCollider-Source-3.5/build/server/scsynth/Release
LIBSCLANG = /Users/curtismckinney/Documents/SuperColliderSource/SuperCollider-Source-3.5/build/lang/Release
# Currently this MUST be boost 1.49
BOOST = /usr/local/boost_1_49_0
BOOST_LIBS = /usr/local/boost_1_49_0/lib

# Change to your OS version (and make sure its there!)
QMAKE_MAC_SDK = /Developer/SDKs/MacOSX10.6.sdk

# currently 64bit. If you want i386 you will need to build above libraries yourself for i386 first
CONFIG += x86_64

# Bugfix hack for Qt 4.7+ and Boost 1.48+ BOOST_JOIN bug
#QT_INSTALL_BINS = /Users/curtismckinney/QtSDK/Desktop/Qt/4.8.0/gcc/bin
#QMAKE_MOC = $${QT_INSTALL_BINS}/moc -DBOOST_TT_HAS_OPERATOR_HPP_INCLUDED

###########################################################################################################################


###########################################################################################################################
# Cinder path variable CHANGE THIS TO THE CORRECT PATHS
###########################################################################################################################

# Point to your cinder folder so that we know where everything is
CINDER_HOME = /Users/curtismckinney/Documents/Cinder/cinder_0.8.3_mac

############################################################################################################################


############################################################################################################################
# Simple Lua Binder CHANGE THESE TO THE CORRECT PATHS
############################################################################################################################

SLBINCLUDE = /Users/curtismckinney/Documents/source/SimpleLuaBind/slb/include
SLBLIBS = /Users/curtismckinney/Documents/source/SimpleLuaBind/slb/build/bin/static/

############################################################################################################################

QMAKE_LFLAGS += -F/System/Library/Frameworks/Accelerate.framework
QMAKE_LFLAGS += -F/System/Library/Frameworks/QTKit.framework
QMAKE_LFLAGS += -F/System/Library/Frameworks/CoreAudio.framework
QMAKE_LFLAGS += -F/System/Library/Frameworks/CoreVideo.framework
#QMAKE_LFLAGS += -F/System/Library/Frameworks/QuickTime.framework
QMAKE_LFLAGS += -F/System/Library/Frameworks/AudioUnit.framework
QMAKE_LFLAGS += -F/System/Library/Frameworks/OpenGL.framework
QMAKE_LFLAGS += -F/System/Library/Frameworks/AudioToolBox.framework
QMAKE_LFLAGS += -F/System/Library/Frameworks/ApplicationServices.framework
#QMAKE_LFLAGS += -F/System/Library/Frameworks/Carbon.framework
QMAKE_LFLAGS += -F/System/Library/Frameworks/Cocoa.framework
QMAKE_LFLAGS += -F/System/Library/Frameworks/AppKit.framework
QMAKE_LFLAGS += -F/System/Library/Frameworks/CoreData.framework
QMAKE_LFLAGS += -F/System/Library/Frameworks/Foundation.framework

INCLUDEPATH += $${CINDER_HOME}/include
INCLUDEPATH += $${CINDER_HOME}/lib
INCLUDEPATH += $${CINDER_HOME}/lib/macosx
#INCLUDEPATH += $${CINDER_HOME}/boost
#INCLUDEPATH += $${CINDER_HOME}/boost/boost
#INCLUDEPATH += $${CINDER_HOME}/blocks/msaFluid/include
#INCLUDEPATH += $${CINDER_HOME}/blocks/opencv/include
#INCLUDEPATH += $${CINDER_HOME}/blocks/osc/include
#INCLUDEPATH += $${CINDER_HOME}/blocks/tuio/include
#INCLUDEPATH += $${CINDER_HOME}/blocks/osc/lib/macosx
INCLUDEPATH += $${SLBINCLUDE}

LIBS += -framework Accelerate
LIBS += -framework QTKit
LIBS += -framework CoreAudio
LIBS += -framework CoreVideo
#LIBS += -framework QuickTime
LIBS += -framework AudioUnit
LIBS += -framework OpenGL
LIBS += -framework AudioToolbox
LIBS += -framework ApplicationServices
#LIBS += -framework Carbon
LIBS += -framework Cocoa
LIBS += -framework AppKit
LIBS += -framework CoreData
LIBS += -framework Foundation

# CINDER LIBS
#LIBS += $${CINDER_HOME}/blocks/osc/lib/macosx/osc.a
#LIBS += $${CINDER_HOME}/lib/libcinder_d.a
LIBS += $${CINDER_HOME}/lib/libcinder.a
LIBS += $${CINDER_HOME}/lib/macosx/libz.a
LIBS += $${CINDER_HOME}/lib/macosx/libpng14.a
LIBS += $${CINDER_HOME}/lib/macosx/libpixman-1.a
LIBS += $${CINDER_HOME}/lib/macosx/libcairo.a
LIBS += $${CINDER_HOME}/lib/macosx/libboost_thread.a
LIBS += $${CINDER_HOME}/lib/macosx/libboost_system.a
LIBS += $${CINDER_HOME}/lib/macosx/libboost_filesystem.a
LIBS += $${CINDER_HOME}/lib/macosx/libboost_date_time.a
#LIBS += $${CINDER_HOME}/blocks/opencv/lib/macosx/libcv.a
#LIBS += $${CINDER_HOME}/blocks/opencv/lib/macosx/libcxcore.a

# Simpla Lua Binder
LIBS += $${SLBLIBS}/libSLB.a

PRE_TARGETDEPS += $${CINDER_HOME}/lib/libcinder.a \
    #$${CINDER_HOME}/lib/libcinder_d.a \
    #$${CINDER_HOME}/blocks/osc/lib/macosx/osc.a \
    $${CINDER_HOME}/lib/macosx/libz.a \
    $${CINDER_HOME}/lib/macosx/libpng14.a \
    $${CINDER_HOME}/lib/macosx/libpixman-1.a \
    #$${CINDER_HOME}/lib/macosx/libcairo.a \
    $${CINDER_HOME}/lib/macosx/libboost_thread.a \
    $${CINDER_HOME}/lib/macosx/libboost_system.a \
    $${CINDER_HOME}/lib/macosx/libboost_filesystem.a \
    $${CINDER_HOME}/lib/macosx/libboost_date_time.a \
    #$${CINDER_HOME}/blocks/opencv/lib/macosx/libcv.a \
    #$${CINDER_HOME}/blocks/opencv/lib/macosx/libcxcore.a

DEPENDPATH += $${CINDER_HOME}/lib \
    $${CINDER_HOME}/lib/macosx \
    #$${CINDER_HOME}/blocks/opencv/lib/macosx/ \
    #$${CINDER_HOME}/blocks/osc/lib/macosx \


mac {
    CONFIG += app_bundle
    ICON = resources/ShoggothApp.icns

    SHADER_FILES.files += shaders/phong_frag.glsl \
                            shaders/phong_vert.glsl \
                            shaders/picking_frag.glsl \
                            shaders/picking_vert.glsl \
                            shaders/wireframe_frag.glsl \
                            shaders/wireframe_vert.glsl
    SHADER_FILES.path = Contents/Resources
    QMAKE_BUNDLE_DATA += SHADER_FILES

    SYNTH_LIST.files += resources/Synths.shog
    SYNTH_LIST.path += Contents/Resources
    QMAKE_BUNDLE_DATA += SYNTH_LIST

    LIBSC_DYLIB.files += $${LIBSCSYNTH}/libscsynth.dylib
    LIBSC_DYLIB.path = Contents/Frameworks
    QMAKE_BUNDLE_DATA += LIBSC_DYLIB

    TEXTURE_FILES.files += resources/OCRAEXT.ttf
    TEXTURE_FILES.files += resources/allusedup.ttf
    TEXTURE_FILES.files += resources/sidewalk.ttf
    TEXTURE_FILES.path = Contents/Resources
    QMAKE_BUNDLE_DATA += TEXTURE_FILES

    LOG_FILES.files += resources/LogReadMe.txt
    LOG_FILES.path = ../Logs
    QMAKE_BUNDLE_DATA += LOG_FILES
    #SYNTH_DEFS.files = sc++/synthdefs
    #SYNTH_DEFS.path = Contents/MacOS
    #QMAKE_BUNDLE_DATA += SYNTH_DEFS
    QMAKE_INFO_PLIST = ShoggothInfo.plist
    #QMAKE_POST_LINK = ShoggothLibScript.sh
}

win32 {
    CONFIG += console
}

CONFIG += opengl

TEMPLATE = app

#QMAKE_CFLAGS += -DSC_AUDIO_API=SC_AUDIO_API_AUDIOUNITS
QMAKE_CFLAGS += -D__MACOSX_CORE__
#-lpthread
#QMAKE_CXXFLAGS += -DSC_AUDIO_API=SC_AUDIO_API_AUDIOUNITS
QMAKE_CXXFLAGS += -D__MACOSX_CORE__
CXXFLAGS += -D__MACOSX_CORE__
CXXFLAGS +=-DSC_DARWIN
LIBS += -lpthread

LIBS += -framework CoreAudio
LIBS += -framework CoreServices
LIBS += -framework vecLib
LIBS += -framework CoreFoundation

QMAKE_LFLAGS += -F/System/Library/Frameworks/CoreFoundation.Framework

INCLUDEPATH += oscpack/
DEPENDPATH += oscpack/

SOURCES += oscpack/osc/OscOutboundPacketStream.cpp \
    oscpack/osc/OscPrintReceivedElements.cpp \
    oscpack/osc/OscReceivedElements.cpp \
    oscpack/osc/OscTypes.cpp \
    oscpack/ip/IpEndpointName.cpp \
    oscpack/ip/posix/UdpSocket.cpp \
    oscpack/ip/posix/NetworkingUtils.cpp \
    src/ShSnakePit.cpp \
    src/ShoggothApp.cpp \
    src/ShIslandGrid.cpp \
    src/ShCamera.cpp \
    src/Audio/ShAudioSequence.cpp \
    src/Graphics/ShSnake.cpp \
    src/Graphics/ShSeqPath.cpp \
    src/Graphics/ShIsland.cpp \
    src/Graphics/ShDiamondSquare.cpp \
    src/Graphics/shaders.cpp \
    src/Time/ShTimer.cpp \
    src/Time/ShSequencer.cpp \
    src/Time/ShScheduler.cpp \
    src/network/ShPacketListener.cpp \
    src/network/ShClient.cpp \
    src/network/ShNetwork.cpp \
    src/ShGlobals.cpp \
    src/Graphics/ShAvatar.cpp \
    src/ShChat.cpp \
    libraries/jsoncpp/src/lib_json/json_writer.cpp \
    libraries/jsoncpp/src/lib_json/json_value.cpp \
    libraries/jsoncpp/src/lib_json/json_reader.cpp \
    src/HCI/ShData.cpp \
    src/ArtificialLife/wolframca.cpp \
    src/ArtificialLife/abstractca.cpp \
    src/ArtificialLife/gameoflife.cpp \
    src/network/ShCompress.cpp \
    src/Fractal/Fractal.cpp \
    src/Fractal/Strange.cpp \
    src/Fractal/FractalTypes.cpp \
    src/Math/Array.cpp \
    src/Math/Vector.cpp \
    src/Fractal/LSystem.cpp \
    src/ArtificialLife/Flocking.cpp \
    src/Time/shtimestream.cpp \
    src/Time/ShTimeEvent.cpp \
    src/Script/wrappers.cpp \
    src/Script/script.cpp \
    src/Script/luafunctor.cpp \
    src/Graphics/ShTimeStreamDisplay.cpp \
    src/Graphics/luaconsole.cpp \
    src/Time/shtime.cpp \
    src/Script/ShoggothScript.cpp \
    src/Graphics/ShSnakeRange.cpp \
    src/Graphics/synthmenu.cpp \
    kdtree/kdtree.c \
    src/Graphics/timequakedisplay.cpp


HEADERS += oscpack/osc/OscException.h \
    oscpack/osc/OscHostEndianness.h \
    oscpack/osc/OscOutboundPacketStream.h \
    oscpack/osc/OscPacketListener.h \
    oscpack/osc/OscPrintReceivedElements.h \
    oscpack/osc/OscReceivedElements.h \
    oscpack/osc/OscTypes.h \
    oscpack/ip/UdpSocket.h \
    oscpack/ip/TimerListener.h \
    oscpack/ip/PacketListener.h \
    oscpack/ip/NetworkingUtils.h \
    oscpack/ip/IpEndpointName.h \
    src/Audio/ShAudioSequence.h \
    src/Graphics/ShSnake.h \
    src/Graphics/ShSeqPath.h \
    src/Graphics/ShIsland.h \
    src/Graphics/ShDiamondSquare.h \
    src/Graphics/ShColor.h \
    src/Graphics/shaders.h \
    src/ShSnakePit.h \
    src/shmath.h \
    src/ShIslandGrid.h \
    src/ShGlobals.h \
    src/ShCamera.h \
    src/ShAbstractSequence.h \
    src/Resources.h \
    src/Time/ShTimer.h \
    src/Time/ShSequencer.h \
    src/Time/ShScheduler.h \
    src/network/ShPacketListener.h \
    src/network/ShClient.h \
    src/network/ShNetwork.h \
    src/Graphics/ShAvatar.h \
    src/ShChat.h \
    libraries/jsoncpp/include/json/writer.h \
    libraries/jsoncpp/include/json/value.h \
    libraries/jsoncpp/include/json/reader.h \
    libraries/jsoncpp/include/json/json.h \
    libraries/jsoncpp/include/json/forwards.h \
    libraries/jsoncpp/include/json/features.h \
    libraries/jsoncpp/include/json/config.h \
    libraries/jsoncpp/include/json/autolink.h \
    libraries/jsoncpp/src/lib_json/json_batchallocator.h \
    src/HCI/ShData.h \
    src/ArtificialLife/CellularAutomata.h \
    src/ArtificialLife/ArtificialLife.h \
    src/ArtificialLife/abstractca.h \
    src/ArtificialLife/wolframca.h \
    src/ArtificialLife/gameoflife.h \
    src/network/ShCompress.h \
    src/Fractal/Fractal.h \
    src/Fractal/Strange.h \
    src/Fractal/FractalTypes.h \
    src/Math/Array.h \
    src/Math/Vector.h \
    src/Fractal/LSystem.h \
    src/ArtificialLife/Flocking.h \
    src/Math/geometry.h \
    src/Time/shtimestream.h \
    src/Time/ShTimeEvent.h \
    src/Script/wrappers.h \
    src/Script/scripttypes.h \
    src/Script/script.h \
    src/Script/luafunctor.h \
    src/Graphics/ShTimeStreamDisplay.h \
    src/Graphics/luaconsole.h \
    src/Time/shtime.h \
    src/Script/ShoggothScript.hpp \
    src/Graphics/ShSnakeRange.h \
    src/Graphics/synthmenu.h \
    kdtree/kdtree.h \
    src/Math/Euler.h \
    src/Graphics/timequakedisplay.h

RESOURCES += \

OTHER_FILES += \
    shaders/wireframe_vert.glsl \
    shaders/wireframe_frag.glsl \
    shaders/picking_vert.glsl \
    shaders/picking_frag.glsl \
    shaders/phong_vert.glsl \
    shaders/phong_frag.glsl

#LIBS += sc++/libscsynth/libscsynthAU.a
#PRE_TARGETDEPS += sc++/libscsynth/libscsynthAU.a

#libSC++
LIBS += $${LIBSCPP_SOURCE}/build/release/libSC++.a
PRE_TARGETDEPS += $${LIBSCPP_SOURCE}/build/release/libSC++.a

#libscsynth.dylib
LIBS += $${LIBSCSYNTH}/libscsynth.dylib
PRE_TARGETDEPS += $${LIBSCSYNTH}/libscsynth.dylib

#libsclang.a
LIBS += $${LIBSCLANG}/libsclang.a
PRE_TARGETDEPS += $${LIBSCLANG}/libsclang.a

# Boost Libraries
LIBS += $${BOOST_LIBS}/libboost_chrono.a

INCLUDEPATH += $${BOOST} \
    $${LIBSCPP_SOURCE} \
    $${SUPERCOLLIDER_SOURCE}/include/common \
    $${SUPERCOLLIDER_SOURCE}/include/plugin_interface \
    $${SUPERCOLLIDER_SOURCE}/include/server \
    $${SUPERCOLLIDER_SOURCE}/include/lang \
    $${SUPERCOLLIDER_SOURCE}/external_libraries \
    $${SUPERCOLLIDER_SOURCE}/external_libraries/boost \
    $${SUPERCOLLIDER_SOURCE}/external_libraries/boost/libs/date_time/src/gregorian \
    $${SUPERCOLLIDER_SOURCE}/external_libraries/boost/libs/date_time/src/posix_time \
    $${SUPERCOLLIDER_SOURCE}/external_libraries/boost_endian \
    $${SUPERCOLLIDER_SOURCE}/external_libraries/boost_lockfree \
    $${SUPERCOLLIDER_SOURCE}/external_libraries/curl \
    $${SUPERCOLLIDER_SOURCE}/external_libraries/icu \
    $${SUPERCOLLIDER_SOURCE}/external_libraries/libsndfile \
    $${SUPERCOLLIDER_SOURCE}/external_libraries/nova-simd \
    $${SUPERCOLLIDER_SOURCE}/external_libraries/nova-tt \
    $${SUPERCOLLIDER_SOURCE}/external_libraries/oscpack \
    $${SUPERCOLLIDER_SOURCE}/external_libraries/pycxx-6.22 \
    $${SUPERCOLLIDER_SOURCE}/external_libraries/simplejson-2.3.2 \
    $${SUPERCOLLIDER_SOURCE}/external_libraries/threadpool \
    $${SUPERCOLLIDER_SOURCE}/external_libraries/TLSF-2.4.6/src \
    $${SUPERCOLLIDER_SOURCE}/external_libraries/yaml-cpp-0.3.0 \
    libraries/jsoncpp/include \
    libraries/jsoncpp/include/json \
    libraries/jsoncpp/src/lib_son

DEPENDPATH += $${BOOST} \
    $${LIBSCPP_SOURCE} \
    $${SUPERCOLLIDER_SOURCE}/include/common \
    $${SUPERCOLLIDER_SOURCE}/include/plugin_interface \
    $${SUPERCOLLIDER_SOURCE}/include/server \
    $${SUPERCOLLIDER_SOURCE}/include/lang \
    $${SUPERCOLLIDER_SOURCE}/external_libraries \
    $${SUPERCOLLIDER_SOURCE}/external_libraries/boost \
    $${SUPERCOLLIDER_SOURCE}/external_libraries/boost/libs/date_time/src/gregorian \
    $${SUPERCOLLIDER_SOURCE}/external_libraries/boost/libs/date_time/src/posix_time \
    $${SUPERCOLLIDER_SOURCE}/external_libraries/boost_endian \
    $${SUPERCOLLIDER_SOURCE}/external_libraries/boost_lockfree \
    $${SUPERCOLLIDER_SOURCE}/external_libraries/curl \
    $${SUPERCOLLIDER_SOURCE}/external_libraries/icu \
    $${SUPERCOLLIDER_SOURCE}/external_libraries/libsndfile \
    $${SUPERCOLLIDER_SOURCE}/external_libraries/nova-simd \
    $${SUPERCOLLIDER_SOURCE}/external_libraries/nova-tt \
    $${SUPERCOLLIDER_SOURCE}/external_libraries/oscpack \
    $${SUPERCOLLIDER_SOURCE}/external_libraries/pycxx-6.22 \
    $${SUPERCOLLIDER_SOURCE}/external_libraries/simplejson-2.3.2 \
    $${SUPERCOLLIDER_SOURCE}/external_libraries/threadpool \
    $${SUPERCOLLIDER_SOURCE}/external_libraries/TLSF-2.4.6/src \
    $${SUPERCOLLIDER_SOURCE}/external_libraries/yaml-cpp-0.3.0 \
    libraries/jsoncpp/include \
    libraries/jsoncpp/include/json \
    libraries/jsoncpp/src/lib_son









#---------------------------------------------------------------------------------------------------------------
#    Shoggoth, A multiplayer rhythm summoning program
#    Chad McKinney, 2012
#
#    Licensed under GNU GPL 3.0
#    See COPYING for licensing details
#---------------------------------------------------------------------------------------------------------------

mac {
    QT     -= core gui opengl
    # Change to your OS version (and make sure its there!)
    QMAKE_MAC_SDK = /Developer/SDKs/MacOSX10.6.sdk
}

linux-g++ {
    TEMPLATE = app
    QT += core gui opengl
    CONFIG += qt
    #CONFIG -= qt
}

# currently 64bit. If you want i386 you will need to build above libraries yourself for i386 first
CONFIG += x86_64
TARGET = Shoggoth

include(QMakeVars.pri)



INCLUDEPATH += $${CINDER_HOME}/include
INCLUDEPATH += $${CINDER_HOME}/lib
#INCLUDEPATH += $${CINDER_HOME}/boost
#INCLUDEPATH += $${CINDER_HOME}/boost/boost
#INCLUDEPATH += $${CINDER_HOME}/blocks/msaFluid/include
#INCLUDEPATH += $${CINDER_HOME}/blocks/opencv/include
#INCLUDEPATH += $${CINDER_HOME}/blocks/osc/include
#INCLUDEPATH += $${CINDER_HOME}/blocks/tuio/include
#INCLUDEPATH += $${CINDER_HOME}/blocks/osc/lib/macosx
INCLUDEPATH += $${SLBINCLUDE}
DEPENDPATH += $${SLBINCLUDE}

mac {
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

    INCLUDEPATH += $${CINDER_HOME}/lib/macosx

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

    #-lpthread
    #QMAKE_CXXFLAGS += -DSC_AUDIO_API=SC_AUDIO_API_AUDIOUNITS
    DEFINES += __APPLE__
    QMAKE_CXXFLAGS += -D__MACOSX_CORE__
    CXXFLAGS += -D__MACOSX_CORE__
    CXXFLAGS +=-DSC_DARWIN
    LIBS += -lpthread

    #QMAKE_CFLAGS += -DSC_AUDIO_API=SC_AUDIO_API_AUDIOUNITS
    QMAKE_CFLAGS += -D__MACOSX_CORE__
    LIBS += -framework CoreAudio
    LIBS += -framework CoreServices
    LIBS += -framework vecLib
    LIBS += -framework CoreFoundation

    QMAKE_LFLAGS += -F/System/Library/Frameworks/CoreFoundation.Framework

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

linux-g++ {
    DEFINES += __LINUX__
    DEFINES += CINDER_LINUX
    DEFINES += linux
    DEFINES += SC_AUDIO_API=SC_AUDIO_API_JACK
    DEFINES += OSC_HOST_LITTLE_ENDIAN
    DEFINES += BOOST_HAS_TR1
    DEFINES += CINDER_VERSION=8500
    # DEFINES += PURE_GL_SHADER_SETUP

    LIBS += -lpthread
    LIBS += $${CINDER_HOME}/lib/libcinder.a
    #LIBS += $${CINDER_HOME}/scons/libcinder.a
    LIBS += /usr/lib/x86_64-linux-gnu/libz.a
    LIBS += /usr/lib/x86_64-linux-gnu/libpng.a
    LIBS += /usr/lib/x86_64-linux-gnu/libpixman-1.a
    LIBS += /usr/lib/x86_64-linux-gnu/libcairo.a
    #LIBS += /usr/lib/libboost_thread.a
    #LIBS += /usr/lib/libboost_system.a
    #LIBS += /usr/lib/libboost_filesystem.a
    #LIBS += /usr/lib/libboost_date_time.a
}

#libSC++
LIBS += $${LIBSCPP_LIB}/libSC++.a
#PRE_TARGETDEPS += $${LIBSCPP_LIB}/libSC++.a

# libsclang.a
LIBS += $${LIBSCLANG}/libsclang.a
#PRE_TARGETDEPS += $${LIBSCLANG}/libsclang.a


mac {
    #libscsynth.dylib
    LIBS += $${LIBSCSYNTH}/libscsynth.dylib
    #PRE_TARGETDEPS += $${LIBSCSYNTH}/libscsynth.dylib

    SCSYNTH_DYLIB.files = $${LIBSCSYNTH}/libscsynth.dylib
    SCSYNTH_DYLIB.path = /Contents/Frameworks/
    QMAKE_BUNDLE_DATA += SCSYNTH_DYLIB
}

linux-g++ {
    #libscsynth.a
    LIBS += $${LIBSCSYNTH}/libscsynth.a
    #PRE_TARGETDEPS += $${LIBSCSYNTH}/libscsynth.a
}

# Avahi
#LIBS += $${AVAHI_CLIENT}/libavahi-client.a
#LIBS += $${AVAHI_COMMON}/libavahi-common.a
#PRE_TARGETDEPS += $${AVAHI_COMMON}/libavahi-common.a
#PRE_TARGETDEPS += $${AVAHI_CLIENT}/libavahi-client.a

#boost
LIBS += $${BOOST_LIBS}/libboost_date_time.a
#PRE_TARGETDEPS += $${BOOST_LIBS}/libboost_date_time.a
#LIBS += $${BOOST_LIBS}/build/libboost_test.a
LIBS += $${LIBSCSYNTH}/../../external_libraries/libtlsf.a
LIBS += $${BOOST_LIBS}/libboost_filesystem.a
LIBS += $${BOOST_LIBS}/libboost_system.a
#LIBS += $${SUPERCOLLIDER_SOURCE}/build/external_libraries/liboscpack.a
LIBS += $${BOOST_LIBS}/libboost_thread.a
LIBS += $${BOOST_LIBS}/libboost_program_options.a
LIBS += $${BOOST_LIBS}/libboost_chrono.a

# Libsndfile
LIBS += $${LIBSNDFILE}/libsndfile.a
#PRE_TARGETDEPS += $${LIBSNDFILE}/libsndfile.a

# FFTWF
LIBS += $${FFTWF}/libfftw3f.a
#PRE_TARGETDEPS += $${FFTWF}/libfftw3f.a

# Jack
mac {
    LIBS += $${JACK}/libjack.a
#PRE_TARGETDEPS += $${JACK}/libjack.a
}

linux-g++ {
    LIBS += $${JACK}/libjack.so
}
# FLAC
LIBS += $${FLAC}/libFLAC.a
#PRE_TARGETDEPS += $${FLAC}/libFLAC.a

# Vorbis
LIBS += $${VORBIS}/libvorbis.a
LIBS += $${VORBIS}/libvorbisenc.a

# OGG
LIBS += $${OGG}/libogg.a
#PRE_TARGETDEPS += $${OGG}/libogg.a

# Simpla Lua Binder
LIBS += $${SLBLIBS}/libSLB.a

# cwiid
LIBS += /usr/lib/libcwiid.a

#Curl
#LIBS += /usr/lib/x86_64-linux-gnu/libcurl.a
LIBS += -lcurl

# alsa
LIBS += -lasound

# yaml
LIBS += $${LIBSCSYNTH}/../../external_libraries/libyaml.a

# Bluetooth
LIBS += /usr/lib/x86_64-linux-gnu/libbluetooth.a

win32 {
    CONFIG += console
}

CONFIG += opengl

TEMPLATE = app

INCLUDEPATH += oscpack/
DEPENDPATH += oscpack/

SOURCES += src/ShSnakePit.cpp \
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
    src/Graphics/timequakedisplay.cpp \
    src/Audio/polyphonicsynth.cpp \
    src/Graphics/serverpanel.cpp \
    oscpack/osc/OscOutboundPacketStream.cpp \
    oscpack/osc/OscPrintReceivedElements.cpp \
    oscpack/osc/OscReceivedElements.cpp \
    oscpack/osc/OscTypes.cpp \
    oscpack/ip/IpEndpointName.cpp \
    oscpack/ip/posix/UdpSocket.cpp \
    oscpack/ip/posix/NetworkingUtils.cpp


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
    libraries/jsoncpp/include/json/json.h \
    libraries/jsoncpp/include/json/forwards.h \
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
    src/Graphics/timequakedisplay.h \
    src/Audio/polyphonicsynth.h \
    src/Graphics/serverpanel.h \
    libraries/jsoncpp/include/json/jsonfeatures.h \
    libraries/jsoncpp/include/json/jsonvalue.h \
    libraries/jsoncpp/include/json/jsonwriter.h \
    libraries/jsoncpp/include/json/jsonreader.h

RESOURCES += \

OTHER_FILES += \
    shaders/wireframe_vert.glsl \
    shaders/wireframe_frag.glsl \
    shaders/picking_vert.glsl \
    shaders/picking_frag.glsl \
    shaders/phong_vert.glsl \
    shaders/phong_frag.glsl \
    QMakeVars.pri


INCLUDEPATH += $${BOOST} \
    $${LIBSCPP_INCLUDE} \
    $${SUPERCOLLIDER_SOURCE}/include/common \
    $${SUPERCOLLIDER_SOURCE}/include/plugin_interface \
    $${SUPERCOLLIDER_SOURCE}/include/server \
    $${SUPERCOLLIDER_SOURCE}/include/lang \
    $${SUPERCOLLIDER_SOURCE}/external_libraries \
    #$${SUPERCOLLIDER_SOURCE}/external_libraries/boost \
    #$${SUPERCOLLIDER_SOURCE}/external_libraries/boost/libs/date_time/src/gregorian \
    #$${SUPERCOLLIDER_SOURCE}/external_libraries/boost/libs/date_time/src/posix_time \
    #$${SUPERCOLLIDER_SOURCE}/external_libraries/boost_endian \
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
    $${LIBSCPP_INCLUDE} \
    $${SUPERCOLLIDER_SOURCE}/include/common \
    $${SUPERCOLLIDER_SOURCE}/include/plugin_interface \
    $${SUPERCOLLIDER_SOURCE}/include/server \
    $${SUPERCOLLIDER_SOURCE}/include/lang \
    $${SUPERCOLLIDER_SOURCE}/external_libraries \
    #$${SUPERCOLLIDER_SOURCE}/external_libraries/boost \
    #$${SUPERCOLLIDER_SOURCE}/external_libraries/boost/libs/date_time/src/gregorian \
    #$${SUPERCOLLIDER_SOURCE}/external_libraries/boost/libs/date_time/src/posix_time \
    #$${SUPERCOLLIDER_SOURCE}/external_libraries/boost_endian \
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









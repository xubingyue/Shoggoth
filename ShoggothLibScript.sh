#!/bin/sh
cd /Users/curtismckinney/Documents/QtDev/Shoggoth-build-desktop/Shoggoth.app/Contents/Frameworks
install_name_tool -id @executable_path/../Frameworks/libscsynth.dylib libscsynth.dylib
cd /Users/curtismckinney/Documents/QtDev/Shoggoth-build-desktop/Shoggoth.app/Contents/MacOs
install_name_tool -change /Users/curtismckinney/Documents/SuperColliderSource/SuperCollider-Source-3.5/build/server/scsynth/Release/libscsynth.dylib @executable_path/../Frameworks/libscsynth.dylib Shoggoth
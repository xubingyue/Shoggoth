#ifndef SCRIPT_H
#define SCRIPT_H

// SLB includes
#include "SLB/SLB.hpp"
#include "SLB/lua.hpp"

// local includes
#include "src/Script/ShoggothScript.hpp"
#include "scripttypes.h"
#include "src/Script/luafunctor.h"

namespace script {

//////////////////
// Namespace Vars
//////////////////

extern SLB::Manager manager;
extern SLB::ShoggothScript interpreter;

///////////////////////
// Namespace Functions
///////////////////////

void initialize(); // THIS MUST BE CALLED AT STARTUP BEFORE ANY CODE CAN BE INTERPRETTED
bool interpret(const char* luaCode); // returns whether the code was successfully interpretted or not
void loadScriptLibrary(); // Loads the script lua script library
void loadScript(std::string fileName); // Relative to the LuaScripts folder!!!!!!!!!!
lua_State* luaState();
void setPrintCallback(SLB::ShoggothScript::PrintCallback printCallback); // Set the print callback from Lua

} // script namespace

#endif // SCRIPT_H

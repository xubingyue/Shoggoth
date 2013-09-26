// Local includes
#include "src/Script/script.h"
#include "src/Script/wrappers.h"
#include "src/ShGlobals.h"


namespace script {
/*
//////////////////
// Namespace Vars
//////////////////
SLB::Manager manager;
SLB::ShoggothScript interpreter(&manager);

///////////////////////
// Namespace Functions
///////////////////////

void initialize()
{
    compileWrappers(&manager);
    //loadScriptLibrary();
    setPrintCallback(ShGlobals::luaPrintCallback);
    script::interpret("SLB.using(SLB)"); // Populate the global namespace with our shoggoth functions
}

bool interpret(const char *luaCode)
{
    interpreter.safeDoString(luaCode);
}

void loadScriptLibrary()
{
    // FIGURE OUT NEW WAY TO GET SCRIPTS FROM FILE
    // StringVectorPtr names = ResourceGroupManager::getSingleton().listResourceNames("DefaultLuaScripts");
    // for(int i = 0; i < names->size(); ++i)
    // {
    //    loadScript(names->at(i));
    // }
    // names.setNull();
}

void loadScript(std::string fileName)
{
    // FIGURE OUT NEW WAY TO GET SCRIPTS FROM FILE
    // DataStreamPtr pStream = ResourceGroupManager::getSingleton().openResource(
    //            fileName,
    //            "LuaScripts");

    // String data = pStream.getPointer()->getAsString();
    // interpret(data.c_str());
    // pStream.getPointer()->close();
    // pStream.setNull();
}

lua_State* luaState()
{
    return interpreter.getState();
}

void setPrintCallback(SLB::ShoggothScript::PrintCallback printCallback)
{
    interpreter.setPrintCallback(printCallback);
}
*/
} // script namespace

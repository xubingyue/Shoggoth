// System includes
#include <iostream>

// Entropy includes
#include "luafunctor.h"
#include "src/Script/script.h"

namespace script {

LuaFunctor::LuaFunctor(int functionKey) :
    functionKey(functionKey)
{
    if(functionKey == -1)
        notEmpty = false;
    else
        notEmpty = true;
}

LuaFunctor::~LuaFunctor()
{
    if(notEmpty)
    {
        // luaL_unref(script::luaState(), LUA_REGISTRYINDEX, functionKey);
    }
}

void LuaFunctor::operator()()
{
    this->call();
}

void LuaFunctor::call()
{
    /*
    if(notEmpty)
    {
        lua_rawgeti(script::luaState(), LUA_REGISTRYINDEX, functionKey); // Push the function on to the stack
        int arguments = pushArguments(); // Push the arguments onto the stack, returning the number of said arguments
        int errorNum = lua_pcall(script::luaState(), arguments, 0, 0); // Call the function, and note the error, if any

        if(errorNum != 0)
        {
            std::cout << "Lua functor error: " << errorNum << std::endl;
        }
    }*/
}

int LuaFunctor::pushArguments() // Overload this from child if you need arguments for your function, return the number of arguments
{
    return 0;
}

} // script namespace

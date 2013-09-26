#ifndef WRAPPERS_H
#define WRAPPERS_H

#include <iostream>

// Boost includes
#include "boost/shared_ptr.hpp"

// Lua includes
#include "SLB/lua/lua.h"

// Entropy includes
#include "src/Script/scripttypes.h"
#include "src/Script/luafunctor.h"
#include "src/Script/script.h"

namespace SLB {
    class Manager;

    namespace Private {

    // Template parameters for lua bound calls

    /////////////////
    // lua_CFunction
    /////////////////

    // Create types definitions for binding to lua
    template<>
    struct Type<lua_CFunction>
    {
        typedef lua_CFunction GetType;
        static void push(lua_State* L, lua_CFunction obj)
        {
            SLB_DEBUG_CALL;
            if(obj == 0)
            {
                lua_pushnil(L);
            }

            else
            {
                SLB_DEBUG(8, "Push<lua_CFunction> (L=%p, obj =%p)", L, obj);
                lua_pushcfunction(L, obj);
            }
        }

        static lua_CFunction get(lua_State* L, int pos)
        {
            SLB_DEBUG_CALL;
            SLB_DEBUG(8, "Get<lua_CFunction> (L=%p, pos=%i ) =%p)", L, pos, lua_tocfunction(L, pos));

            if(lua_iscfunction(L, pos))
            {
                return lua_tocfunction(L, pos);
            }

            else if(lua_isfunction(L, pos))
            {
                return (lua_CFunction) lua_topointer(L, pos);
            }

            else
            {
                return 0;
            }
        }
    };

    template<> struct Type<lua_CFunction&> : public Type<lua_CFunction> {};
    template<> struct Type<const lua_CFunction&> : public Type<lua_CFunction> {};

    ///////////////
    // const void*
    ///////////////

    template<>
    struct Type<const void*>
    {
        typedef const void* GetType;
        static void push(lua_State* L, const void* obj)
        {
            SLB_DEBUG_CALL;
            if(obj == 0)
            {
                lua_pushnil(L);
            }

            else
            {
                SLB_DEBUG(8, "Push<const void*> (L=%p, obj =%p)", L, obj);
                //lua_push
            }
        }

        static const void* get(lua_State* L, int pos)
        {
            SLB_DEBUG_CALL;
            SLB_DEBUG(8, "Get<const void*> (L=%p, pos=%i ) =%p)", L, pos, lua_topointer(L, pos));

            if(lua_isfunction(L, pos))
            {
                return lua_topointer(L, pos);
            }

            else
            {
                return 0;
            }
        }
    };

    //////////////
    // LuaFunctor
    //////////////

    template<>
    struct Type<script::lua_functor_t>
    {
        typedef script::lua_functor_t GetType;
        static void push(lua_State* L, const void* obj)
        {
            SLB_DEBUG_CALL;
            if(obj == 0)
            {
                lua_pushnil(L);
            }

            else
            {
                lua_pushnil(L); // CAN'T PUSH THIS
                //SLB_DEBUG(8, "Push<script::lua_functor_t> (L=%p, obj =%p)", L, obj);
                //lua_push
            }
        }

        static script::lua_functor_t get(lua_State* L, int pos)
        {
            //SLB_DEBUG_CALL;
            //SLB_DEBUG(8, "Get<script::lua_functor_t> (L=%p, pos=%i ) =%p)", L, pos, lua_topointer(L, pos));

            if(lua_isfunction(L, pos))
            {
                lua_pushvalue(L, pos); // Copy the function onto the top of the stack
                // int functionKey = luaL_ref(script::luaState(), LUA_REGISTRYINDEX); // Save the function to the registry
                // return script::lua_functor_t(new script::LuaFunctor(functionKey));
            }

            else
            {
                return script::lua_functor_t(new script::LuaFunctor());
            }
        }
    };

    } // Private namespace
} // SLB namespace

namespace script {

void compileWrappers(SLB::Manager* manager);

} // script namespace

#endif // WRAPPERS_H

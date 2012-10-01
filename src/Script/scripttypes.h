#ifndef SCRIPTTYPES_H
#define SCRIPTTYPES_H

// Boost includes
#include "boost/shared_ptr.hpp"

// Shoggoth includes
#include "src/Script/luafunctor.h"

// Lua typedefs
typedef struct lua_State lua_State;
typedef int (*lua_CFunction) (lua_State *L);

// script types
namespace script {

    typedef boost::shared_ptr<LuaFunctor> lua_functor_t;

} // script namespace

#endif // SCRIPTTYPES_H

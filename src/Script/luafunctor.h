#ifndef LUAFUNCTOR_H
#define LUAFUNCTOR_H

#include "src/shogtypes.h"

// SLB includes
/*#include "libraries/slb/include/SLB/lua.hpp"

namespace script {

// Encapsulates a Lua function upon creation. Only create this as an argument in a lua bound function!
class LuaFunctor
{
public:
    LuaFunctor(int functionKey = -1);
    ~LuaFunctor();

    void operator()();
    void call();

    int functionKey; // lua registry key
    bool notEmpty; // indicates if we have a valid functionKey

protected:

    virtual int pushArguments(); // Overload this for functions that require arguments, return the number of arguments
};

}
*/
#endif // LUAFUNCTOR_H

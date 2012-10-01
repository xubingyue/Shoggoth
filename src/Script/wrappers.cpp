// system includes
#include <iostream>
#include <vector>

// SLB includes
#include "SLB/SLB.hpp"

// Boost
#include "boost/function.hpp"

// Shoggoth includes
#include "wrappers.h"
#include "src/Script/script.h"
#include "src/Time/shtime.h"
#include "src/Time/shtimestream.h"

namespace script {

void lout(std::string printString)
{
    std::cout << printString << std::endl;
}

lua_functor_t testFunction;

void saveFunction(lua_functor_t functionRef)
{
    testFunction = functionRef;
}
void printFunction()
{
    testFunction->call();
}

void compileTypes(SLB::Manager* manager)
{

}

void compileWrappers(SLB::Manager* manager)
{
    // print out from Lua
    manager->set("lout", SLB::FuncCall::create(lout));

    // Time Control
    manager->set("timeShift", SLB::FuncCall::create(shtime::timeShift));
}

} // script namespace

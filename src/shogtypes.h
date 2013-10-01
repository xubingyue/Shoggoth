#ifndef TYPES_H
#define TYPES_H

#ifndef __APPLE__
#include <unordered_map>
#else
#include <boost/unordered_map.hpp>
#endif

namespace shog
{

#ifdef __APPLE__
using namespace boost::unordered;
#else
using namespace std;
#endif

} // shog namespace

#endif // TYPES_H

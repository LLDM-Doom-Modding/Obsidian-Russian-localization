#define LUA_IMPL
#define LUA_COMPAT_MATHLIB
// OBSIDIAN: Return fixed seed.
#define luai_makeseed(L) 0x0B51D1A + 'N'
// This enables Andrew Apted's original Lua extensions
// that are difficult to update to vanilla syntax in an
// automated fashion, namely 'continue' and optional commas
// after table items at the end of a line
// Not included: The '!=' operator, table traversal via 'each'
#define LUA_OBSIDIAN_EXTENSIONS
#include "minilua.h"
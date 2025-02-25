#define LUA_IMPL
// OBSIDIAN: Return fixed seed.
#define luai_makeseed(L) 0x0B51D1A + 'N'
#include "minilua.h"
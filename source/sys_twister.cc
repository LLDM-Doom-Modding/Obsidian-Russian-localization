//------------------------------------------------------------------------
//  RANDOM NUMBER GENERATION
//------------------------------------------------------------------------
//
//  OBSIDIAN Level Maker
//
//  Copyright (C) 2020-2025 The OBSIDIAN Team
//
//  This program is free software; you can redistribute it and/or
//  modify it under the terms of the GNU General Public License
//  as published by the Free Software Foundation; either version 2
//  of the License, or (at your option) any later version.
//
//  This program is distributed in the hope that it will be useful,
//  but WITHOUT ANY WARRANTY; without even the implied warranty of
//  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
//  GNU General Public License for more details.
//
//------------------------------------------------------------------------

#include <random>

#include "lib_util.h"

//#include "Rand.h" // from Steve

static std::mt19937_64 twister;
static std::uniform_real_distribution<double> the_doubler(0.0, 1.0);

void twister_Init()
{
    twister.seed(TimeGetMillies());
}

void twister_Reseed(uint64_t newseed)
{
    twister.seed(newseed);
    // proc gen MIDI uses its own RNG, but let's at least
    // match the seeds
    //steve::Rand::reseed(newseed);
}

uint64_t twister_UInt()
{
    return twister();
}

double twister_Double()
{
    return the_doubler(twister);
}
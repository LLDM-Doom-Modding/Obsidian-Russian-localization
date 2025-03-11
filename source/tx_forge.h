//------------------------------------------------------------------------
//  Spectral Synthesis (from ppmforge.c)
//------------------------------------------------------------------------

#pragma once

#include <stdint.h>

void TX_SpectralSynth(uint64_t seed, float *buf, int width, double fracdim = 2.4, double powscale = 1.2);

//--- editor settings ---
// vi:ts=4:sw=4:noexpandtab

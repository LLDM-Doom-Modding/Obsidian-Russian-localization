//------------------------------------------------------------------------
//  TRANSLATION / INTERNATIONALIZATION
//------------------------------------------------------------------------
//
//  OBSIDIAN Level Maker
//
//  Copyright (C) 2021-2025 The OBSIDIAN Team
//  Copyright (C) 2016-2017 Andrew Apted
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

#pragma once

#include <string>

void Trans_Init();
void Trans_SetLanguage();
void Trans_PopulateLanguages();

#define _(s) ob_gettext(s)

const char *ob_gettext(const char *s);

//--- editor settings ---
// vi:ts=4:sw=4:noexpandtab

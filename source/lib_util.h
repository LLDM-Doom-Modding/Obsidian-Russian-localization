//------------------------------------------------------------------------
//  Utility functions
//------------------------------------------------------------------------
//
//  OBSIDIAN Level Maker
//
//  Copyright (C) 2021-2025 The OBSIDIAN Team
//  Copyright (C) 2006-2017 Andrew Apted
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

#include <stdint.h>

#include <charconv>
#include <string>
#ifdef OBSIDIAN_ENABLE_GUI
#include <vector>
#endif

/* file utilities */

std::string GetFilename(std::string_view path);
std::string GetStem(std::string_view path);
std::string GetDirectory(std::string_view path);
std::string GetExtension(std::string_view path);
std::string PathAppend(std::string_view parent, std::string_view child);
void        ReplaceExtension(std::string &path, std::string_view ext);
#ifdef OBSIDIAN_ENABLE_GUI
bool IsDirectory(const char *path);
std::string GetAbsolutePath(const char *path);
std::vector<std::string> DirectoryList(const char *path, bool show_hidden = false);
#endif

bool  FileExists(std::string_view name);
FILE *FileOpen(std::string_view name, std::string_view mode);
bool  FileRename(std::string_view oldname, std::string_view newname);
bool  FileDelete(std::string_view name);

/* string utilities */

#ifdef _WIN32
// Technically these are to and from UTF-16, but since these are only for
// Windows "wide" APIs I think we'll be ok - Dasho
std::string  WStringToUTF8(std::wstring_view instring);
std::wstring UTF8ToWString(std::string_view instring);
#endif

inline bool IsUpperASCII(int character)
{
    return (character > '@' && character < '[');
}
inline bool IsLowerASCII(int character)
{
    return (character > '`' && character < '{');
}
inline bool IsAlphaASCII(int character)
{
    return ((character > '@' && character < '[') || (character > '`' && character < '{'));
}
inline bool IsAlphanumericASCII(int character)
{
    return ((character > '@' && character < '[') || (character > '`' && character < '{') ||
            (character > '/' && character < ':'));
}
inline bool IsDigitASCII(int character)
{
    return (character > '/' && character < ':');
}
inline bool IsXDigitASCII(int character)
{
    return ((character > '@' && character < 'G') || (character > '`' && character < 'g') ||
            (character > '/' && character < ':'));
}
inline bool IsPrintASCII(int character)
{
    return (character > 0x1F && character < 0x7F);
}
inline bool IsSpaceASCII(int character)
{
    return ((character > 0x8 && character < 0xE) || character == 0x20);
}
inline int ToLowerASCII(int character)
{
    if (character > '@' && character < '[')
        return character ^ 0x20;
    else
        return character;
}
inline int ToUpperASCII(int character)
{
    if (character > '`' && character < '{')
        return character ^ 0x20;
    else
        return character;
}

char *CStringDup(const char *original, int limit = -1);
char *CStringUpper(const char *name);
void  CStringFree(const char *string);

int StringCompare(std::string_view A, std::string_view B);
int StringPrefixCompare(std::string_view A, std::string_view B);

int StringCaseCompare(std::string_view A, std::string_view B);
int StringPrefixCaseCompare(std::string_view A, std::string_view B);

inline int StringToInt(std::string_view value) 
{
    int actual_number;
    std::from_chars(value.data(), value.data() + value.size(), actual_number);
    return actual_number;
}
inline double StringToDouble(std::string_view value) 
{
    double actual_number;
    std::from_chars(value.data(), value.data() + value.size(), actual_number);
    return actual_number;
}

/* time utilities */

int64_t TimeGetMillies();

/* memory utilities */

void *UtilCalloc(int size);
void *UtilRealloc(void *old, int size);
void  UtilFree(void *data);

/* math utilities */

inline uint64_t StringHash64(std::string_view str) 
{
    uint64_t value = 0xcbf29ce484222325;
	for (const char ch : str) 
    {
		value = (value ^ (uint64_t)((uint8_t)ch)) * 0x100000001b3;
	}
	return value;
}

struct MapStringHash64
{
    size_t operator()(const std::string &k) const
    {
        return StringHash64(k);
    }
};

/* Thomas Wang's 32-bit Mix function */
inline uint32_t IntHash(uint32_t key)
{
    key += ~(key << 15);
    key ^= (key >> 10);
    key += (key << 3);
    key ^= (key >> 6);
    key += ~(key << 11);
    key ^= (key >> 16);

    return key;
}

double PerpDist(double x, double y, double x1, double y1, double x2, double y2);
double AlongDist(double x, double y, double x1, double y1, double x2, double y2);

double CalcAngle(double sx, double sy, double ex, double ey);

double ComputeDist(double sx, double sy, double ex, double ey);

double PointLineDist(double x, double y, double x1, double y1, double x2, double y2);

void CalcIntersection(double nx1, double ny1, double nx2, double ny2, double px1, double py1, double px2, double py2,
                      double *x, double *y);

std::pair<double, double> AlongCoord(double along, double px1, double py1, double px2, double py2);

bool VectorSameDir(double dx1, double dy1, double dx2, double dy2);

double ComputeAngle(double dx, double dy);

//--- editor settings ---
// vi:ts=4:sw=4:noexpandtab

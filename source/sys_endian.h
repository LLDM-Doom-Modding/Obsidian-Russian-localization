//------------------------------------------------------------------------
//  OBSIDIAN Endian handling
//----------------------------------------------------------------------------
//
//  Copyright (c) 2024-2025 The OBSIDIAN Team.
//  Copyright (c) 2003-2024 The EDGE Team.
//
//  This program is free software; you can redistribute it and/or
//  modify it under the terms of the GNU General Public License
//  as published by the Free Software Foundation; either version 3
//  of the License, or (at your option) any later version.
//
//  This program is distributed in the hope that it will be useful,
//  but WITHOUT ANY WARRANTY; without even the implied warranty of
//  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
//  GNU General Public License for more details.
//
//----------------------------------------------------------------------------

#pragma once

#include <stdint.h>
#include <stdlib.h>

#include <bit>

// Used to swap values.  Try to use superfast macros on systems
// that support them, otherwise use regular C++ functions.
#if defined(__GNUC__) || defined(__clang__)
static inline uint16_t __Swap16(uint16_t n)
{
    return __builtin_bswap16(n);
}
static inline uint32_t __Swap32(uint32_t n)
{
    return __builtin_bswap32(n);
}
static inline uint64_t __Swap64(uint64_t n)
{
    return __builtin_bswap64(n);
}
#elif defined(_MSC_VER)
static inline uint16_t __Swap16(uint16_t n)
{
    return _byteswap_ushort(n);
}
static inline uint32_t __Swap32(uint32_t n)
{
    return _byteswap_ulong(n);
}
static inline uint64_t __Swap64(uint64_t n)
{
    return _byteswap_uint64(n);
}
#else
static inline uint16_t __Swap16(uint16_t n)
{
    uint16_t a;
    a = (n & 0xFF) << 8;
    a |= (n >> 8) & 0xFF;
    return a;
}
static inline uint32_t __Swap32(uint32_t n)
{
    uint32_t a;
    a = (n & 0xFFU) << 24;
    a |= (n & 0xFF00U) << 8;
    a |= (n >> 8) & 0xFF00U;
    a |= (n >> 24) & 0xFFU;
    return a;
}
static inline uint64_t __Swap64(uint64_t n)
{
    uint64_t a;
    a = (n & 0xFFULL) << 56;
    a |= (n & 0xFF00ULL) << 40;
    a |= (n & 0xFF0000ULL) << 24;
    a |= (n & 0xFF000000ULL) << 8;
    a |= (n >> 8) & 0xFF000000ULL;
    a |= (n >> 24) & 0xFF0000ULL;
    a |= (n >> 40) & 0xFF00ULL;
    a |= (n >> 56) & 0xFFULL;
    return a;
}
#endif

inline uint16_t LE_U16(const uint16_t x)
{
    if constexpr (std::endian::native == std::endian::big)
        return __Swap16(x);
    else
        return x;
}
inline int16_t LE_S16(const uint16_t x)
{
    if constexpr (std::endian::native == std::endian::big)
        return (int16_t)__Swap16(x);
    else
        return (int16_t)x;
}
inline uint32_t LE_U32(const uint32_t x)
{
    if constexpr (std::endian::native == std::endian::big)
        return __Swap32(x);
    else
        return x;
}
inline int32_t LE_S32(const uint32_t x)
{
    if constexpr (std::endian::native == std::endian::big)
        return (int32_t)__Swap32(x);
    else
        return (int32_t)x;
}
inline uint64_t LE_U64(const uint64_t x)
{
    if constexpr (std::endian::native == std::endian::big)
        return __Swap64(x);
    else
        return x;
}
inline int64_t LE_S64(const uint64_t x)
{
    if constexpr (std::endian::native == std::endian::big)
        return (int64_t)__Swap64(x);
    else
        return (int64_t)x;
}
inline float LE_FLOAT(const float x)
{
    if constexpr (std::endian::native == std::endian::big)
    {
        union {
            float    f;
            uint32_t u;
        } in, out;
        in.f  = x;
        out.u = LE_U32(in.u);
        return out.f;
    }
    else
        return x;
}
inline uint16_t BE_U16(const uint16_t x)
{
    if constexpr (std::endian::native == std::endian::big)
        return x;
    else
        return __Swap16(x);
}
inline int16_t BE_S16(const uint16_t x)
{
    if constexpr (std::endian::native == std::endian::big)
        return (int16_t)x;
    else
        return (int16_t)__Swap16(x);
}
inline uint32_t BE_U32(const uint32_t x)
{
    if constexpr (std::endian::native == std::endian::big)
        return x;
    else
        return __Swap32(x);
}
inline int32_t BE_S32(const uint32_t x)
{
    if constexpr (std::endian::native == std::endian::big)
        return (int32_t)x;
    else
        return (int32_t)__Swap32(x);
}
inline uint64_t BE_U64(const uint64_t x)
{
    if constexpr (std::endian::native == std::endian::big)
        return x;
    else
        return __Swap64(x);
}
inline int64_t BE_S64(const uint64_t x)
{
    if constexpr (std::endian::native == std::endian::big)
        return (int64_t)x;
    else
        return (int64_t)__Swap64(x);
}
inline float BE_FLOAT(const float x)
{
    if constexpr (std::endian::native == std::endian::big)
        return x;
    else
    {
        union {
            float    f;
            uint32_t u;
        } in, out;
        in.f  = x;
        out.u = BE_U32(in.u);
        return out.f;
    }
}

//--- editor settings ---
// vi:ts=4:sw=4:noexpandtab

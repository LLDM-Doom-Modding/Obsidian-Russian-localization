//----------------------------------------------------------------------
//  Addons Loading and Selection GUI
//----------------------------------------------------------------------
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
//----------------------------------------------------------------------

#include "m_addons.h"

#include <format>

#include "lib_argv.h"
#include "lib_util.h"
#include "m_cookie.h"
#include "main.h"
#include "physfs.h"
#include "sys_debug.h"

// need this because the OPTIONS file is loaded *before* the addons
// folder is scanned for valid archives, so remember enabled ones here.
std::map<std::string, int> initial_enabled_addons;

std::vector<addon_info_t> all_addons;

// Will check install, then home directory (if different)
static void VFS_AddFolder(std::string_view name)
{
    std::string path  = PathAppend(install_dir, name);
    std::string mount = std::format("/{}", name);
    if (!PHYSFS_mount(path.c_str(), mount.c_str(), 0))
    {
        FatalError("Failed to mount '%s%s' folder in PhysFS:\n%s\n", path.c_str(), mount.c_str(),
                   PHYSFS_getErrorByCode(PHYSFS_getLastErrorCode()));
        return;                                   /* NOT REACHED */
    }
    if (install_dir != home_dir)
    {
        path = PathAppend(home_dir, name);
        PHYSFS_mount(path.c_str(), mount.c_str(), 0); // this one can fail if not present, that's fine
    }

    DebugPrint("mounted folder '%s%s'\n", path.c_str(), mount.c_str());
}

static bool VFS_AddArchive(std::string filename)
{
    LogPrint("  using: %s\n", filename.c_str());

    // when handling "bare" filenames from the command line (i.e. ones
    // containing no paths or drive spec) and the file does not exist in
    // the current dir, look for it in the standard addons/ folder.
    if ((!FileExists(filename) && GetDirectory(filename).empty()))
    {
        std::string new_name = std::format("{}/addons/{}", home_dir, filename);
        if (!FileExists(new_name))
        {
            new_name = std::format("{}/addons/{}", install_dir, filename);
        }
        filename = new_name;
    }

    if (!PHYSFS_mount(filename.c_str(), "/", 0))
    {
        LogPrint("Failed to mount '%s' archive in PhysFS:\n%s\n", filename.c_str(),
                    PHYSFS_getErrorByCode(PHYSFS_getLastErrorCode()));

        return false;
    }

    return true; // Ok
}

void VFS_InitAddons()
{
    LogPrint("Initializing VFS...\n");

    VFS_AddFolder("scripts");
    VFS_AddFolder("games");
    VFS_AddFolder("modules");
    VFS_AddFolder("data");
    VFS_AddFolder("ports");
    VFS_AddFolder("addons");

    LogPrint("DONE.\n\n");
}

void VFS_ScanForAddons()
{
    LogPrint("Scanning for addons....\n");

    all_addons.clear();

    char **got_names = PHYSFS_enumerateFiles("addons");

    // seems this only happens on out-of-memory error
    if (!got_names)
    {
        LogPrint("DONE (none found)\n");
    }

    char **p;

    for (p = got_names; *p; p++)
    {
        PHYSFS_Stat statter;

        if (PHYSFS_stat(PathAppend("/addons", *p).c_str(), &statter) == 0)
        {
            LogPrint("Could not stat %s: %s\n", *p, PHYSFS_getErrorByCode(PHYSFS_getLastErrorCode()));
            continue;
        }

        if (statter.filetype == PHYSFS_FILETYPE_DIRECTORY || (statter.filetype == PHYSFS_FILETYPE_REGULAR && GetExtension(*p) == ".zip"))
        {
            addon_info_t info;

            info.name = std::format("addon_{}", *p);

            info.enabled = false;

            if (initial_enabled_addons.find(info.name) != initial_enabled_addons.end())
            {
                info.enabled = true;
            }

            LogPrint("  found: %s%s\n", *p, info.enabled ? " (Enabled)" : " (Disabled)");

            all_addons.push_back(info);

            // if enabled, install into the VFS
            if (info.enabled)
            {
                VFS_AddArchive(*p);
            }
        }
    }

    PHYSFS_freeList(got_names);

    if (all_addons.size() == 0)
    {
        LogPrint("DONE (none found)\n");
    }
    else
    {
        LogPrint("DONE\n");
    }

    LogPrint("\n");
}

//----------------------------------------------------------------------

uint8_t *VFS_LoadFile(const char *filename, int *length)
{
    *length = 0;

    PHYSFS_File *fp = PHYSFS_openRead(filename);

    if (!fp)
    {
        return NULL;
    }

    *length = (int)PHYSFS_fileLength(fp);

    if (*length < 0)
    {
        PHYSFS_close(fp);
        return NULL;
    }

    uint8_t *data = new uint8_t[*length + 1];

    // ensure buffer is NUL-terminated
    data[*length] = 0;

    if ((PHYSFS_readBytes(fp, data, *length) / *length) != 1)
    {
        VFS_FreeFile(data);
        PHYSFS_close(fp);
        return NULL;
    }

    PHYSFS_close(fp);

    return data;
}

void VFS_FreeFile(const uint8_t *mem)
{
    if (mem)
    {
        delete[] mem;
    }
}

//--- editor settings ---
// vi:ts=4:sw=4:noexpandtab

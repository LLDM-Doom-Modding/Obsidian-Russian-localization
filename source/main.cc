//------------------------------------------------------------------------
//  Main program
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

#include "main.h"

#include <locale.h>
#include <string.h>

#include <format>
#include <string>

#include "csg_main.h"
#include "images.h"
#include "lib_argv.h"
#include "lib_util.h"
#include "m_addons.h"
#include "m_cookie.h"
#include "m_lua.h"
#include "m_trans.h"
#include "physfs.h"
#include "sys_debug.h"
#include "sys_twister.h"

#ifdef OBSIDIAN_ENABLE_GUI
#include "sokol_app.h"
#include "sokol_gfx.h"
#include "sokol_log.h"
#include "sokol_glue.h"
// include nuklear.h before the sokol_nuklear.h implementation
#define NK_INCLUDE_FIXED_TYPES
#define NK_INCLUDE_STANDARD_IO
#define NK_INCLUDE_DEFAULT_ALLOCATOR
#define NK_INCLUDE_VERTEX_BUFFER_OUTPUT
#define NK_INCLUDE_FONT_BAKING
#define NK_INCLUDE_DEFAULT_FONT
#define NK_INCLUDE_STANDARD_VARARGS
#include "nuklear.h"
#include "sokol_nuklear.h"
#endif

std::string        home_dir;
std::string        install_dir;
std::string        config_file;
static std::string logging_file;

std::string ob_error_message;

struct UpdateKv
{
    std::string key;
    std::string value;
};

static UpdateKv update_kv;

static constexpr const char *OBSIDIAN_TITLE   = "OBSIDIAN Level Maker";
static constexpr const char *CONFIG_FILENAME  = "CONFIG.txt";
static constexpr const char *LOG_FILENAME     = "LOGS.txt";

int main_action = 0;

uint64_t next_rand_seed;

std::string numeric_locale;

std::string string_seed;

std::string selected_lang = "en"; // Have a default just in case the translation stuff borks

game_interface_c *game_object = NULL;

/* ----- user information ----------------------------- */

static void ShowInfo()
{
    printf("\n"
           "** %s %s \"%s\"\n"
           "** Build %s **\n"
           "** Based on OBLIGE Level Maker (C) 2006-2017 Andrew Apted **\n"
           "\n",
           OBSIDIAN_TITLE, OBSIDIAN_SHORT_VERSION, OBSIDIAN_CODE_NAME, OBSIDIAN_VERSION);

    printf("Usage: Obsidian [options...] [key=value...]\n"
           "\n"
           "Available options:\n"
           "     --version              Display build information\n"
           "\n"
#ifdef OBSIDIAN_ENABLE_GUI
           "  -b --batch                Run in batch mode (no GUI)\n"
#endif
           "  -o --output   <output>    Specify output filename\n"
           "  -a --addon    <file>...   Addon(s) to use\n"
           "\n"
           "  -d --debug                Enable debugging\n"
           "  -v --verbose              Print log messages to stdout\n"
           "  -h --help                 Show this help message\n"
           "  -u --update <key> <value>\n"
           "                            Set a key in the config file\n"
           "\n");

    printf("Please visit the web site for complete information:\n"
           "  %s \n"
           "\n",
           OBSIDIAN_WEBSITE);

    printf("This program is free software, under the terms of the GNU General "
           "Public\n"
           "License, and comes with ABSOLUTELY NO WARRANTY.  See the "
           "documentation\n"
           "for more details, or visit http://www.gnu.org/licenses/gpl-2.0.txt\n"
           "\n");

    fflush(stdout);
}

static void ShowVersion()
{
    printf("%s %s \"%s\" Build %s\n", OBSIDIAN_TITLE, OBSIDIAN_SHORT_VERSION, OBSIDIAN_CODE_NAME,
           OBSIDIAN_VERSION);

    fflush(stdout);
}

static bool Verify_InstallDir(const std::string &path)
{
    const std::string filename = PathAppend(path, "scripts/obsidian.lua");

    return FileExists(filename);
}

bool Main::BackupFile(const std::string &filename)
{
    if (FileExists(filename))
    {
        std::string backup_name = filename;

        ReplaceExtension(backup_name, std::format("{}.{}", GetExtension(backup_name), ".bak"));

        LogPrint("Backing up existing file to: %s\n", backup_name.c_str());

        FileDelete(backup_name);
        FileRename(filename, backup_name);
    }

    return true;
}

void Main::Shutdown(const bool error)
{
    // on fatal error we cannot risk calling into the Lua runtime
    // (it's state may be compromised by a script error).
    if (!config_file.empty() && !error)
    {
        Cookie_Save(config_file);
    }

    Script_Close();
    LogClose();
}

void Main_CalcNewSeed()
{
    if (string_seed.empty())
        string_seed = ob_get_random_phrase();
    ob_set_config("seed", string_seed.c_str());
    next_rand_seed = StringHash64(string_seed);
    twister_Reseed(next_rand_seed);
}

/* ----- main program ----------------------------- */

#ifdef OBSIDIAN_ENABLE_GUI
static struct nk_context *ctx = NULL;
static struct nk_colorf bg = { 0.10f, 0.18f, 0.24f, 1.0f };
static struct sg_image font_img;
static struct snk_image_t font_nk_img;
static bool running = true;

void init(void) 
{
    // setup sokol-gfx and sokol-nuklear
    sg_desc desc = {0};
    desc.environment = sglue_environment();
    desc.logger.func = slog_func;
    sg_setup(&desc);

    // use sokol-nuklear with all default-options (we're not doing
    // multi-sampled rendering or using non-default pixel formats)
    snk_desc_t desc2 = {0};
    desc2.enable_set_mouse_cursor = true;
    desc2.no_default_font = true;
    desc2.dpi_scale = sapp_dpi_scale();
    desc2.logger.func = slog_func;
    snk_setup(&desc2);

    // setup nuklear context and moonnuklear integration
    ctx = snk_get_context();

    if (!ob_gui_init_ctx(ctx))
    {
        // ???
    }

    {
        struct nk_font_atlas *atlas = snk_get_atlas();

        /* set up the font atlas and add desired font; note that font sizes are
         * multiplied by font_scale to produce better results at higher DPIs */
        nk_font_atlas_init_default(atlas);
        nk_font_atlas_begin(atlas);

        if (ob_gui_init_themes(atlas))
        {
            const void *image; int w, h;
            image = nk_font_atlas_bake(atlas, &w, &h, NK_FONT_ATLAS_RGBA32);
            sg_image_desc img_desc = {0};
            img_desc.width = w;
            img_desc.height = h;
            img_desc.pixel_format = SG_PIXELFORMAT_RGBA8;
            memset(&img_desc.data.subimage[0][0], 0, sizeof(sg_range)); 
            img_desc.data.subimage[0][0].ptr = image;
            img_desc.data.subimage[0][0].size = (size_t)(w * h) * sizeof(uint32_t);
            img_desc.label = "sokol-nuklear-font";
            font_img = sg_make_image(&img_desc);
            snk_image_desc_t img_desc2 = {0};
            img_desc2.image = font_img;
            img_desc2.sampler = snk_get_font_sampler();
            font_nk_img = snk_make_image(&img_desc2);
            nk_font_atlas_end(atlas, snk_nkhandle(font_nk_img), 0);
            nk_font_atlas_cleanup(atlas);
        }
        else
        {
            // fatal error
        }
    }
}

void frame(void) 
{
    ctx = snk_new_frame();

    running = ob_gui_frame(sapp_width(), sapp_height(), sapp_dpi_scale());

    // the sokol_gfx draw pass
    sg_pass pass = {0};
    memset(&pass.action.colors[0], 0, sizeof(sg_color_attachment_action));
    pass.action.colors[0].load_action = SG_LOADACTION_CLEAR;
    pass.action.colors[0].clear_value = { bg.r, bg.g, bg.b, bg.a };
    pass.swapchain = sglue_swapchain();
    sg_begin_pass(&pass);
    snk_render(sapp_width(), sapp_height());
    sg_end_pass();
    sg_commit();

    // quit if not running?
}

void cleanup(void) 
{
    Main::Shutdown(false);
    snk_destroy_image(font_nk_img);
    sg_destroy_image(font_img);
    snk_shutdown();
    sg_shutdown();
}

void input(const sapp_event* event) 
{
    snk_handle_event(event);
}

sapp_desc sokol_main(int argc, char* argv[]) 
#else
int main(int argc, char **argv)
#endif
{
    // initialise argument parser (skipping program name)

    // these flags take at least one argument
    argv::short_flags.emplace('o');
    argv::short_flags.emplace('a');
    argv::short_flags.emplace('u');

    // parse the flags
    argv::Init(argc, argv);

    if (!PHYSFS_init(argv::list[0].c_str()))
    {
        FatalError("Failed to init PhysFS:\n%s\n", PHYSFS_getErrorByCode(PHYSFS_getLastErrorCode()));
    }

    if (argv::Find('?', NULL) >= 0 || argv::Find('h', "help") >= 0)
    {
        ShowInfo();
        exit(EXIT_SUCCESS);
    }
    else if (argv::Find(0, "version") >= 0)
    {
        ShowVersion();
        exit(EXIT_SUCCESS);
    }

    std::string batch_output_file;
    int batch_arg = argv::Find('o', "output");
    if (batch_arg >= 0)
    {
        if (batch_arg + 1 >= argv::list.size() || argv::IsOption(batch_arg + 1))
        {
            FatalError("OBSIDIAN ERROR: missing filename for --output\n");
            exit(EXIT_FAILURE);
        }

        batch_output_file = argv::list[batch_arg + 1];
    }

    if (int update_arg = argv::Find('u', "update"); update_arg >= 0)
    {
        if (update_arg + 2 >= argv::list.size() || argv::IsOption(update_arg + 1) || argv::IsOption(update_arg + 2))
        {
            FatalError("OBSIDIAN ERROR: missing one or more args for --update "
                       "<section> <key> <value>\n");
            exit(EXIT_FAILURE);
        }
        update_kv.key     = argv::list[update_arg + 1];
        update_kv.value   = argv::list[update_arg + 2];
    }

    install_dir = PHYSFS_getBaseDir();
    if (!Verify_InstallDir(install_dir))
    {
        FatalError("OBSIDIAN ERROR: Could not verify install directory!\n");
        exit(EXIT_FAILURE);
    }
#ifdef _WIN32
    home_dir = PHYSFS_getBaseDir();
#else
    home_dir = PHYSFS_getPrefDir("Obsidian Team", "Obsidian");
#endif
    Trans_Init();
    config_file = PathAppend(home_dir, CONFIG_FILENAME);
    logging_file = PathAppend(home_dir, LOG_FILENAME);

    Trans_SetLanguage();
    LogInit(logging_file);

    if (argv::Find('v', "verbose") >= 0)
    {
        LogEnableTerminal(true);
    }

    LogPrint("\n");
    LogPrint("********************************************************\n");
    LogPrint("** %s %s \"%s\" **\n", OBSIDIAN_TITLE, OBSIDIAN_SHORT_VERSION, OBSIDIAN_CODE_NAME);
    LogPrint("** Build %s **\n", OBSIDIAN_VERSION);
    LogPrint("********************************************************\n");
    LogPrint("\n");

    LogPrint("home_dir: %s\n", home_dir.c_str());
    LogPrint("install_dir: %s\n", install_dir.c_str());
    LogPrint("config_file: %s\n\n", config_file.c_str());

    // Grab current numeric locale
    numeric_locale = setlocale(LC_NUMERIC, NULL);

    VFS_InitAddons();

    if (FileExists(config_file))
        Cookie_LoadAddons(config_file);

    VFS_ScanForAddons();

    Script_Open();

    // Give RNG an initial seed
    twister_Init();

    // Set this to home dir before loading config (if present); it's ok to change afterwards
    ob_set_config("output_path", home_dir);

    if (!FileExists(config_file))
    {
        Cookie_Save(config_file);
    }
    if (!Cookie_Load(config_file))
    {
        FatalError(_("Error loading config file: %s\n"), config_file.c_str());
    }

    Cookie_ParseArguments();

    if (argv::Find('u', "update") >= 0)
    {
        ob_set_config(update_kv.key, update_kv.value);
        Cookie_Save(config_file);
        Main::Shutdown(false);
        exit(EXIT_SUCCESS);
    }

    if (!batch_output_file.empty())
        ob_set_config("output_filename", batch_output_file);
    else
        ob_set_config("output_filename", ob_default_filename());

    Main_CalcNewSeed();

#ifdef OBSIDIAN_ENABLE_GUI
    if (argv::Find('b', "batch") >= 0)
    { 
        LogEnableDebug(ob_get_bool_param("debug_messages"));
        if (!ob_do_build())
        {
            FatalError("FAILED!\n");
            LogPrint("FAILED!\n");

            Main::Shutdown(true);
            exit(EXIT_FAILURE);
        }
        Main::Shutdown(false);
        exit(EXIT_SUCCESS);
    }
    else
    {
        std::string win_title = std::format("{} v{} \"{}\"", OBSIDIAN_TITLE, OBSIDIAN_SHORT_VERSION, OBSIDIAN_CODE_NAME);
        sapp_desc app = {0};
        app.init_cb = init;
        app.frame_cb = frame;
        app.cleanup_cb = cleanup;
        app.event_cb = input;
        app.enable_clipboard = true;
        app.width = 0;
        app.height = 0;
        app.window_title = CStringDup(win_title.c_str());
        app.ios_keyboard_resizes_canvas = true;
        app.icon.sokol_default = false;
        app.logger.func = slog_func;
        app.high_dpi = true;
        return app;
    }
#else
    LogEnableDebug(ob_get_bool_param("debug_messages"));
    if (!ob_do_build())
    {
        FatalError("FAILED!\n");
        LogPrint("FAILED!\n");

        Main::Shutdown(true);
        return EXIT_FAILURE;
    }
    Main::Shutdown(false);
    return 0;
#endif
}

//--- editor settings ---
// vi:ts=4:sw=4:noexpandtab

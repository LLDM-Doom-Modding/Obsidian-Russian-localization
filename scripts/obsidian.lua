------------------------------------------------------------------------
--  OBSIDIAN  :  INTERFACE WITH GUI CODE
------------------------------------------------------------------------
--
--
--  Copyright (C) 2006-2017 Andrew Apted
--  Copyright (C) 2019-2023 MsrSgtShooterPerson
--
--  This program is free software; you can redistribute it and/or
--  modify it under the terms of the GNU General Public License
--  as published by the Free Software Foundation; either version 2,
--  of the License, or (at your option) any later version.
--
--  This program is distributed in the hope that it will be useful,
--  but WITHOUT ANY WARRANTY; without even the implied warranty of
--  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
--  GNU General Public License for more details.
--
------------------------------------------------------------------------

gui.import("defs")
gui.import("shapes")
gui.import("util")
gui.import("brush")
gui.import("prefab")
gui.import("autodetail")

gui.import("seed")
gui.import("grower")
gui.import("area")
gui.import("connect")
gui.import("quest")

gui.import("automata")
gui.import("cave")
gui.import("layout")
gui.import("render")
gui.import("room")

gui.import("fight")
gui.import("monster")
gui.import("item")
gui.import("naming")
gui.import("title_gen")
gui.import("level")

gui.import("script_manager")

-- Try to keep all UI-related code in ui.lua so that we don't have to throw
-- a bunch of guards in random scripts if we aren't compiling the GUI
if nk ~= nil then
  gui.import("ui")
end

gui.import("debugger")

gui.set_import_dir("data/text/")

gui.import("random_words_en.lua")
gui.import("random_words_en_m.lua")

gui.set_import_dir("")

function ob_ref_table(op, t)
  if not gui.___REFS then
    gui.___REFS = {}
  end

  if op == "clear" then
    gui.___REFS = {}
    collectgarbage("collect")
    return
  end

  if op == "store" then
    if t == _G then return 0 end
    local id = 1 + #gui.___REFS
    gui.___REFS[id] = t    -- t == table
    return id
  end

  if op == "lookup" then
    if t == 0 then return _G end
    return gui.___REFS[t]  -- t == id number
  end

  error("ob_ref_table: unknown op: " .. tostring(op))
end


------------------------------------------------------------------------

function ob_datetime_format_string()
  local current_date = os.date("*t")

  local formatstring

  if current_date.month < 10 then
    formatstring = "0" .. current_date.month
  else
    formatstring = current_date.month
  end
  if current_date.day < 10 then
    formatstring = formatstring .. "-0" .. current_date.day
  else
    formatstring = formatstring .. "-" .. current_date.day
  end
  
  formatstring = current_date.year .. "-" .. formatstring .. "-"

  if current_date.hour < 10 then
    formatstring = formatstring .. "0" .. current_date.hour
  else
    formatstring = formatstring .. current_date.hour
  end

  if current_date.min < 10 then
    formatstring = formatstring .. "0" ..current_date.min
  else
    formatstring = formatstring .. current_date.min
  end

  return formatstring
end

function ob_check_ui_module(def)
  return string.match(def.name, "^ui") ~= nil
end



function ob_match_word_or_table(tab, conf)
  if type(tab) == "table" then
    return tab[conf] and tab[conf] > 0
  else
    return tab == conf
  end
end



function ob_match_game(T)
  if not T.game then return true end
  if T.game == "any" then return true end

  -- special check: if required game is "doomish" then allow any
  -- of the DOOM games to match.
  if T.game == "doomish" then
     T.game = { doom1=1, doom2=1 }
  end

  local game   = T.game
  local result = true

  -- negated check?
  if type(game) == "string" and string.sub(game, 1, 1) == '!' then
    game   = string.sub(game, 2)
    result = not result
  end

  -- normal check
  if ob_match_word_or_table(game, OB_CONFIG.game) then
    return result
  end

  -- handle extended games
  local game_def = OB_GAMES[OB_CONFIG.game]

  while game_def do
    if not game_def.extends then
      break;
    end

    if ob_match_word_or_table(game, game_def.extends) then
      return result
    end

    game_def = OB_GAMES[game_def.extends]
  end

  return not result
end

function ob_match_port(T)
  if not T.port then return true end
  if T.port == "any" then return true end

  local port = T.port
  local result = true

  -- negated check?
  if type(port) == "string" and string.sub(port, 1, 1) == '!' then
    port = string.sub(port, 2)
    result = not result
  end

  -- normal check
  if ob_match_word_or_table(port, OB_CONFIG.port) then
    return result
  end
  
  

  -- handle extended ports

  local port_def = OB_PORTS[OB_CONFIG.port]

  while port_def do
    if not port_def.extends then
      break;
    end

    if ob_match_word_or_table(port, port_def.extends) then
      return result
    end

    port_def = OB_PORTS[port_def.extends]
  end

  return not result
end

function ob_match_port2(T)
  if not T.port2 then return true end
  if T.port2 == "any" then return true end

  local port = T.port2
  local result = true

  -- negated check?
  if type(port) == "string" and string.sub(port, 1, 1) == '!' then
    port = string.sub(port, 2)
    result = not result
  end

  -- normal check
  if ob_match_word_or_table(port, OB_CONFIG.port) then
    return result
  end
  
  

  -- handle extended ports

  local port_def = OB_PORTS[OB_CONFIG.port]

  while port_def do
    if not port_def.extends then
      break;
    end

    if ob_match_word_or_table(port, port_def.extends) then
      return result
    end

    port_def = OB_PORTS[port_def.extends]
  end

  return not result
end

function ob_match_port3(T)
  if not T.port3 then return true end
  if T.port3 == "any" then return true end

  local port = T.port3
  local result = true

  -- negated check?
  if type(port) == "string" and string.sub(port, 1, 1) == '!' then
    port = string.sub(port, 2)
    result = not result
  end

  -- normal check
  if ob_match_word_or_table(port, OB_CONFIG.port) then
    return result
  end


  -- handle extended ports

  local port_def = OB_PORTS[OB_CONFIG.port]

  while port_def do
    if not port_def.extends then
      break;
    end

    if ob_match_word_or_table(port, port_def.extends) then
      return result
    end

    port_def = OB_PORTS[port_def.extends]
  end

  return not result
end

function ob_match_port4(T)
  if not T.port4 then return true end
  if T.port4 == "any" then return true end

  local port = T.port4
  local result = true

  -- negated check?
  if type(port) == "string" and string.sub(port, 1, 1) == '!' then
    port = string.sub(port, 2)
    result = not result
  end

  -- normal check
  if ob_match_word_or_table(port, OB_CONFIG.port) then
    return result
  end
  
  

  -- handle extended ports

  local port_def = OB_PORTS[OB_CONFIG.port]

  while port_def do
    if not port_def.extends then
      break;
    end

    if ob_match_word_or_table(port, port_def.extends) then
      return result
    end

    port_def = OB_PORTS[port_def.extends]
  end

  return not result
end

function ob_match_level_theme(LEVEL, T, override)
  if not T.theme then return true end
  if T.theme == "any" then return true end

  -- if match theme toggle is disabled, everything qualifies
  if OB_CONFIG.bool_fab_match_theme == 0 then return true end

  local level_theme_name = LEVEL.theme_name
  if override then
    level_theme_name = override
  end

  local theme  = T.theme
  local result = true

  -- negated check?
  if type(theme) == "string" and string.sub(theme, 1, 1) == '!' then
    theme  = string.sub(theme, 2)
    result = not result
  end

  -- MSSP-REVIEW: These hack fixes should probably be more generalized elsewhere
  -- for future-proofing.

  -- hack fix for Deimos theme. It is now to use tech and hell defs altogether.
  if level_theme_name == "deimos"
    and (theme == "tech"
    or theme == "hell"
    or theme == "any"
    or not theme) then
    return result
  end

  -- hack fix for Thy Flesh theme too. Basically combine urban and hell fabs.
  if level_theme_name == "flesh"
    and (theme == "urban"
    or theme == "hell"
    or theme == "any"
    or not theme) then
    return result
  end

  -- hack fix for TNT's Egypt theme, sigh
  if level_theme_name == "egypt"
    and (theme == "any"
    or theme == "hell"
    or not theme) then
    return result
  end

  -- normal check
  if ob_match_word_or_table(theme, level_theme_name) then
    return result
  end

  return not result
end


function ob_match_module(T)
  if not T.module then return true end

  local mod_tab = T.module

  if type(mod_tab) ~= "table" then
    mod_tab  = { [T.module]=1 }
    T.module = mod_tab
  end

  -- require ALL specified modules to be present and enabled

  for _,name in pairs(mod_tab) do
    local def = OB_MODULES[name]

    if not (def and def.valid and def.enabled) then
      return false
    end
  end

  return true
end


function ob_match_feature(T)
  if not T.feature then return true end

  local feat_tab = T.feature

  if type(feat_tab) ~= "table" then
    feat_tab  = { [T.feature]=1 }
    T.feature = feat_tab
  end

  -- require ALL specified features to be available

  for _,name in pairs(feat_tab) do
    local param = OB_CONFIG[name]

    if param == nil or param == false then
      return false
    end
  end

  return true
end



function ob_match_conf(T)
  assert(OB_CONFIG.game)
  assert(OB_CONFIG.port)

  if not ob_match_game(T)     then return false end
  if not ob_match_port(T)   then return false end
  if not ob_match_port2(T)  then return false end
  if not ob_match_port3(T)  then return false end
  if not ob_match_port4(T)  then return false end
  if not ob_match_module(T)   then return false end

  return true --OK--
end



function ob_resolve_theme_keyword(T)
  local keys =
  {
    deimos =
    {
      "tech",
      "hell"
    },

    industrial =
    {
      "tech",
      "urban"
    },

    flesh =
    {
      "hell",
      "urban"
    }
  }

  if keys[T] then
    return rand.pick(keys[T])
  end

  return T
end




function ob_update_games()
  local need_new = false
  local game_choice = nil

  if nk ~= nil then
    UI_BUILD.GAMES = {}
    for _,opt in pairs(OB_MODULES["ui_build"].options) do
      if opt.name == "game" then
        game_choice = opt
        game_choice.avail_choices = {}
        game_choice.avail_labels = {}
        goto gamecleared
      end
    end
    ::gamecleared::
  end

  for name,def in pairs(OB_GAMES) do
    local valid = ob_match_conf(def)

    if not valid and (OB_CONFIG.game == name) then
      need_new = true
    end

    if nk ~= nil then
      if valid == true then
        table.insert(UI_BUILD.GAMES, def.name)
        table.insert(UI_BUILD.GAMES, def.label)
        game_choice.avail_choices[#game_choice.avail_choices+1] = def.name
        game_choice.avail_labels[#game_choice.avail_labels+1] = def.label
      end
    end
  end

  if need_new then
      OB_CONFIG.game = "doom2"
  end

  -- Fix selection index for GUI if appropriate
  if nk ~= nil then
    for index,name in ipairs(game_choice.avail_choices) do
      if OB_CONFIG.game == name then
        game_choice.choice_selection = index
        goto continuelabel
      end
    end
    ::continuelabel::
  end
end

function ob_update_ports()
  local need_new = false
  local port_choice = nil

  if nk ~= nil then
    UI_BUILD.PORTS = {}
    for _,opt in pairs(OB_MODULES["ui_build"].options) do
      if opt.name == "port" then
        port_choice= opt
        port_choice.avail_choices = {}
        port_choice.avail_labels = {}
        goto portcleared
      end
    end
    ::portcleared::
  end

  for name,def in pairs(OB_PORTS) do
    local valid = ob_match_conf(def)

    if not valid and (OB_CONFIG.port == name) then
      need_new = true
    end

    if nk ~= nil then
      if valid == true then
        table.insert(UI_BUILD.PORTS, def.name)
        table.insert(UI_BUILD.PORTS, def.label)
        port_choice.avail_choices[#port_choice.avail_choices+1] = def.name
        port_choice.avail_labels[#port_choice.avail_labels+1] = def.label
      end
    end
  end

  if need_new then
    OB_CONFIG.port = "boom"
  end

  -- Fix selection index for GUI if appropriate
  if nk ~= nil then
    for index,name in ipairs(port_choice.avail_choices) do
      if OB_CONFIG.port == name then
        port_choice.choice_selection = index
        goto continuelabel
      end
    end
    ::continuelabel::
  end
end

function ob_update_themes()
  local need_new = false
  local theme_choice = nil

  if nk ~= nil then
    UI_BUILD.THEMES = {}
    for _,opt in pairs(OB_MODULES["ui_build"].options) do
      if opt.name == "theme" then
        theme_choice = opt
        theme_choice.avail_choices = {}
        theme_choice.avail_labels = {}
        goto themecleared
      end
    end
    ::themecleared::
  end

  for name,def in pairs(OB_THEMES) do
    local valid = ob_match_conf(def)

    if not valid and (OB_CONFIG.theme == name) then
      need_new = true
    end

    def.valid = valid

    if nk ~= nil then
      if valid == true then
        table.insert(UI_BUILD.THEMES, def.name)
        table.insert(UI_BUILD.THEMES, def.label)
        theme_choice.avail_choices[#theme_choice.avail_choices+1] = def.name
        theme_choice.avail_labels[#theme_choice.avail_labels+1] = def.label
      end
    end
  end

  if need_new then
    OB_CONFIG.theme = "original"
  end

  -- Fix selection index for GUI if appropriate
  if nk ~= nil then
    for index,name in ipairs(theme_choice.avail_choices) do
      if OB_CONFIG.theme == name then
        theme_choice.choice_selection = index
        goto continuelabel
      end
    end
    ::continuelabel::
  end
end



function ob_update_modules()
  -- modules may depend on other modules, hence we may need
  -- to repeat this multiple times until all the dependencies
  -- have flowed through.

  for loop = 1,100 do
    local changed = false

    for name,def in pairs(OB_MODULES) do
      local valid = ob_match_conf(def)

      if valid ~= def.valid then
        changed = true
      end

      def.valid = valid
    end

    if not changed then break; end
  end
end



function ob_update_all()
  ob_update_games()
  ob_update_ports()
  ob_update_modules()
  ob_update_themes()
end



function ob_find_mod_option(mod, opt_name)
  if not mod.options then return nil end

  -- if 'options' is a list, search it one-by-one
  if mod.options[1] then
    for _,opt in pairs(mod.options) do
      if opt.name == opt_name then
        return opt
      end
    end
  end

  return mod.options[opt_name]
end


function ob_defs_conflict(def1, def2)
  if not def1.conflicts then return false end
  if not def2.conflicts then return false end

  for name,_ in pairs(def1.conflicts) do
    if def2.conflicts[name] then
      return true
    end
  end

  return false
end


function ob_set_mod_option(name, option, value)
  local mod = OB_MODULES[name]
  if not mod then
    gui.printf("Ignoring unknown module: %s\n", name)
    return
  end

  if option == "self" then
    -- convert 'value' from string to a boolean
    value = not (value == "false" or value == "0")

    if mod.enabled == value then
      return -- no change
    end

    mod.enabled = value

    -- handle conflicting modules (like Radio buttons)
    if value then
      for other,odef in pairs(OB_MODULES) do
        if odef ~= mod and ob_defs_conflict(mod, odef) then
          odef.enabled = false
        end
      end
    end

    ob_update_all()
    return
  end


  local opt = ob_find_mod_option(mod, option)
  if not opt then
    gui.printf("Ignoring unknown option: %s.%s\n", name, option)
    return
  end

  -- this can only happen while parsing the CONFIG.TXT file
  -- (containing some no-longer-used value).
  if not table.has_elem(opt.avail_choices, value) then
    warning("invalid choice: %s (for option %s.%s)\n", value, name, option)
    return
  end

  opt.value = value
  if nk ~= nil then
    for index,name in ipairs(opt.avail_choices) do
      if opt.value == name then
        opt.choice_selection = index
        goto continuelabel
      end
    end
    error("Option value " .. opt.value .. " not in available choices for " .. opt.name .. "!\n")
    ::continuelabel::
  end
  
  -- no need to call ob_update_all
  -- (nothing ever depends on custom options)
end

function ob_mod_enabled(name)
  local mod = OB_MODULES[name]
  if not mod then
    gui.printf("ob_mod_enabled: Ignoring unknown module: %s\n", name)
    return 0
  else
    if mod.enabled and mod.valid then return 1 else return 0 end
  end
end

function ob_add_language(langcode, fullname)

  assert(langcode and fullname)
  table.insert(UI_OPTIONS.LANGUAGES, langcode)
  table.insert(UI_OPTIONS.LANGUAGES, fullname)

end

function ob_set_config(name, value)
  -- See the document 'doc/Config_Flow.txt' for a good
  -- description of the flow of configuration values
  -- between the C++ GUI and the Lua scripts.

  assert(name and value)

  if name == "seed" then
    OB_CONFIG[name] = value
    return
  end

  -- check all the UI modules for a matching option
  -- [ this is only needed when parsing the CONFIG.txt file ]
  for _,mod in pairs(OB_MODULES) do
    if ob_check_ui_module(mod) then
      for _,opt in pairs(mod.options) do
        if opt.name == name then
          ob_set_mod_option(mod.name, name, value)
          OB_CONFIG[name] = value
          return
        end
      end
    end
  end


  if OB_CONFIG[name] and OB_CONFIG[name] == value then
    return -- no change
  end


  -- validate some important variables
  if name == "game" then
      assert(OB_CONFIG.game)
      if not OB_GAMES[value] then
        gui.printf("Ignoring unknown game: %s\n", value)
        return
      end
  elseif name == "port" then
    assert(OB_CONFIG.port)
    if not OB_PORTS[value] then
      gui.printf("Ignoring unknown port: %s\n", value)
      return
    end
  elseif name == "theme" then
    assert(OB_CONFIG.theme)
    if not OB_THEMES[value] then
      gui.printf("Ignoring unknown theme: %s\n", value)
      return
    end
  end

  OB_CONFIG[name] = value

  if name == "game" or name == "port" then
    ob_update_all()
  end

end



function ob_read_all_config(need_full, log_only)
   
  local function do_line(fmt, ...)
    if log_only then
      gui.printf(fmt .. "\n", ...)
    else
      gui.config_line(string.format(fmt, ...))
    end
  end

  local function do_value(name, value)
    do_line("%s = %s", name, value or "XXX")
  end

  local function do_mod_value(name, value)
    do_line("  %s = %s", name, value or "XXX")
  end

  ---| ob_read_all_config |---

  -- workaround for a limitation in C++ code
  if need_full == "" then
     need_full = false
  end

  do_line("-- Obsidian (C) 2018-2023")
  do_line("-- MsrSgtShooterPerson")
  do_line("-- Reisal")
  do_line("-- Garrett")
  do_line("-- Caligari87")
  do_line("-- Frozsoul")
  do_line("-- Simon-v")
  do_line("-- Beed28")
  do_line("-- Craneo")
  do_line("-- MogWaltz")
  do_line("-- EpicTyphlosion")
  do_line("-- Tapwave")
  do_line("-- Swedra")
  do_line("-- Demios")
  do_line("-- Scionox")
  do_line("-- josh771")
  do_line("-- dashodanger")
  do_line("-- Phytolizer")
  do_line("-- HugLifeTiZ\n")
  do_line("-- Cubebert\n")
  do_line("-- Morthimer McMare\n")
  do_line("-- ika707\n")
  do_line("-- Chameleon_111\n")
  do_line("-- hytalego\n")
  do_line("-- Twin Galaxy\n")
  do_line("-- WolVexus\n")
  do_line("-- username\n")
  do_line("-- Dan_The_Noob\n")
  do_line("-- Il Str\n")
  do_line("-- VoidRunner\n")
  do_line("-- 4ffy\n")
  do_line("-- DasCake\n")
  do_line("-- Baysha\n")
  do_line("-- Arcterezion\n")
  do_line("-- Xenamta\n")
  do_line("-- KadKad1\n")
  do_line("-- DaveFriedLiver\n")
  do_line("-- https://github.com/obsidian-level-maker/Obsidian/\n")

  if OB_CONFIG.seed ~= nil then
    do_line("seed = " .. OB_CONFIG.seed)
    do_line("")
  end

  do_line("---- Game Settings ----")
  do_line("")

  do_value("output_path", OB_CONFIG.output_path)
  do_line("")

  do_value("game",     OB_CONFIG.game)
  do_value("port",     OB_CONFIG.port)
  do_value("length",   OB_CONFIG.length)
  do_value("theme",    OB_CONFIG.theme)

  do_line("")

  -- the UI modules/panels use bare option names
  for _,name in pairs(table.keys_sorted(OB_MODULES)) do
    local def = OB_MODULES[name]

    if ob_check_ui_module(def) then
      do_line("---- %s ----", def.label)
      do_line("")

      for _,opt in pairs(def.options) do
        if OB_CONFIG[opt.name] then
          do_value(opt.name, OB_CONFIG[opt.name])
        else
          do_value(opt.name, opt.default)
          ob_set_config(opt.name, opt.default)
        end
      end

      do_line("")
    end
  end

  do_line("---- Other Modules ----")
  do_line("")

  for _,name in pairs(table.keys_sorted(OB_MODULES)) do
    local def = OB_MODULES[name]

    if ob_check_ui_module(def) then goto continuelabel end

    if not need_full and not def.valid then goto continuelabel end

    do_line("@%s = %s", name, sel(def.enabled, "1", "0"))

    -- module options
    if need_full or def.enabled then
      if def.options and not table.empty(def.options) then
        if def.options[1] then
          for _,opt in pairs(def.options) do
            if OB_CONFIG[opt.name] then
              do_mod_value(opt.name, OB_CONFIG[opt.name])
            else
              do_mod_value(opt.name, opt.default)
              ob_set_config(opt.name, opt.default)
            end
          end
        else
          for o_name,opt in pairs(def.options) do
            if OB_CONFIG[opt.name] then
              do_mod_value(o_name, OB_CONFIG[opt.name])
            else
              do_mod_value(o_name, opt.default)
              ob_set_config(o_name, opt.default)
            end
          end
        end
      end
    end

    do_line("")
    ::continuelabel::
  end

  do_line("-- END --")
end



function ob_load_game(game)
  -- 'game' parameter must be a sub-directory of the games/ folder

  -- ignore the template game -- it is only instructional
  if game == "template" then return end

  gui.debugf("  %s\n", game)

  gui.set_import_dir("games/" .. game)

  -- the base script will import even more script files
  gui.import("base")

  gui.set_import_dir("")
end


function ob_load_all_games()

  local list = gui.scan_directory("games", "DIRS")

  if not list then
    error("Failed to scan 'games' directory")
  end

  if OB_CONFIG.only_game then
    gui.printf("Only loading one game: '%s'\n", OB_CONFIG.only_game)
    ob_load_game(OB_CONFIG.only_game)
  else
    for _,game in pairs(list) do
      ob_load_game(game)
    end
  end

  if table.empty(OB_GAMES) then
    error("Failed to load any games at all")
  end
end

function ob_load_all_ports()

  local list = gui.scan_directory("ports", "*.lua")

  if not list then
    gui.printf("FAILED: scan 'ports' directory\n")
    return
  end

  gui.set_import_dir("ports")

  for _,filename in pairs(list) do
    gui.debugf("  %s\n", filename)
    gui.import(filename)
  end

  gui.set_import_dir("")
end

function ob_load_all_modules()

  local list = gui.scan_directory("modules", "*.lua")
  local subdirs = gui.scan_directory("modules", "DIRS")

  if not list then
    gui.printf("FAILED: scan 'modules' directory\n")
    return
  end

  gui.set_import_dir("modules")

  for  _,filename in pairs(list) do
    gui.debugf("  %s\n", filename)
    gui.import(filename)
  end

  if subdirs then
    for _,directory in pairs(subdirs) do
      list = gui.scan_directory("modules/" .. directory, "*.lua")
      if not list then
        gui.printf("FAILED: scan 'modules' subdirectory\n")
        return
      end
      gui.set_import_dir("modules/" .. directory)
      for _,filename in pairs(list) do
        gui.debugf("  %s\n", filename)
        gui.import(filename)
      end
    end
  end

  gui.set_import_dir("")
end

function ob_init()

  -- the missing print functions
  gui.printf = function (fmt, ...)
    if fmt then gui.raw_log_print(string.format(fmt, ...)) end
  end

  gui.debugf = function (fmt, ...)
    if fmt then gui.raw_debug_print(string.format(fmt, ...)) end
  end

  gui.printf("****************************\n")
  gui.printf("** Obsidian (C) 2018-2025 **\n")
  gui.printf("****************************\n")
  gui.printf("|    A Creation of the     |\n")
  gui.printf("|        Community         |\n")
  gui.printf("\\__________________________/\n\n")
  gui.printf("    MsrSgtShooterPerson\n")
  gui.printf("          Reisal\n")
  gui.printf("          Garrett\n")
  gui.printf("         Caligari87\n")
  gui.printf("          Frozsoul\n")
  gui.printf("          Simon-v\n")
  gui.printf("           Beed28\n")
  gui.printf("          Craneo\n")
  gui.printf("          MogWaltz\n")
  gui.printf("      EpicTyphlosion\n")
  gui.printf("          Tapwave\n")
  gui.printf("          Swedra\n")
  gui.printf("          Demios\n")
  gui.printf("          Scionox\n")
  gui.printf("          josh771\n")
  gui.printf("        dashodanger\n")
  gui.printf("        Phytolizer\n")
  gui.printf("        HugLifeTiZ\n")
  gui.printf("         Cubebert\n")
  gui.printf("     Morthimer McMare\n")
  gui.printf("          ika707\n")
  gui.printf("       Chameleon_111\n")
  gui.printf("         hytalego\n")
  gui.printf("        Twin Galaxy\n")
  gui.printf("         WolVexus\n")
  gui.printf("         username\n")
  gui.printf("       Dan_The_Noob\n")
  gui.printf("         Il Str\n")
  gui.printf("        VoidRunner\n")
  gui.printf("          4ffy\n")
  gui.printf("         DasCake\n")
  gui.printf("         Baysha\n")
  gui.printf("        Arcterezion\n")
  gui.printf("         Xenamta\n")
  gui.printf("         KadKad1\n")
  gui.printf("         DaveFriedLiver\n")
  gui.printf("    And All of Our Fans!\n\n")
  gui.printf("--------------------------------------------\n")
  gui.printf("-- https://github.com/obsidian-level-maker/Obsidian/ --\n")
  gui.printf("--------------------------------------------\n\n")

  gui.printf("~~ Obsidian Lua initialization begun ~~\n\n")

  -- load detected languages (needs to be done fairly early)
  UI_OPTIONS = {}
  UI_OPTIONS.LANGUAGES = 
  {
    "auto", _("AUTO")
  }
  gui.populate_languages()

  -- load definitions for all games

  gui.printf("Loading all games...\n")
  ob_load_all_games()
  gui.printf("Loading all ports...\n")
  ob_load_all_ports()
  gui.printf("Loading all modules...\n")
  ob_load_all_modules()

  table.name_up(OB_GAMES)
  table.name_up(OB_PORTS)
  table.name_up(OB_THEMES)
  table.name_up(OB_MODULES)


  local function preinit_all(DEFS)
    local removed = {}

    for name,def in pairs(DEFS) do
      if def.preinit_func then
        if def.preinit_func(def) == REMOVE_ME then
          table.insert(removed, name)
        end
      end
    end

    for _,name in pairs(removed) do
      DEFS[name] = nil
    end
  end

  preinit_all(OB_GAMES)
  preinit_all(OB_PORTS)
  preinit_all(OB_THEMES)
  preinit_all(OB_MODULES)

  local function create_buttons(what, DEFS)
    assert(DEFS)
    gui.debugf("creating buttons for %s\n", what)

    local list = nil

    if what == "port" then
      list = UI_BUILD.PORTS
    elseif what == "game" then
      list = UI_BUILD.GAMES
    elseif what == "theme" then
      list = UI_BUILD.THEMES
    elseif what == "length" then
      list = UI_BUILD.LENGTHS
    else
      return
    end

    if what == "length" then
      for _,item in ipairs(LENGTH_CHOICES) do
        table.insert(list, item)
      end
    else
      for _,def in pairs(DEFS) do
        assert(def.name and def.label)
        table.insert(list, def.name)
        table.insert(list, def.label)
      end
    end

    -- We need to set defaults manually here because the associated
    -- modules/options have not been populated at this stage. They will
    -- be changed to existing config settings later
    if what == "port" then
      assert(table.has_elem(UI_BUILD.PORTS, "boom"))
      OB_CONFIG.port = "boom"
    elseif what == "game" then
      assert(table.has_elem(UI_BUILD.GAMES, "doom2"))
      OB_CONFIG.game = "doom2"
    elseif what == "theme" then
      assert(table.has_elem(UI_BUILD.THEMES, "original"))
      OB_CONFIG.theme = "original"
    elseif what == "length" then
      assert(table.has_elem(UI_BUILD.LENGTHS, "game"))
      OB_CONFIG.length = "game"
    end

  end

  local function create_mod_options()
    gui.debugf("creating module options\n", what)

    for _,mod in pairs(OB_MODULES) do
      if not mod.options then
        mod.options = {}
      else
        local list = mod.options

        -- handle lists (for UI modules) different from key/value tables
        if list[1] == nil then
          list = {}

          for name,opt in pairs(mod.options) do
            opt.name = name
            table.insert(list, opt)
          end
        end

        for _,opt in pairs(list) do
          assert(opt.label)        
          assert(opt.choices)
                  
          -- select a default value
          if not opt.default then
            if table.has_elem(opt.choices, "default") then opt.default = "default"
            elseif table.has_elem(opt.choices, "normal")  then opt.default = "normal"
            elseif table.has_elem(opt.choices, "medium")  then opt.default = "medium"
            elseif table.has_elem(opt.choices, "mixed")   then opt.default = "mixed"
            else   opt.default = opt.choices[1]
            end
          end
          opt.avail_choices = {}
          if nk ~= nil then
            opt.avail_labels  = {}
          end

          for i = 1,#opt.choices,2 do
            local id    = opt.choices[i]
            local label = opt.choices[i+1]
            opt.avail_choices[#opt.avail_choices+1] = id
            if nk ~= nil then
              opt.avail_labels[#opt.avail_labels+1] = label
            end
          end
          opt.value = opt.default
          if nk ~= nil then
            for index,name in ipairs(opt.avail_choices) do
              if opt.value == name then
                opt.choice_selection = index
                goto continuelabel
              end
            end
            error("Option value " .. opt.value .. " not in available choices for " .. opt.name .. "!\n")
            ::continuelabel::
          end
        end -- for opt
      end
    end -- for mod
  end


  OB_CONFIG.seed = nil

  create_buttons("game",   OB_GAMES)
  create_buttons("port",   OB_PORTS)
  create_buttons("theme",  OB_THEMES)
  create_buttons("length", LENGTH_CHOICES)

  create_buttons("module", OB_MODULES)
  create_mod_options()

  ob_update_all()

  gui.printf("\n~~ Completed Lua initialization ~~\n\n")

  OB_BUILD_STATUS = _("Ready")
end



function ob_game_format()
  assert(OB_CONFIG)
  assert(OB_CONFIG.game)

  local game = OB_GAMES[OB_CONFIG.game]

  assert(game)

  if game.extends then
    game = assert(OB_GAMES[game.extends])
  end

  return assert(game.format)
end

function ob_get_string_param(parameter)

  assert(parameter)

  local param

  if OB_CONFIG[parameter] then
    param = OB_CONFIG[parameter]
  else
    error("ob_get_string_param: MISSING PARAMETER " .. parameter)
  end
  
  if type(param) == "string" then
    return param
  else
    return tostring(param)
  end
  
end

function ob_get_bool_param(parameter)

  assert(parameter)

  local param = nil

  if OB_CONFIG[parameter] then
    param = OB_CONFIG[parameter]
  else
    return 0
  end
  
  assert(param and (param == "yes" or param == "no"))

  if param == "yes" then
    return 1
  else
    return 0
  end
  
end

function ob_hexen_ceiling_check(thing_id)

  assert(thing_id)

  local on_ceiling = 0

  for _, ent in pairs(GAME.ENTITIES) do 
    if ent.id == tonumber(thing_id) then
        if ent.ceil and ent.ceil == true then
          on_ceiling = 1
        end
        goto continuelabel
    end
  end
  ::continuelabel::
  
  return on_ceiling

end

function ob_get_password()

  local pass_chars = 
  {
    "1","2","3","4","5","6","7","8","9","0","q","w","e","r","t","y","u","i","o","p","[","]","\\",
    "a","s","d","f","g","h","j","k","l",";","'","z","x","c","v","b","n","m",",",".","/","!","@",
    "#","$","^","&","*","(",")","_","+","Q","W","E","R","T","Y","U","I","O","P","{","}","|",
    "A","S","D","F","G","H","J","K","L",":","Z","X","C","V","B","N","M","<",">","?","\""
  }

  pass_string = ""
  for i=1,20 do
    pass_string = pass_string .. rand.pick(pass_chars)
  end
  return pass_string

end

function ob_get_random_words()
  
  RANDOM_WORDS = nil

  if OB_CONFIG.mature_words == "yes" then
    RANDOM_WORDS = RANDOM_WORDS_EN_M
  else 
    RANDOM_WORDS = RANDOM_WORDS_EN
  end

  local function case_randomizer(random_word)

    local case_odds =
    {
      default = 40,
      capitalized = 30,
      all_caps = 15,
      alternating = 5
    }
    
    local case_pick = rand.key_by_probs(case_odds)

    if case_pick == "default" then
      return random_word
    elseif case_pick == "capitalized" then
      return string.upper(string.sub(random_word, 1, 1)) .. string.sub(random_word, 2)
    elseif case_pick == "all_caps" then
      return string.upper(random_word)
    else
      local alt_string = ""
      for i = 1, #random_word do
        local c = string.sub(random_word, i,i)
        if i % 2 == 0 then
          alt_string = alt_string .. string.upper(c)
        else
          alt_string = alt_string .. c
        end
      end
      return alt_string
    end 
  end

  local numwords = rand.irange(1, 3)

  if numwords == 1 then
    return case_randomizer(rand.pick(RANDOM_WORDS))
  elseif numwords == 2 then
    return case_randomizer(rand.pick(RANDOM_WORDS)) .. " " .. case_randomizer(rand.pick(RANDOM_WORDS))
  else
    return case_randomizer(rand.pick(RANDOM_WORDS)) .. " " .. case_randomizer(rand.pick(RANDOM_WORDS)) .. " " .. case_randomizer(rand.pick(RANDOM_WORDS))
  end
end

function ob_get_random_phrase()
  if OB_CONFIG.password_mode == "yes" then
    return ob_get_password()
  else
    return ob_get_random_words()
  end
end

function ob_default_filename()
  -- create a default filename [ WITHOUT any extension ]

  assert(OB_CONFIG)
  assert(OB_CONFIG.game)
  
  -- I don't like doing this, but I'd rather not try to reorder
  -- the normal GAME table merge stuff - Dasho
  if ob_match_game({game = {wolf=1, spear=1, noah=1, obc=1}}) then
    return "unused.filename"
  else
    local name_tab = {}
    if ob_match_game({game = "doomish"}) then
      name_tab = DOOM.NAMES
    elseif OB_CONFIG.game == "heretic" then
      name_tab = HERETIC.NAMES
    end
    Naming_init(name_tab)
  end

  OB_CONFIG.title = Naming_grab_one("TITLE")
  GAME.title = OB_CONFIG.title

  -- massage into a usable filename
  local str = string.lower(OB_CONFIG.title)

  str = string.gsub(str, "%p", "")
  str = string.gsub(str, " ", "_")
  str = string.gsub(str, ":", "")
  str = string.gsub(str, "'", "")
  str = string.gsub(str, ",", "")
  
  if OB_CONFIG.filename_prefix == "none" then
    return str
  else
    
    local formatstring

    if OB_CONFIG.filename_prefix == "datetime" then
      formatstring = ob_datetime_format_string() .. "_"
    elseif OB_CONFIG.filename_prefix == "game" then
      formatstring = OB_CONFIG.game .. "_"
    end
   
    return formatstring .. str .. ".wad"
   
  end
 
 ::continuelabel::
 
end


------------------------------------------------------------------------


function ob_merge_tab(name, tab)
  assert(name and tab)

  if not GAME[name] then
    GAME[name] = table.deep_copy(tab)
    return
  end

  -- support replacing _everything_
  -- [ needed mainly for Doom 1 themes ]
  if tab.replace_all then
    GAME[name] = {}
  end

  table.merge_w_copy(GAME[name], tab)

  GAME[name].replace_all = nil
end


function ob_merge_table_list(tab_list)
  for _,GT in ipairs(tab_list) do
    assert(GT)
    for name,tab in pairs(GT) do
      -- upper-case names should always be tables to copy
      if string.match(name, "^[A-Z]") then
        if type(tab) ~= "table" then
          error("Game field not a table: " .. tostring(name))
        end
        ob_merge_tab(name, tab)
      end
    end
  end
end



function ob_add_current_game()
  local function recurse(name, child)
    local def = OB_GAMES[name]

    if not def then
      error("UNKNOWN GAME: " .. name)
    end

    -- here is the tricky bit : by recursing now, we can process all the
    -- definitions in the correct order (children after parents).

    if def.extends then
      recurse(def.extends, def)
    end

    if def.tables then
      ob_merge_table_list(def.tables)
    end

    if child and def.hooks then
      child.hooks = table.merge_missing(child.hooks or {}, def.hooks)
    end

    for _,keyword in pairs({ "format", "sub_format", "game_dir" }) do
      if def[keyword] ~= nil then
        GAME[keyword] = def[keyword]
      end
    end

    return def
  end

  table.insert(GAME.modules, 1, recurse(OB_CONFIG.game))
end



function ob_add_current_port()
  local function recurse(name, child)
    local def = OB_PORTS[name]

    if not def then
      error("UNKNOWN PORT: " .. name)
    end

    if def.extends then
      recurse(def.extends, def)
    end

    if def.tables then
      ob_merge_table_list(def.tables)
    end

    if child and def.hooks then
      child.hooks = table.merge_missing(child.hooks or {}, def.hooks)
    end

    return def
  end

  table.insert(GAME.modules, 2, recurse(OB_CONFIG.port))
end



function ob_sort_modules()
  GAME.modules = {}

  -- find all the visible & enabled modules
  -- [ ignore the special UI modules/panels ]

  for _,mod in pairs(OB_MODULES) do
    if mod.enabled and mod.valid and not ob_check_ui_module(mod) then
      table.insert(GAME.modules, mod)
    end
  end

  -- sort them : lowest -> highest priority, because later
  -- entries can override things done by earlier ones.

  local function module_sorter(A, B)
    if A.priority or B.priority then
      return (A.priority or 50) < (B.priority or 50)
    end

    return A.label < B.label
  end

  if #GAME.modules > 1 then
    table.sort(GAME.modules, module_sorter)
  end
end



function ob_invoke_hook(name, ...)
  -- two passes, for example: setup and setup2,
  for pass = 1,2 do
    if string.match(name, "^pre_setup") then goto skip end
    for _,mod in pairs(GAME.modules) do
      local func = mod.hooks and mod.hooks[name]
      if func then
        func(mod, ...)
      end
    end
    ::skip::
    for _,mod in pairs(OB_MODULES) do
      if ob_check_ui_module(mod) then
       local func = mod.hooks and mod.hooks[name]

        if func then
          func(mod, ...)
        end
      end
    end
    name = name .. "2"
  end
end

function ob_invoke_hook_with_table(name, local_table)
  for _,mod in pairs(GAME.modules) do
    local func = mod.hooks and mod.hooks[name]
    if func then
      func(mod, local_table)
    end
  end
  
  for _,mod in pairs(OB_MODULES) do
    if ob_check_ui_module(mod) then
      local func = mod.hooks and mod.hooks[name]
      if func then
        func(mod, local_table)
      end
    end
  end
end

function ob_build_setup()
  ob_clean_up()

  if OB_CONFIG.title then
    GAME.title = OB_CONFIG.title
  end

  ob_sort_modules()

  -- first entry in module list *must* be the game def, and second entry
  -- must be the engine definition.  NOTE: neither are real modules!
  ob_add_current_game()
  ob_add_current_port()

  -- merge tables from each module
  -- [ but skip GAME and PORT, which are already merged ]

  for index,mod in pairs(GAME.modules) do
    if index > 2 and mod.tables then
      ob_merge_table_list(mod.tables)
    end
  end

  local game_params = assert(GAME.PARAMETERS)

  table.merge_missing(game_params, GLOBAL_PARAMETERS)

  Naming_init(GAME.NAMES)

  ob_invoke_hook("setup")

  Fab_load_all_definitions()

  table.name_up(GAME.THEMES)
  table.name_up(GAME.ROOM_THEMES)

  for _,grammar in pairs(SHAPES) do
    Grower_preprocess_grammar(grammar)
  end

  if GAME.sub_format then
    gui.property("sub_format", GAME.sub_format)
  end

  gui.property("spot_low_h",  GLOBAL_PARAMETERS.spot_low_h)
  gui.property("spot_high_h", GLOBAL_PARAMETERS.spot_high_h)
end



function ob_clean_up()
  for _,k in pairs (GAME) do
    GAME[k] = nil
  end
  for _,k in pairs (THEME) do
    THEME[k] = nil
  end
  for _,k in pairs (STYLE) do
    STYLE[k] = nil
  end
  for _,k in pairs (SCRIPTS) do
    SCRIPTS[k] = nil
  end
  GAME   = nil
  THEME  = nil
  STYLE  = nil
  SCRIPTS = nil
  EPISODE = nil
  PREFABS = nil
  PREFABS_FULL = nil
  SEEN_ROOM_THEMES = nil
  SEEN_WALL_GROUPS = nil
  AMBIENT_SOUND_DEFS = nil

  if OB_CONFIG.seed ~= nil then
    table.remove(OB_CONFIG, seed)
  end

  collectgarbage("collect")
  collectgarbage("collect")
  GAME   = {}
  THEME  = {}
  STYLE  = {}
  SCRIPTS = {}
  SEEN_ROOM_THEMES = {}
  SEEN_WALL_GROUPS = {}
  if OB_CONFIG.sky_generator_active == true then
    gui.fsky_free()
  end
  AMBIENT_SOUND_DEFS = {}
end

local PROFILING = false

function ob_build_cool_shit()
  local profiler
  if PROFILING then
    package.path = package.path .. ";./scripts/?.lua"
    profiler = require("profiler")
    profiler.start()
  end

  assert(OB_CONFIG)
  assert(OB_CONFIG.game)

  gui.printf("\n\n")
  gui.printf(gui.gettext("~~~~~~~ Making Levels ~~~~~~~\n\n"))
  gui.printf("-- CONFIG FILE : OBSIDIAN Beta\n\n") -- Do not translate; needed by config parser
    
  ob_read_all_config(false, "log_only")

  gui.start_it()

  coroutine.yield()

  ob_build_setup()

  status = Level_make_all()

  ob_clean_up()

  gui.printf("\n")

  if status == "abort" then
    gui.printf("\n")
    gui.printf(gui.gettext("~~~~~~~ Build Aborted! ~~~~~~~\n\n"))
    return "abort"
  end

  gui.printf("\n")
  gui.printf(gui.gettext("~~~~~~ Finished Making Levels ~~~~~~\n\n"))

  if PROFILING then
    profiler.stop()
    profiler.report("profile.log")
  end

  OB_BUILD_STATUS = _("Building Nodes")
  coroutine.yield()

  gui.finish_it()

  OB_BUILD_STATUS = _("Success")
  coroutine.yield()

  return "ok"
end

function ob_cli_loop()
  coroutine.resume(OB_BUILD_ROUTINE)
  while OB_BUILD_ROUTINE ~= nil and coroutine.status(OB_BUILD_ROUTINE) ~= "dead" do
    gui.console_print(OB_BUILD_STATUS .. "\n")
    coroutine.resume(OB_BUILD_ROUTINE)
  end
  assert(OB_BUILD_ROUTINE == nil or coroutine.status(OB_BUILD_ROUTINE) == "dead")
  OB_BUILD_ROUTINE = nil
end

function ob_do_build()
  assert(OB_BUILD_ROUTINE == nil)
  OB_BUILD_ROUTINE = coroutine.create(ob_build_cool_shit)
  if OB_NK_CTX == nil then
    ob_cli_loop()
  end
end
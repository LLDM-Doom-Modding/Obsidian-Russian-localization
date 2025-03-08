------------------------------------------------------------------------
--  PANEL: Architecture
------------------------------------------------------------------------
--
--  Copyright (C) 2016-2017 Andrew Apted
--  Copyright (C) 2019 Reisal
--  Copyright (C) 2019-2022 MsrSgtShooterPerson
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

UI_ARCH = { }

--[[UI_ARCH.ZDOOM_VISTA_CHOICES =
{
  "enable",        _("Enable"),
  "sky_gen_smart", _("Sky-gen Smart"),
  "disable",       _("Disable")
}

UI_ARCH.ZDOOM_SKYBOX_CHOICES =
{
  "themed",   _("Per Theme"),
  "episodic", _("Episodic"),
  "random",   _("Random"),
  "generic",  _("Generic"),
  "disable",  _("Disable")
}]]--

UI_ARCH.SIZES =
{
  "epi",     _("Episodic"),
  "prog",    _("Progressive"),
  "mixed",   _("Mix It Up"),
  "10",      _("Microscopic"),
  "16",      _("Miniscule"),
  "22",      _("Tiny"),
  "30",      _("Small"),
  "36",      _("Average"),
  "42",      _("Large"),
  "48",      _("Huge"),
  "58",      _("Colossal"),
  "66",      _("Gargantuan"),
  "75",      _("Transcendent"),
}

UI_ARCH.SIZE_BOUNDS =
{
  "10",      _("Microscopic"),
  "16",      _("Miniscule"),
  "22",      _("Tiny"),
  "30",      _("Small"),
  "36",      _("Average"),
  "42",      _("Large"),
  "48",      _("Huge"),
  "58",      _("Colossal"),
  "66",      _("Gargantuan"),
  "75",      _("Transcendent"),
}

UI_ARCH.RAMP_FACTOR =
{
  "0.5",  _("Very Fast Curve"),
  "0.66", _("Fast Curve"),
  "1.0",  _("Linear"),
  "1.5",  _("Slow Curve"),
  "2.0",  _("Very Slow Curve"),
}

UI_ARCH.LIGHT_FACTOR =
{
  "0.5",  _("Doom 3"),
  "0.75", _("Darker"),
  "1.0",  _("Default"),
  "1.25", _("Brighter"),
  "1.5",  _("GG Retinas"),
}

OB_MODULES["ui_arch"] =
{
  name = "ui_arch",

  label = _("Architecture"),
    
  side = "left",
  priority = 104,
  engine = "!idtech_0",
  where = "arch",

  hooks = 
  {
  },

  options =
  {
    { 
      name="level_size", 
      label=_("Level Size"),
      choices = UI_ARCH.SIZES,
      default = "epi",
      tooltip = _("Determines size of map (Width x Height) in grid squares."),
      longtip = _("If you are planning to generate Binary format maps at sizes of 50 and above, Autodetailing will be enabled by default. The stability of maps with sizes 60 and beyond is not predictable unless using UDMF map format (supported engines only)."),
      priority = 100,
    },

    {
      name = "level_size_upper_bound",
      label = _("Upper Bound"),
      choices = UI_ARCH.SIZE_BOUNDS,
      default = "75",
      tooltip = _("Fine tune upper limit when Level Size is set to Episodic, Progressive or Mixed."),
      priority = 99,
    },


    {
      name = "level_size_lower_bound",
      label = _("Lower Bound"),
      choices = UI_ARCH.SIZE_BOUNDS,
      default = "10",
      tooltip = _("Fine tune lower limit when Level Size is set to Episodic, Progressive or Mixed."),
      priority = 98,
      gap = 1,
    },


    {
      name = "level_size_ramp_factor",
      label = _("Ramp Factor"),
      tooltip = _("Determines how fast or slow larger level sizes are reached in Progressive/Episodic mode."),
      longtip = _("Very Fast Curve: Reach half-size at 1/4th of the game.\nFast Curve: Reach half-size at 1/3rds.\nLinear: Reach half-size at half the game.\nSlow Curve: Reach half-size at 2/3rds.\nVery Slow Curve: Reach half-size at 3/4ths.\n\nObsidian default is Fast Curve."),
      choices = UI_ARCH.RAMP_FACTOR,
      default = "0.66",
      priority = 97,      
    },

    {
      name = "overall_lighting_mult",
      label = _("Lighting Multiplier"),
      priority = 80,
      choices = UI_ARCH.LIGHT_FACTOR,
      default = "1.0",
      tooltip = _("Adjust overall map lighting"),
      longtip = _("This will apply a multiplier to the values in the default lighting tables when determining the brightness level of a room.")
    },

    { name="outdoors",     
    label=_("Outdoors"),   choices=STYLE_CHOICES, priority = 78,  
    tooltip = _("Control the number of outdoor areas.")
    },
    { name="caves",        
    label=_("Caves"),      choices=STYLE_CHOICES, priority = 77,  
    tooltip = _("Control the number of caves.") 
    },
    { name="liquids",      
    label=_("Liquids"),    choices=STYLE_CHOICES, priority = 76,  
    tooltip = _("Control the amount of liquids.") 
    },
    { name="hallways",     
    label=_("Hallways"),   choices=STYLE_CHOICES, priority = 75,  
    tooltip = _("Control the number of hallways.")
    },
    { name="teleporters",  
    label=_("Teleports"),  choices=STYLE_CHOICES, priority = 74,  
    tooltip = _("Control the number of teleporters.") 
    },
    { name="steepness",    
    label=_("Steepness"),  choices=STYLE_CHOICES, gap=1, priority = 73,  
    tooltip = _("Control the height difference of stairs, lifts, and joiners throughout levels.") 
    },


    --[[{
      name = "zdoom_vista",
      label = _("Bottomless Vistas"),
      choices=UI_ARCH.ZDOOM_VISTA_CHOICES,
      default="disable",
      tooltip = _("This feature allows for vistas that show more of the skybox below the horizon. This does not prevent skybox tiling."),
      longtip = _("Enable - Bottomless vistas can always show. Pick this choice when using 3D Skyboxes.\n\nSky-gen Smart - Bottomless vistas appear only on episodes with no mountain backdrop based on the Sky Generator.\n\nDisable - Old Oblige behavior - no bottomless vistas."),
      priority = 50
    },


    {
      name = "zdoom_skybox",
      label = _("3D Skyboxes"),
      choices=UI_ARCH.ZDOOM_SKYBOX_CHOICES,
      default="disable",
      tooltip = _("Choose if 3D Skyboxes are rendered into levels and their style."),
      longtip = _("This is highly recommended when Bottomless Vistas are enabled."),
      priority = 49
    }]]--
  },
}

--[[

-- WOLF 3D ENGINE MODULE

UI_ARCH_WOLF_3D = { }

UI_ARCH_WOLF_3D.RAMP_FACTOR =
{
  "0.5",  _("Very Fast Curve"),
  "0.66", _("Fast Curve"),
  "1",    _("Linear"),
  "1.5",  _("Slow Curve"),
  "2",    _("Very Slow Curve"),
}

OB_MODULES["ui_arch_wolf_3d"] =
{
  name = "ui_arch_wolf_3d",

  label = _("Architecture"),
    
  -- color = { red = 125, green = 125, blue = 125 }, -- This is an example of setting a custom per-module color - Dasho

  side = "left",
  priority = 104,
  engine = "idtech_0",
  where = "arch",

  hooks = 
  {
  },

  options =
  {

    { 
      name="float_size_wolf_3d", 
      label=_("Level Size"),
      valuator = "slider",
      min = 10,
      max = 75,
      increment = 1,
      default = 36,
      nan = _("Mix It Up,Episodic,Progressive"),
      presets = _("10:10 (Microscopic),16:16 (Miniature),22:22 (Tiny),30:30 (Small),36:36 (Average),42:42 (Large),48:48 (Huge),58:58 (Colossal),66:66 (Gargantuan),75:75 (Transcendent)"),
      tooltip = _("Determines size of map (Width x Height) in grid squares."),
      longtip = _("If you are planning to generate Binary format maps at sizes of 50 and above, Autodetailing will be enabled by default. The stability of maps with sizes 60 and beyond is not predictable unless using UDMF map format (supported engines only)."),
      priority = 100,
      
    },


    {
      name = "float_level_upper_bound_wolf_3d",
      label = _("Upper Bound"),
      valuator = "slider",
      min = 10,
      max = 75,
      increment = 1,
      default = 75,
      presets = _("10:10 (Microscopic),16:16 (Miniature),22:22 (Tiny),30:30 (Small),36:36 (Average),42:42 (Large),48:48 (Huge),58:58 (Colossal),66:66 (Gargantuan),75:75 (Transcendent)"),
      tooltip = _("Fine tune upper limit when Level Size is set to Episodic, Progressive or Mixed."),
      priority = 99,
    },


    {
      name = "float_level_lower_bound_wolf_3d",
      label = _("Lower Bound"),
      valuator = "slider",
      min = 10,
      max = 75,
      increment = 1,
      default = 10,
      presets = _("10:10 (Microscopic),16:16 (Miniature),22:22 (Tiny),30:30 (Small),36:36 (Average),42:42 (Large),48:48 (Huge),58:58 (Colossal),66:66 (Gargantuan),75:75 (Transcendent)"),
      tooltip = _("Fine tune lower limit when Level Size is set to Episodic, Progressive or Mixed."),
      priority = 98,
      gap = 1,
    },


    {
      name = "level_size_ramp_factor_wolf_3d",
      label = _("Ramp Factor"),
      tooltip = _("Determines how fast or slow larger level sizes are reached in Progressive/Episodic mode."),
      longtip = _("Very Fast Curve: Reach half-size at 1/4th of the game.\nFast Curve: Reach half-size at 1/3rds.\nLinear: Reach half-size at half the game.\nSlow Curve: Reach half-size at 2/3rds.\nVery Slow Curve: Reach half-size at 3/4ths.\n\nObsidian default is Fast Curve."),
      choices = UI_ARCH_WOLF_3D.RAMP_FACTOR,
      default = "0.66",
      priority = 97,
      
    },
  },
}

]]--
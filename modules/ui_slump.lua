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

UI_SLUMP = { }

UI_SLUMP.MON_VARIETY =
{
  "normal", _("Normal"),
  "shooters", _("Ranged Only"),
  "noflyzone", _("No Fly Zone"),
}

OB_MODULES["misc_slump"] =
{
  name = "misc_slump",

  label = _("Advanced Architecture"),

  port = "limit_enforcing",

  where = "arch",
  priority = 101,

  hooks =
  {
    setup = UI_SLUMP.setup,
  },

  options =
  {
--[[
    {
      name = "float_bigify_slump",
      label = _("Room Bigification Chance"),
      valuator = "slider",
      units = _("%"),
      min = 0,
      max = 100,
      increment = 1,
      default = 50,
      tooltip = _("% chance that SLUMP will attempt to increase a room's size."),
      
    },
    
    {
      name = "float_forkiness_slump",
      label = _("Forkiness"),
      valuator = "slider",
      units = _("%"),
      min = 0,
      max = 100,
      increment = 1,
      default = 75,
      tooltip = _("% chance that a room will attempt to fork as the level grows."),
      longtip = _("0% should look like a bunch of murder hallways. Forking is not guaranteed to succeed, especially if the Room Bigification Chance is increased."),
      
    },
]]--
    {
      name = "slump_dm_starts",
      label = _("Deathmatch Spawns"),
      choices = YES_NO_CHOICES,
      default = "no",
      tooltip = _("Add Deathmatch starts to generated levels.")
    },
    
    {
      name = "slump_major_nukage",
      label = _("Major Nukage Mode"),
      choices = YES_NO_CHOICES,
      default = "no",
      tooltip = _("Watch your step!"),
      longtip = _("Will fill most rooms with damaging liquids."),
      
    },
  
  },
}


OB_MODULES["ui_slump_mons"] =
{

  name = "ui_slump_mons",

  label = _("Combat"),

  where = "combat",
  priority = 103,
  port = "limit_enforcing",

  hooks = 
  {
    setup = UI_SLUMP.setup,
  },

  options =
  {
    {
      name = "slump_mons",
      label = _("Monster Variety"),
      choices = UI_SLUMP.MON_VARIETY,
      default = "normal",
      tooltip = _("Control what types of monsters are available"),    
    },
  }
}

OB_MODULES["slump_all_nazis"] =
{
  name = "slump_all_nazis",

  label = _("Oops! All Nazis!"),

  where = "combat",
  priority = 102,
  port = "limit_enforcing",
  game = "doom2",
  tooltip = _("Populates the level with only SS troopers. This may expand to include pinkies/the Cyberdemon."),
}

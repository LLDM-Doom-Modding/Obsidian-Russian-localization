----------------------------------------------------------------
--  MODULE: ZDoom Ambient Sound Addon
----------------------------------------------------------------
--
--  Copyright (C) 2019-2022 MsrSgtShooterPerson
--  Copyright (C) 2019-2022 Frozsoul
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
-------------------------------------------------------------------

--  Special thanks to Scionox for assisting with the preliminary build!

---------------------------------
-- How to add your own sounds: --
---------------------------------

-- DECORATE and SNDINFO code are all generated by Oblige.
-- Go to zdoom_sounds.lua to add new data to the table.

-- Each new entry added means Oblige will generate a SNDINFO
-- chunk as well as decorate code for each entry.

-- Thing ID's are dynamically assigned based on the
-- PARAM.snd_start_id selected on the module.

-- The module also handles the actual replacement of sound spot
-- specials (thing 8185) in prefab WAD's with the appropriate
-- sound. See gtd_pic_tec_controlroom fab WAD and Lua def as an example.

-- In order to specify what sound to replace a sound spot with,
-- declare a "sound" field in the prefab Lua def. The sound field
-- can contain a single string pertaining to a sound name in the
-- sound data table, or list of names and probabilities whereas
-- Oblige will randomly pick between each.

-- The actual sound files (OGG, WAV, MP3 etc.) are NOT part of
-- the module and are instead contained in a separate WAD file
-- to be loaded separately during play.

gui.import("zdoom_sounds.lua")

ZDOOM_SOUND = {}

ZDOOM_SOUND.ACTOR_ID_OFFSET_CHOICES =
{
  "20000", _("20000"),
  "22000", _("22000"),
  "24000", _("24000"),
  "26000", _("26000"),
  "28000", _("28000"),
  "30000", _("30000"),
}

ZDOOM_SOUND.SOUND_ACTOR_DENSITY = 5

ZDOOM_SOUND.DEFAULT_A_PLAYSOUND_ARGS = "CHAN_AUTO, 0.5, true"

ZDOOM_SOUND.TEMPLATES =
{
  DEC =
[[actor ACTORNAME IDNUM
{
  +THRUACTORS
  +NOBLOCKMAP
  +NOSECTOR
  +DONTSPLASH
  Scale 0
  Radius 4
  Height 4
  States
  {
    Spawn:
      CAND A 1 A_PlaySound("SOUNDNAME", ARGHS)
      Loop
  }
}
]]
}

function ZDOOM_SOUND.build_lumps()
  local offset_count = tonumber(PARAM.snd_start_id)
  local sndtable = table.deep_copy(ZDOOM_SOUND_DEFS)
  local dec_lump = ""
  SCRIPTS.SNDINFO = ""

  table.name_up(sndtable)

  for _,sound in pairs(sndtable) do

    ZDOOM_SOUND_DEFS[_].id = offset_count

    -- build DECORATE chunk
    local dec_chunk = ZDOOM_SOUND.TEMPLATES.DEC

    dec_chunk = string.gsub(dec_chunk, "ACTORNAME", sound.name)
    dec_chunk = string.gsub(dec_chunk, "IDNUM", offset_count)
    dec_chunk = string.gsub(dec_chunk, "SOUNDNAME", sound.lump)

    if sound.args then
      dec_chunk = string.gsub(dec_chunk, "ARGHS", sound.args)
    else
      dec_chunk = string.gsub(dec_chunk, "ARGHS", ZDOOM_SOUND.DEFAULT_A_PLAYSOUND_ARGS)
    end

    dec_lump = dec_lump .. dec_chunk .. "\n\n"
  
    -- build SNDINFO chunk
    local sndinfo_chunk = sound.lump .. " " .. sound.lump .. "\n"

    if sound.flags then
      sndinfo_chunk = sndinfo_chunk .. " " .. sound.flags .. "\n"
    end

    SCRIPTS.SNDINFO = SCRIPTS.SNDINFO .. sndinfo_chunk .. "\n"

    offset_count = offset_count + 1
  end

  SCRIPTS.decorate = ScriptMan_combine_script(SCRIPTS.decorate, dec_lump)
end

function ZDOOM_SOUND.populate_level_ambience(self, LEVEL)

  if not PARAM.ambient_sounds then
    return
  end

  if LEVEL.prebuilt then
    return
  end

  local level_sound_table = ZDOOM_SOUNDSCAPES[LEVEL.theme_name]

  if not level_sound_table then
    gui.printf("WARNING: No sounds at all for theme " .. LEVEL.theme_name .. ".\n")
    return
  end

  for _,R in pairs(LEVEL.rooms) do

    local room_env = ""

    -- resolve room environment
    -- parks, caves, and steets will override
    -- the contents of building and outdoors
    room_env = R:get_env()
    if R.is_street then
      room_env = "street"
    end

    for _,A in pairs(R.areas) do
      if (A.mode == "floor" or A.mode == "liquid")
      or (R.is_park or R.is_cave) then
        for _,S in pairs(A.seeds) do

          local pick_sound

          local sound_table = level_sound_table[room_env]
          local no_sound = false

          local outdoor_theme

          if rand.odds(5) then

            -- then pick the sound
            if room_env == "building" then
              if not table.empty(sound_table) then
                pick_sound = rand.key_by_probs(sound_table)
              else
                gui.printf("WARNING: No sound for " .. LEVEL.theme_name .. " indoor.\n")
                no_sound = true
              end

            else
            -- special treatment for outdoor and outdoor-ish rooms
            -- as they may be controlled by the Epic environment themes
              outdoor_theme = LEVEL.outdoor_theme

              if not outdoor_theme then outdoor_theme = "temperate" end

              if not table.empty(sound_table[outdoor_theme]) then
                pick_sound = rand.key_by_probs(sound_table[outdoor_theme])
              else
                gui.printf("WARNING: No sound for " .. LEVEL.theme_name .. " " ..
                outdoor_theme .. " " .. room_env .. ".\n")
                no_sound = true
              end
            end

            local final_z
            if S.area then
              if S.area.ceil_h then
                final_z = S.area.ceil_h
              elseif S.area.zone.sky_h then
                final_z = S.area.zone.sky_h
              else
                final_z = 0
              end
            end

            if not no_sound then
              local E = {
                x = S.mid_x,
                y = S.mid_y,
                z = final_z - 8,
                id = ZDOOM_SOUND_DEFS[pick_sound].id
              }
              raw_add_entity(E)
            end

          end
        end
      end
    end
  end
end

function ZDOOM_SOUND.setup(self)
  gui.printf("\n--== Ambient Sound Addons module active ==--\n\n")

  module_param_up(self)

  PARAM.ambient_sounds = true
  ZDOOM_SOUND.build_lumps()
end

function ZDOOM_SOUND.merge_frozsoul_sounds(self)

  if PARAM.bool_merge_frozsoul_sounds == 1 then

    local dir = "data/sounds/"

    for _,sound in pairs(ZDOOM_SOUND_DEFS) do
      gui.wad_insert_file(dir .. sound.lump .. ".ogg", sound.lump)
    end

  end

end

OB_MODULES["zdoom_ambient_sound"] =
{
  label = _("ZDoom: Ambient Sounds"),

  game = "doomish",

  side = "left",

  priority = 69,

  port = "zdoom",

  hooks =
  {
    setup = ZDOOM_SOUND.setup,
    end_level = ZDOOM_SOUND.populate_level_ambience,
    all_done = ZDOOM_SOUND.merge_frozsoul_sounds
  },

  options =
  {
    {
      name = "snd_start_id",
      label=_("DoomEdNum Offset"),
      choices=ZDOOM_SOUND.ACTOR_ID_OFFSET_CHOICES,
      tooltip = _("Selects the starting thing ID for generating ambient sound actors. Use only if you are playing a mod using conflicting Editor Numbers. If you don't know what this is this setting is best left as-is."),
      default = "20000",
    },

    {
      name = "bool_merge_frozsoul_sounds",
      label=_("Merge Frozsoul Sound Pack"),
      valuator = "button",
      default = 1,
      tooltip = _("Merge Frozsoul Ambient Sound Pack sound into generated WAD/PK3"),
      longtip = _("Merge in the sounds from the Frozsoul Ambient Sound Pack, the default set of sounds which this module is designed for. Not necessary if you plan to include the sound pack separately in your launch order."),
    },
  },

  tooltip = _("Adds ambient sound things to fabs, room themes, and environments (WIP). Needs an accompanying sound pack containing corresponding sound files to be included with your Doom launcher."),
}

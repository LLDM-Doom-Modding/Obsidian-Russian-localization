UI_BUILD = {}

UI_BUILD.LENGTHS = 
{
}

UI_BUILD.GAMES =
{ 
}

UI_BUILD.PORTS =
{ 
}

UI_BUILD.THEMES =
{ 
}

OB_MODULES["ui_build"] =
{
  name = "ui_build",

  label = _("Build Options"),
    
  side = "left",
  priority = 104,
  where = "build",

  hooks = 
  {
  },

  options =
  {
    { 
        name="game", 
        label=_("Game"),
        choices = UI_BUILD.GAMES,
        default = "doom2",
        tooltip = _("Selects the game to use"),
        priority = 100,
    },
    { 
        name="port", 
        label=_("Port"),
        choices = UI_BUILD.PORTS,
        default = "boom",
        tooltip = _("Selects the port to use"),
        priority = 100,
    },
    { 
        name="length", 
        label=_("Length"),
        choices = UI_BUILD.LENGTHS,
        default = "game",
        tooltip = _("Selects the length of the generated mapset"),
        priority = 100,
    },
    { 
        name="theme", 
        label=_("Theme"),
        choices = UI_BUILD.THEMES,
        default = "original",
        tooltip = _("Selects the theme of the generated mapset"),
        priority = 100,
    },
  }
}
-- Unlike other modules, UI_OPTIONS and UI_OPTIONS.LANGUAGES are not initialized here;
-- they happen pretty early in ob_init so that the .po file language loading
-- works properly

UI_OPTIONS.FILENAME_PREFIXES = 
{
  "datetime", _("Date and Time"),
  "game",     _("Selected Game"),
  "none",     _("None")
}

UI_OPTIONS.THEMES = 
{
  "default", _("Default")
}

OB_MODULES["ui_options"] =
{
  name = "ui_options",

  label = _("Program Options"),
    
  side = "left",
  priority = 104,
  where = "options",

  hooks = 
  {
  },

  options =
  {
    { 
      name="language", 
      label=_("Locale"),
      choices = UI_OPTIONS.LANGUAGES,
      default = "auto",
      tooltip = _("Selects language to use for the program"),
      priority = 100,
    },
    { 
      name="create_backups", 
      label=_("Backup Files"),
      choices = YES_NO_CHOICES,
      default = "yes",
      tooltip = _("Will backup files if overwriting (using .bak extension)"),
      priority = 100,
    },
    { 
      name="debug_messages", 
      label=_("Add Debug Messages to Log"),
      choices = YES_NO_CHOICES,
      default = "yes",
      tooltip = _("Will write verbose log messages"),
      priority = 100,
    },
    { 
      name="filename_prefix", 
      label=_("Filename Prefix"),
      choices = UI_OPTIONS.FILENAME_PREFIXES,
      default = "datetime",
      tooltip = _("Select the prefix used for randomly generated filenames"),
      priority = 100,
    },
    { 
      name="mature_words", 
      label=_("Use Mature Word List"),
      choices = YES_NO_CHOICES,
      default = "no",
      tooltip = _("Will use bad words lmao"),
      priority = 100,
    },
    { 
      name="password_mode", 
      label=_("Password String Seeds"),
      choices = YES_NO_CHOICES,
      default = "no",
      tooltip = _("Will generate a psuedo-password sequence of characters for seeds"),
      priority = 100,
    },
    { 
      name="ui_theme", 
      label=_("UI Theme"),
      choices = UI_OPTIONS.THEMES,
      default = "default",
      tooltip = _("Choose the theme for the user interface"),
      priority = 100,
    },
  }
}
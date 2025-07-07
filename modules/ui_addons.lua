-- Unlike other modules, UI_ADDONS is not initialized here;
-- this happens pretty early in ob_init so that enabled addons from
-- a loaded config are applied properly

OB_MODULES["ui_addons"] =
{
  name = "ui_addons",

  label = _("Program Addons"),
    
  priority = 104,
  where = "addons",

  hooks = 
  {
  },

  options =
  {
  }
}
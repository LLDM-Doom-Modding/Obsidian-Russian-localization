PREFABS.Item_secret_heatant_coolant_1 =
{
  file = "item/gtd_secrets_pipe_machines.wad",
  map = "MAP01",

  prob = 25,
  theme = "!hell",

  port = "zdoom",

  key = "secret",

  where  = "seeds",
  height = 128,

  seed_w = 2,
  seed_h = 2,

  deep = 16,
  over = -16,

  bound_z1 = 0,
  bound_z2 = 128,

  x_fit = {68,72 , 84,92 , 104,108},
  y_fit = "top"
}

PREFABS.Item_secret_heatant_coolant_2 =
{
  template = "Item_secret_heatant_coolant_1",
  map = "MAP02",

  x_fit = {36,52 , 204,220},
  y_fit = "top"
}

PREFABS.Item_secret_wire_spools =
{
  template = "Item_secret_heatant_coolant_1",
  map = "MAP03",

  x_fit = {52,76},
  y_fit = "top"
}

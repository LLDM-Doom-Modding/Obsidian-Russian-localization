PREFABS.Pic_gtd_door_storage_1 =
{
  file = "picture/gtd_pic_industrial_door_storage.wad",
  map = "MAP01",

  prob = 50,
  group = "gtd_door_storage",

  where  = "seeds",
  height = 96,

  seed_w = 2,
  seed_h = 1,

  deep = 16,

  bound_z1 = 0,
  bound_z2 = 96,

  x_fit = {96,128 , 192,224},
  y_fit = "top"
}

PREFABS.Pic_gtd_door_storage_2 =
{
  template = "Pic_gtd_door_storage_1",
  map = "MAP02",

  x_fit = {84,92 , 164,172}
}

PREFABS.Pic_gtd_door_storage_3 =
{
  template = "Pic_gtd_door_storage_1",
  map = "MAP03",

  seed_w = 3,

  x_fit = {168,216}
}

PREFABS.Pic_gtd_door_storage_4 =
{
  template = "Pic_gtd_door_storage_1",
  map = "MAP04",

  seed_w = 2,

  x_fit = {28,36 , 60,68 , 92,104 , 204,212}
}

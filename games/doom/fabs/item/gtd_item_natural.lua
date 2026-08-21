PREFABS.Item_natural_closet_1 =
{
  file  = "item/gtd_item_natural.wad",
  map = "MAP01",

  prob = 350,

  where  = "seeds",
  seed_w = 2,
  seed_h = 1,

  group = "natural_walls",

  height = 96,

  deep = 16,

  bound_z1 = 0,
  bound_z2 = 96,

  z_fit = "top"
}

PREFABS.Item_natural_closet_2 =
{
  template = "Item_natural_closet_1",
  map = "MAP02",
}

PREFABS.Item_natural_closet_3 =
{
  template = "Item_natural_closet_1",
  map = "MAP03",

  height = 128,

  bound_z2 = 128
}

PREFABS.Item_natural_closet_4 =
{
  template = "Item_natural_closet_1",
  map = "MAP04",

  height = 128,

  bound_z2 = 128,

  z_fit = { 118,120 , 122,124 }
}

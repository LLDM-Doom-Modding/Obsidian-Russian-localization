--
-- Yes, I am aware I am a bad person.
--

PREFABS.Item_closet_toilet_room =
{
  file   = "item/gtd_item_closet_toilet.wad",
  map    = "MAP01",

  port = "!zdoom",

  prob   = 100,
  theme  = "!hell",
  env    = "!cave",

  where  = "seeds",
  seed_w = 3,
  seed_h = 2,

  deep =  16,
  over = -16,

  item_kind = "key",

  x_fit = "frame",
  y_fit = "top",

  sound = "Bathroom_Fan",
}

PREFABS.Item_closet_toilet_room_filthy =
{
  template   = "Item_closet_toilet_room",
  map = "MAP02",
  prob = 80,
}

PREFABS.Item_closet_cat_litter_box =
{
  template   = "Item_closet_toilet_room",
  map = "MAP03",

  env = "!outdoor",

  port = "zdoom",
  prob = 120,

  seed_w = 2,
  seed_h = 1,

  over = nil,

  x_fit = { 24,32 },
  y_fit = { 20,24 }
}

--
-- Tall keyed door
--

PREFABS.Locked_joiner_key1_tall =
{
  file   = "joiner/key_tall.wad",
  map    = "MAP01",

  prob   = 100,

  key    = "k_red",
  where  = "seeds",
  shape  = "I",

  seed_w = 1,
  seed_h = 1,

  deep   = 16,
  over   = 16,

  x_fit  = "frame",
  y_fit  = {48,56 , 104,112}
}

PREFABS.Locked_joiner_key2_tall =
{
  template = "Locked_joiner_key1_tall",

  key    = "k_yellow",

  line_33 = 34,

  tex_DOORRED = "DOORYEL"
}

PREFABS.Locked_joiner_key3_tall =
{
  template = "Locked_joiner_key1_tall",

  key    = "k_blue",

  line_33 = 32,

  tex_DOORRED = "DOORBLU"
}

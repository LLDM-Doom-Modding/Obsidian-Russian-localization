PREFABS.Wall_quakish_insets_1 =
{
  file   = "wall/gtd_wall_quakish_inset.wad",
  map    = "MAP01",

  prob   = 50,
  env = "building",

  group = "gtd_wall_quakish_insets",

  where  = "edge",
  deep   = 16,
  height = 128,

  bound_z1 = 0,
  bound_z2 = 128,

  z_fit  = "top"
}

PREFABS.Wall_quakish_insets_diagonal =
{
  template = "Wall_quakish_insets_1",
  map    = "MAP02",

  where  = "diagonal"
}

--

PREFABS.Wall_quakish_insets_2 =
{
  template = "Wall_quakish_insets_1",
  map = "MAP03",

  port = "zdoom",

  group = "gtd_wall_quakish_insets_2"
}

PREFABS.Wall_quakish_insets_2_limit =
{
  template = "Wall_quakish_insets_1",
  map = "MAP03",

  port = "!zdoom",

  group = "gtd_wall_quakish_insets_2",

  line_344 = 0
}

PREFABS.Wall_quakish_insets_2_diag =
{
  template = "Wall_quakish_insets_1",
  map = "MAP04",

  where = "diagonal",

  port = "zdoom",

  group = "gtd_wall_quakish_insets_2"
}

PREFABS.Wall_quakish_insets_2_diag_limit =
{
  template = "Wall_quakish_insets_1",
  map = "MAP04",

  port = "!zdoom",

  where = "diagonal",

  group = "gtd_wall_quakish_insets_2",

  line_344 = 0
}

--

PREFABS.Wall_quakish_insets_horizon =
{
  file = "wall/gtd_wall_quakish_inset.wad",
  map = "MAP05",

  prob = 50,
  port = "zdoom",

  group = "gtd_wall_quakish_insets_horizon",

  where = "edge",
  deep = 16,
  height = 96,

  bound_z1 = 0,
  bound_z2 = 96,

  z_fit = "top"
}

PREFABS.Wall_quakish_insets_horizon_diag =
{
  template = "Wall_quakish_insets_horizon",
  map = "MAP06",

  where = "diagonal"
}

PREFABS.Wall_quakish_insets_horizon_pillared =
{
  template = "Wall_quakish_insets_horizon",
  map = "MAP07",

  prob = 7
}

--

PREFABS.Wall_quakish_insets_horizon_limit =
{
  template = "Wall_quakish_insets_horizon",
  map = "MAP05",

  port = "!zdoom",

  line_337 = 0
}

PREFABS.Wall_quakish_insets_horizon_diag_limit =
{
  template = "Wall_quakish_insets_horizon",
  map = "MAP06",

  port = "!zdoom",
  where = "diagonal",

  line_337 = 0
}

PREFABS.Wall_quakish_insets_horizon_pillared_limit =
{
  template = "Wall_quakish_insets_horizon",
  map = "MAP07",

  port = "!zdoom",

  prob = 7,

  line_337 = 0
}

--

PREFABS.Wall_quakish_insets_horizon_mid =
{
  file = "wall/gtd_wall_quakish_inset.wad",
  map = "MAP08",

  prob = 50,
  port = "zdoom",

  group = "gtd_wall_quakish_insets_horizon_mid",

  where = "edge",
  deep = 16,
  height = 96,

  bound_z1 = 0,
  bound_z2 = 96,

  z_fit = "top"
}

PREFABS.Wall_quakish_insets_horizon_pillared_mid =
{
  template = "Wall_quakish_insets_horizon_mid",
  map = "MAP09",

  prob = 7
}

PREFABS.Wall_quakish_insets_horizon_diag_mid =
{
  template = "Wall_quakish_insets_horizon_mid",
  map = "MAP10",

  where = "diagonal"
}

--

PREFABS.Wall_quakish_insets_horizon_mid_limit =
{
  template = "Wall_quakish_insets_horizon_mid",

  port = "!zdoom",

  line_337 = 0
}

PREFABS.Wall_quakish_insets_horizon_pillared_mid_limit =
{
  template = "Wall_quakish_insets_horizon_mid",
  map = "MAP09",

  prob = 7,

  port = "!zdoom",

  line_337 = 0
}

PREFABS.Wall_quakish_insets_horizon_diag_mid_limit =
{
  template = "Wall_quakish_insets_horizon_mid",
  map = "MAP10",

  where = "diagonal",

  port = "!zdoom",

  line_337 = 0
}

--

PREFABS.Wall_quakish_insets_horizon_top =
{
  file = "wall/gtd_wall_quakish_inset.wad",
  map = "MAP11",

  prob = 50,
  port = "zdoom",

  group = "gtd_wall_quakish_insets_horizon_top",

  where = "edge",
  deep = 16,
  height = 96,

  bound_z1 = 0,
  bound_z2 = 96,

  z_fit = { 30,31 , 60,62 , 67,69 }
}

PREFABS.Wall_quakish_insets_horizon_pillared_top =
{
  template = "Wall_quakish_insets_horizon_top",
  map = "MAP12",

  prob = 7
}

PREFABS.Wall_quakish_insets_horizon_diag_top =
{
  template = "Wall_quakish_insets_horizon_top",
  map = "MAP13",

  where = "diagonal"
}

--

PREFABS.Wall_quakish_insets_horizon_top_limit =
{
  template = "Wall_quakish_insets_horizon_top",

  port = "!zdoom",

  line_337 = 0
}

PREFABS.Wall_quakish_insets_horizon_pillared_top_limit =
{
  template = "Wall_quakish_insets_horizon_top",
  map = "MAP09",

  prob = 7,

  port = "!zdoom",

  line_337 = 0
}

PREFABS.Wall_quakish_insets_horizon_diag_top_limit =
{
  template = "Wall_quakish_insets_horizon_top",
  map = "MAP10",

  where = "diagonal",

  port = "!zdoom",

  line_337 = 0
}

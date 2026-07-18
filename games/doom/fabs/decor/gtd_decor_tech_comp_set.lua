PREFABS.Decor_tech_comp_lite5_1 =
{
  file = "decor/gtd_decor_tech_comp_set.wad",
  map = "MAP01",

  where = "point",

  prob = 5000,
  group = "gtd_computers_lite5",

  size = 80,
  height = 88,

  bound_z1 = 0,
  bound_z2 = 88,
}

PREFABS.Decor_tech_comp_lite5_2 =
{
  template = "Decor_tech_comp_lite5_1",
  map = "MAP02",

  height = 96,
  bound_z2 = 96,

  z_fit = { 18,22 }
}

PREFABS.Decor_tech_comp_lite5_big =
{
  template = "Decor_tech_comp_lite5_1",
  map = "MAP03",

  prob = 8000,

  size = 112
}

--

PREFABS.Decor_tech_data_center_rack_1 =
{
  template = "Decor_tech_comp_lite5_1",
  map = "MAP04",

  prob = 5000,

  group = "gtd_data_center",

  size = 112,
  height = 96,

  bound_z2 = 96,

  z_fit = {84, 86}
}

PREFABS.Decor_tech_data_center_rack_2 =
{
  template = "Decor_tech_comp_lite5_1",
  map = "MAP05",

  prob = 7500,

  group = "gtd_data_center",

  size = 112,
  height = 96,

  bound_z2 = 96,

  z_fit = {84, 86}
}

PREFABS.Decor_tech_data_center_rack_2_melt =
{
  template = "Decor_tech_comp_lite5_1",
  map = "MAP08",

  prob = 7500,

  group = "gtd_data_center",

  size = 112,
  height = 96,

  bound_z2 = 96,

  z_fit = {84, 86}
}

PREFABS.Decor_tech_data_center_rack_screen =
{
  template = "Decor_tech_comp_lite5_1",
  map = "MAP09",

  prob = 3500,

  texture_pack = "armaetus",
  group = "gtd_data_center",

  size = 112,
  height = 96,

  bound_z2 = 96,

  z_fit = {84, 86}
}

--

PREFABS.Decor_gtd_dh_comp_2 =
{
  template = "Decor_dittohead_computer",

  file = "decor/gtd_decor_tech_comp_set.wad",
  map = "MAP06",

  group = "gtd_dh_comp",

  height = 128,
  size = 96,

  bound_z2 = 128,

  z_fit = {114,116}
}

PREFABS.Decor_gtd_dh_comp_3 =
{
  template = "Decor_dittohead_computer",

  file = "decor/gtd_decor_tech_comp_set.wad",
  map = "MAP07",

  group = "gtd_dh_comp",

  height = 96,
  size = 80,

  bound_z2 = 96,

  z_fit = {82,84}
}

--

PREFABS.Decor_black_mirror_pillar =
{
  template = "Decor_tech_comp_lite5_1",
  map = "MAP10",

  group = "gtd_black_mirror",

  height = 96,
  size = 60,

  bound_z2 = 96,

  z_fit = {10,12}
}

--

PREFABS.Decor_tech_spbc_1 =
{
  file = "decor/gtd_decor_tech_comp_set.wad",
  map = "MAP15",

  prob = 5000,

  group = "gtd_silver_pillars_blue_computers",

  where = "point",

  size = 64,
  height = 96,

  bound_z1 = 0,
  bound_z2 = 96,

  z_fit = { 60,62 , 91,93}
}

PREFABS.Decor_tech_sbpc_2 =
{
  template = "Decor_tech_spbc_1",
  map = "MAP16",

  z_fit = { 56,57 , 91,93}
}

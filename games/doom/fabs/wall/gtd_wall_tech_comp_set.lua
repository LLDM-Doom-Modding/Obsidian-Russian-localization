PREFABS.Wall_gtd_computer_wall_1 =
{
  file   = "wall/gtd_wall_tech_comp_set.wad",
  map    = "MAP01",

  prob   = 50,
  group  = "gtd_computers",

  where  = "edge",

  deep   = 16,

  height = 128,

  bound_z1 = 0,
  bound_z2 = 128,

  z_fit  = "top",
}

PREFABS.Wall_gtd_computer_wall_2 =
{
  template = "Wall_gtd_computer_wall_1",
  map      = "MAP02",
}

PREFABS.Wall_gtd_computer_wall_3 =
{
  template = "Wall_gtd_computer_wall_1",
  map      = "MAP03",
}

PREFABS.Wall_gtd_computer_diag_1 =
{
  file   = "wall/gtd_wall_tech_comp_set.wad",
  map    = "MAP04",

  prob   = 50,
  group  = "gtd_computers",

  where  = "diagonal",

  deep   = 16,

  height = 128,

  bound_z1 = 0,
  bound_z2 = 128,

  z_fit  = "top",
}

PREFABS.Wall_gtd_computer_diag_2 =
{
  template = "Wall_gtd_computer_diag_1",
  map      = "MAP05",
}

-- EPIC version using silver computers

PREFABS.Wall_gtd_computer_silver_1 =
{
  template = "Wall_gtd_computer_wall_1",
  map = "MAP02",

  group = "gtd_computers_shawn",

  tex_COMPTALL =
  {
    SHAWCOMP = 50,
    SILVCOMP = 50,
    CONSOLE4 = 50,
  },
}

PREFABS.Wall_gtd_computer_silver_diag_1 =
{
  template = "Wall_gtd_computer_diag_1",
  map = "MAP04",

  group = "gtd_computers_shawn",

  tex_COMPTALL = "SHAWCOMP",
}

PREFABS.Wall_gtd_computer_silver_diag_2 =
{
  template = "Wall_gtd_computer_diag_1",
  map = "MAP05",

  group = "gtd_computers_shawn",

  tex_COMPTALL = "SHAWCOMP",
}

-- EPIC versions using compstation textures

PREFABS.Wall_gtd_computer_compsta_1 =
{
  template = "Wall_gtd_computer_wall_1",
  map = "MAP02",

  group = "gtd_computers_compsta",

  tex_COMPTALL =
  {
    COMPSTA3 = 1,
    COMPSTA4 = 1,
    COMPSTA5 = 1,
    COMPSTA6 = 1,
    COMPSTA7 = 1,
    COMPSTA8 = 1,
    COMPSTA9 = 1,
    COMPSTAA = 1,
    COMPSTAB = 1,
  },
}

PREFABS.Wall_gtd_computer_compsta_diag_1 =
{
  template = "Wall_gtd_computer_diag_1",
  map = "MAP04",

  group = "gtd_computers_compsta",

  tex_COMPTALL = "SHAWCOMP",
}

PREFABS.Wall_gtd_computer_compsta_diag_2 =
{
  template = "Wall_gtd_computer_diag_1",
  map = "MAP05",

  group = "gtd_computers_compsta",

  tex_COMPTALL = "SHAWCOMP",
}

--

PREFABS.Wall_gtd_computer_lite5_1 =
{
  template = "Wall_gtd_computer_wall_1",
  map = "MAP08",

  prob = 100,

  height = 96,
  group = "gtd_computers_lite5",

  bound_z2 = 96,

  sector_1 = {[0] = 10, [1] = 1, [3] = 1, [21] = 1},

  forced_offsets =
  {
    [26] = {x=96, y=1}
  }
}

PREFABS.Wall_gtd_computer_lite5_2 =
{
  template = "Wall_gtd_computer_wall_1",
  map = "MAP08",

  height = 96,
  group = "gtd_computers_lite5",

  bound_z2 = 96,

  sector_1 = {[0] = 10, [1] = 1, [3] = 1, [21] = 1},

  forced_offsets =
  {
    [26] = {x=128, y=64}
  }
}

PREFABS.Wall_gtd_computer_lite5_3 =
{
  template = "Wall_gtd_computer_wall_1",
  map = "MAP08",

  height = 96,
  group = "gtd_computers_lite5",

  bound_z2 = 96,

  sector_1 = {[0] = 10, [1] = 1, [3] = 1, [21] = 1},

  forced_offsets =
  {
    [26] = {x=192, y=64}
  }
}

PREFABS.Wall_gtd_computer_lite5_4 =
{
  template = "Wall_gtd_computer_wall_1",
  map = "MAP08",

  height = 96,
  group = "gtd_computers_lite5",

  bound_z2 = 96,

  sector_1 = {[0] = 10, [1] = 1, [3] = 1, [21] = 1},

  forced_offsets =
  {
    [26] = {x=192, y=1}
  }
}

PREFABS.Wall_gtd_computer_lite5_diag =
{
  template = "Wall_gtd_computer_wall_1",
  map = "MAP09",

  where = "diagonal",

  height = 96,
  group = "gtd_computers_lite5",

  bound_z2 = 96,

  sector_1 = {[0] = 10, [1] = 1, [3] = 1, [21] = 1}
}

--

PREFABS.Wall_gtd_computer_blue_shawn =
{
  template = "Wall_gtd_computer_wall_1",
  map = "MAP10",

  height = 112,
  group = "gtd_computers_blue_shawn",

  bound_z2 = 112
}

PREFABS.Wall_gtd_computer_blue_shawn_2 =
{
  template = "Wall_gtd_computer_wall_1",
  map = "MAP11",

  height = 112,
  group = "gtd_computers_blue_shawn",

  bound_z2 = 112
}

PREFABS.Wall_gtd_computer_blue_shawn_diag =
{
  template = "Wall_gtd_computer_wall_1",
  map = "MAP12",

  where = "diagonal",
  height = 112,
  group = "gtd_computers_blue_shawn",

  bound_z2 = 112
}

--

PREFABS.Wall_gtd_data_center_wall_1 =
{
  file   = "wall/gtd_wall_tech_comp_set.wad",
  map    = "MAP15",

  prob   = 50,
  group  = "gtd_data_center",

  where  = "edge",

  deep   = 16,

  height = 96,

  bound_z1 = 0,
  bound_z2 = 96,

  z_fit  = "top",
}

PREFABS.Wall_gtd_data_center_wall_2 =
{
  template = "Wall_gtd_data_center_wall_1",
  map = "MAP16",

  probs = 8,
}

PREFABS.Wall_gtd_data_center_wall_diag =
{
  template = "Wall_gtd_data_center_wall_1",
  map = "MAP17",

  where = "diagonal"
}

--

PREFABS.Wall_gtd_dh_comp = -- inspired by a fab that has survived since Oblige 7.7
{
  file   = "wall/gtd_wall_tech_comp_set.wad",
  map    = "MAP20",

  prob   = 50,
  group  = "gtd_dh_comp",

  where  = "edge",

  deep   = 16,

  height = 112,

  bound_z1 = 0,
  bound_z2 = 112,

  z_fit  = "top",

  tex_COMPTALL =
  {
    COMPTALL = 1,
    SPACEW3 = 5
  },

  sector_1  = { [0]=75, [1]=15, [2]=5, [3]=5, [8]=10, [12]=5, [13]=5 }
}

PREFABS.Wall_gtd_dh_comp_diag =
{
  template = "Wall_gtd_dh_comp",
  map = "MAP21",

  where = "diagonal",

  height = 112,

  bound_z2 = 112
}

--

PREFABS.Wall_gtd_black_mirror_1 =
{
  file   = "wall/gtd_wall_tech_comp_set.wad",
  map    = "MAP25",

  prob   = 50,
  group  = "gtd_black_mirror",

  where  = "edge",

  deep   = 16,

  height = 96,

  bound_z1 = 0,
  bound_z2 = 96,

  z_fit = "top"
}

PREFABS.Wall_gtd_black_mirror_ad_panel =
{
  template = "Wall_gtd_black_mirror_1",
  map = "MAP26",

  texture_pack = "armaetus",

  prob = 10,

  tex_ADVCR3 =
  {
    ADVCR3 = 2,
    ADVCR5 = 2,
    ADVDE4 = 2,
    ADVDE6 = 2,

    COMPSA1 = 2,
    COMPSC1 = 2,
    COMPSD1 = 2,
    LAVWHIT1 = 2,
    NOISE2A = 2,
    NOISE3A = 2
  },

  sector_12 =
  {
    [0] = 10,
    [12] = 2,
    [13] = 2,
    [21] = 2,
  }
}

PREFABS.Wall_gtd_black_mirror_diag =
{
  template = "Wall_gtd_black_mirror_1",
  map = "MAP27",

  where = "diagonal"
}

--


PREFABS.Wall_gtd_spbc_1 =
{
  file = "wall/gtd_wall_tech_comp_set.wad",
  map = "MAP30",

  prob = 50,
  group = "gtd_silver_pillars_blue_computers",

  where = "edge",

  deep = 16,

  height = 96,

  bound_z1 = 0,
  bound_z2 = 96,

  z_fit = {92,94}
}

PREFABS.Wall_gtd_spbc_2 =
{
  template = "Wall_gtd_spbc_1",
  map = "MAP31",

  prob = 10,
}

PREFABS.Wall_gtd_spbc_3 =
{
  template = "Wall_gtd_spbc_1",
  map = "MAP32",

  prob = 5,

  tex_COMPSTA1 =
  {
    COMPSTA1 = 5,
    COMPSTA2 = 5
  }
}


PREFABS.Wall_gtd_spbc_diag =
{
  template = "Wall_gtd_spbc_1",
  map = "MAP33",

  where = "diagonal",
}


PREFABS.Pic_tech_comp_console_1 =
{
  file = "picture/gtd_pic_tech_comp_set.wad",
  map = "MAP01",

  prob = 5000,

  group = "gtd_computers",

  where = "seeds",
  height = 128,

  seed_w = 2,
  seed_h = 1,

  deep = 16,

  bound_z1 = 0,
  bound_z2 = 128,

  x_fit = { 124,132 },
  y_fit = { 16,72 }
}

PREFABS.Pic_tech_comp_console_compshawn =
{
  template = "Pic_tech_comp_console_1",
  map = "MAP02",

  group = "gtd_computers_shawn",

  y_fit = { 20,108 }
}

PREFABS.Pic_tech_comp_console_compstation =
{
  template = "Pic_tech_comp_console_1",
  map = "MAP03",

  group = "gtd_computers_compsta",

  y_fit = { 20,108 },

  tex_COMPSTA3 =
  {
    COMPSTA3 = 1,
    COMPSTA4 = 1,
    COMPSTA5 = 1,
    COMPSTA6 = 1,
    COMPSTA7 = 1,
    COMPSTA8 = 1,
    COMPSTA9 = 1,
    COMPSTAA = 1,
    COMPSTAB = 1
  },

  tex_COMPSTA4 =
  {
    COMPSTA3 = 1,
    COMPSTA4 = 1,
    COMPSTA5 = 1,
    COMPSTA6 = 1,
    COMPSTA7 = 1,
    COMPSTA8 = 1,
    COMPSTA9 = 1,
    COMPSTAA = 1,
    COMPSTAB = 1
  },

  tex_COMPSTA5 =
  {
    COMPSTA3 = 1,
    COMPSTA4 = 1,
    COMPSTA5 = 1,
    COMPSTA6 = 1,
    COMPSTA7 = 1,
    COMPSTA8 = 1,
    COMPSTA9 = 1,
    COMPSTAA = 1,
    COMPSTAB = 1
  }
}

--

PREFABS.Pic_tech_data_center_pic_1 =
{
  template = "Pic_tech_comp_console_1",
  map = "MAP04",

  group = "gtd_data_center",

  x_fit = {16,20 , 236,240},
  y_fit = "top",

  bound_z2 = 96,

  tex_DFAN1 = "METAL5"
}

PREFABS.Pic_tech_data_center_pic_1_EPIC =
{
  template = "Pic_tech_comp_console_1",
  map = "MAP04",

  replaces = "Pic_tech_data_center_pic_1",
  texture_pack = "armaetus",

  group = "gtd_data_center",

  x_fit = {16,24 , 232,240},
  y_fit = "top",

  bound_z2 = 96
}

PREFABS.Pic_tech_data_center_pic_2 =
{
  template = "Pic_tech_comp_console_1",
  map = "MAP05",

  group = "gtd_data_center",

  x_fit = {16,24 , 232,240},
  y_fit = "top",

  bound_z2 = 96
}

PREFABS.Pic_tech_data_center_pic_3_compscreen =
{
  template = "Pic_tech_comp_console_1",
  map = "MAP06",

  prob = 2500,

  group = "gtd_data_center",
  texture_pack = "armaetus",

  x_fit = {16,24 , 232,240},
  y_fit = "top",

  bound_z2 = 96
}

--

PREFABS.Pic_tech_dh_comp =
{
  template = "Pic_tech_comp_console_1",
  map = "MAP07",

  prob = 5000,

  height = 112,

  group = "gtd_dh_comp",

  x_fit = {16,24 , 232,240},
  y_fit = "top",

  bound_z1 = 0,
  bound_z2 = 112
}

--

PREFABS.Pic_black_mirror_1 =
{
  template = "Pic_tech_comp_console_1",
  map = "MAP09",

  texture_pack = "armaetus",

  height = 96,

  group = "gtd_black_mirror",

  x_fit = "frame",
  y_fit = "top",
  z_fit = "top",

  bound_z1 = 0,
  bound_z2 = 96,

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

  tex_ADVCR5 =
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
  }
}

PREFABS.Pic_black_mirror_2 =
{
  template = "Pic_tech_comp_console_1",
  map = "MAP10",

  height = 96,

  group = "gtd_black_mirror",

  x_fit = "frame",
  y_fit = "top",
  z_fit = "top",

  bound_z1 = 0,
  bound_z2 = 96,
}

PREFABS.Pic_black_mirror_3 =
{
  template = "Pic_tech_comp_console_1",
  map = "MAP11",

  height = 96,

  group = "gtd_black_mirror",

  x_fit = "frame",
  y_fit = "top",
  z_fit = "top",

  bound_z1 = 0,
  bound_z2 = 96,

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

  tex_ADVCR5 =
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

  tex_ADVDE4 =
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
  }
}

--

PREFABS.Pic_tech_spbc_1 =
{
  file = "picture/gtd_pic_tech_comp_set.wad",
  map = "MAP15",

  prob = 5000,

  group = "gtd_silver_pillars_blue_computers",

  where = "seeds",
  height = 128,

  seed_w = 2,
  seed_h = 1,

  deep = 16,

  bound_z1 = 0,
  bound_z2 = 128,

  x_fit = "frame",
  y_fit = "top"
}

PREFABS.Pic_tech_spbc_2 =
{
  template = "Pic_tech_spbc_1",
  map = "MAP16",

  prob = 7500,

  seed_w = 3
}

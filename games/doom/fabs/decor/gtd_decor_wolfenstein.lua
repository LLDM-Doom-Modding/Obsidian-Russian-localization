PREFABS.Decor_wolfenstein_destructible_1 =
{
  file   = "decor/gtd_decor_wolfenstein.wad",
  map    = "MAP01",

  prob   = 15000,

  height = 137,

  where  = "point",
  size   = 96,

  secret_level_only = true,

  bound_z1 = 0,
  bound_z2 = 136,

  tex_ZZWOLF6 =
  {
    ZZWOLF6 = 50,
    ZZWOLF7 = 50
  }
}

PREFABS.Decor_wolfenstein_destructible_2 =
{
  template = "Decor_wolfenstein_destructible_1",
  map = "MAP02",

  where  = "point",
  size   = 68
}

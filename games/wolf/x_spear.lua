----------------------------------------------------------------
-- GAME DEF : Spear of Destiny
----------------------------------------------------------------
--
--  Oblige Level Maker (C) 2006,2007 Andrew Apted
--
--  This program is free software; you can redistribute it and/or
--  modify it under the terms of the GNU General Public License
--  as published by the Free Software Foundation; either version 2
--  of the License, or (at your option) any later version.
--
--  This program is distributed in the hope that it will be useful,
--  but WITHOUT ANY WARRANTY; without even the implied warranty of
--  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
--  GNU General Public License for more details.
--
----------------------------------------------------------------

SPEAR = { }

UNFINISHED["spear"] =
{
	label = _("Spear of Destiny"),
	priority = 47,
	
  engine = "idtech_0",
	format = "wolf3d",
	
	extends = "wolf",
	
	tables =
	{
	  SPEAR
	},
	
	hooks =
	{
      factory_setup = SPEAR.factory_setup,
	},
}

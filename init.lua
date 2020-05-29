local modpath = minetest.get_modpath(minetest.get_current_modname())

sickles = { }
sickles.i18n = minetest.get_translator("sickles")

dofile(modpath .. "/lib/api.lua")
dofile(modpath .. "/lib/tools.lua")
dofile(modpath .. "/lib/items.lua")
dofile(modpath .. "/lib/cuttables.lua")
dofile(modpath .. "/lib/compatibility.lua")
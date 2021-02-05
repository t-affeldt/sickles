local mod_stairs = minetest.get_modpath("stairs")
local mod_walls = minetest.get_modpath("walls")
local mod_flowers = minetest.get_modpath("flowers") ~= nil
local mod_farming = minetest.get_modpath("farming") ~= nil
local mod_footprints = minetest.get_modpath("footprints") ~= nil
local mod_nature = minetest.get_modpath("nature_classic") ~= nil
local mod_moretrees = minetest.get_modpath("moretrees") ~= nil
local mod_woodsoils = minetest.get_modpath("woodsoils") ~= nil
local mod_grains = minetest.get_modpath("grains") ~= nil
local mod_cucina_vegana = minetest.get_modpath("cucina_vegana") ~= nil
local mod_caverealms = minetest.get_modpath("caverealms") ~= nil
local mod_df_mapitems = minetest.get_modpath("df_mapitems") ~= nil
local mod_df_primordial_items = minetest.get_modpath("df_primordial_items") ~= nil
local mod_ethereal = minetest.get_modpath("ethereal") ~= nil
local mod_gloopblocks = minetest.get_modpath("gloopblocks") ~= nil
local mod_underch = minetest.get_modpath("underch") ~= nil

sickles.register_cuttable("default:dirt_with_grass", "default:dirt", "default:grass_1")
sickles.register_cuttable("default:dirt_with_dry_grass", "default:dirt", "default:dry_grass_1")
sickles.register_cuttable("default:dry_dirt_with_dry_grass", "default:dry_dirt", "default:dry_grass_1")
sickles.register_cuttable("default:dirt_with_rainforest_litter", "default:dirt", "default:junglegrass")
sickles.register_cuttable("default:dirt_with_coniferous_litter", "default:dirt", "default:dry_grass_1")
sickles.register_cuttable("default:permafrost_with_moss", "default:permafrost", "sickles:moss")
sickles.register_cuttable("default:mossycobble", "default:cobble", "sickles:moss")

if mod_walls then
   sickles.register_cuttable("walls:mossycobble", "walls:cobble", "sickles:moss")
end

if mod_stairs then
   sickles.register_cuttable("stairs:slab_mossycobble", "stairs:slab_cobble", "sickles:moss")
   sickles.register_cuttable("stairs:stair_mossycobble", "stairs:stair_cobble", "sickles:moss")
   sickles.register_cuttable("stairs:stair_inner_mossycobble", "stairs:stair_inner_cobble", "sickles:moss")
   sickles.register_cuttable("stairs:stair_outer_mossycobble", "stairs:stair_outer_cobble", "sickles:moss")
end

if mod_footprints then
   sickles.register_cuttable("footprints:dirt_with_dry_grass", "default:dirt", "default:dry_grass_1")
   sickles.register_cuttable("footprints:dry_dirt_with_dry_grass", "default:dry_dirt", "default:dry_grass_1")
   sickles.register_cuttable("footprints:dirt_with_rainforest_litter", "default:dirt", "default:junglegrass")
   sickles.register_cuttable("footprints:dirt_with_coniferous_litter", "default:dirt", "default:dry_grass_1")
end

if mod_nature and not mod_moretrees then
   sickles.register_cuttable("nature:blossom", "default:leaves", "sickles:petals")
end

if mod_moretrees then
   sickles.register_cuttable("moretrees:apple_blossoms", "moretrees:apple_tree_leaves", "sickles:petals")
end

if mod_woodsoils then
   sickles.register_cuttable("woodsoils:grass_with_leaves_1", "default:dirt", "default:dry_grass_1")
   sickles.register_cuttable("woodsoils:grass_with_leaves_2", "default:dirt", "default:dry_grass_1")
   sickles.register_cuttable("woodsoils:grass_with_leaves_1", "default:dirt", "default:grass_1")
   sickles.register_cuttable("woodsoils:grass_with_leaves_2", "default:dirt", "default:grass_1")
end

if mod_farming then
   sickles.register_trimmable("farming:wheat_8", "farming:wheat_2")
   sickles.register_trimmable("farming:cotton_8", "farming:cotton_2")
end

if mod_farming and farming ~= nil and farming.mod == "redo" then
   sickles.register_trimmable("farming:rye_8", "farming:rye_2")
   sickles.register_trimmable("farming:oat_8", "farming:oat_2")
   sickles.register_trimmable("farming:barley_7", "farming:barley_2")
   sickles.register_trimmable("farming:rice_8", "farming:rice_2")
   sickles.register_trimmable("farming:pineapple_8", "farming:pineapple_1")
   sickles.register_trimmable("farming:coffee_5", "farming:coffee_1")
   sickles.register_trimmable("farming:tomato_8", "farming:tomato_1")
   sickles.register_trimmable("farming:carrot_8", "farming:carrot_1")
   sickles.register_trimmable("farming:grapes_8", "farming:grapes_1")
   sickles.register_trimmable("farming:beetroot_5", "farming:beetroot_1")
   sickles.register_trimmable("farming:rice_8", "farming:rice_2")
   sickles.register_trimmable("farming:beanpole_5", "farming:beanpole_1")
   sickles.register_trimmable("farming:rhubarb_3", "farming:rhubarb_1")
   sickles.register_trimmable("farming:cabbage_6", "farming:cabbage_1")
   sickles.register_trimmable("farming:corn_8", "farming:corn_1")
   sickles.register_trimmable("farming:pepper_7", "farming:pepper_1")
   sickles.register_trimmable("farming:potato_4", "farming:potato_1")
   sickles.register_trimmable("farming:vanilla_8", "farming:vanilla_1")
   sickles.register_trimmable("farming:lettuce_5", "farming:lettuce_1")
   sickles.register_trimmable("farming:cucumber_4", "farming:cucumber_1")
   sickles.register_trimmable("farming:pea_5", "farming:pea_1")
   sickles.register_trimmable("farming:blueberry_4", "farming:blueberry_1")
   sickles.register_trimmable("farming:raspberry_4", "farming:raspberry_1")
   sickles.register_trimmable("farming:blackberry_4", "farming:blackberry_1")
   sickles.register_trimmable("farming:chili_8", "farming:chili_1")
   sickles.register_trimmable("farming:melon_8", "farming:melon_1")
end

if mod_grains then
   sickles.register_trimmable("grains:rye_8", "grains:rye_2")
   sickles.register_trimmable("grains:oat_8", "grains:oat_2")
   sickles.register_trimmable("grains:barley_8", "grains:barley_2")
   sickles.register_trimmable("grains:rice_8", "grains:rice_2")
end

if mod_cucina_vegana then
   sickles.register_trimmable("cucina_vegana:rice_6", "cucina_vegana:rice_2")
end

if mod_caverealms then
   sickles.register_cuttable("caverealms:stone_with_moss", "default:cobble", "sickles:moss")
   sickles.register_cuttable("caverealms:stone_with_lichen", "default:cobble", "sickles:moss_purple")
   sickles.register_cuttable("caverealms:stone_with_algae", "default:cobble", "sickles:moss_yellow")
end

if mod_df_mapitems then
   sickles.register_cuttable("df_mapitems:dirt_with_cave_moss", "default:cobble", "sickles:moss_blue")
   sickles.register_cuttable("df_mapitems:cobble_with_floor_fungus", "default:cobble", "sickles:moss_yellow")
   sickles.register_cuttable("df_mapitems:cobble_with_floor_fungus_fine", "default:cobble", "sickles:moss_yellow")
   sickles.register_cuttable("df_mapitems:ice_with_hoar_moss", "default:ice", "sickles:moss_blue")
end

if mod_df_primordial_items then
   sickles.register_cuttable("df_primordial_items:dirt_with_mycelium", "default:dirt", "df_primordial_items:fungal_grass_1")
   sickles.register_cuttable("df_primordial_items:jungle_tree_mossy", "df_primordial_items:jungle_tree", "sickles:moss")
   sickles.register_cuttable("df_primordial_items:jungle_tree_glowing", "df_primordial_items:jungle_tree", "df_primordial_items:mushroom_gills_glowing")
   sickles.register_cuttable("df_primordial_items:dirt_with_jungle_grass", "default:dirt", "df_primordial_items:jungle_grass_1")
end

if mod_ethereal then
   sickles.register_cuttable("ethereal:bamboo_dirt", "default:dirt", "default:grass_1")
   sickles.register_cuttable("ethereal:cold_dirt", "default:dirt", "default:grass_1")
   sickles.register_cuttable("ethereal:crystal_dirt", "default:dirt", "ethereal:crystalgrass")
   sickles.register_cuttable("ethereal:fiery_dirt", "default:dirt", "ethereal:dry_shrub")
   sickles.register_cuttable("ethereal:gray_dirt", "default:dirt", "ethereal:snowygrass")
   sickles.register_cuttable("ethereal:grove_dirt", "default:dirt", "sickles:moss")
   sickles.register_cuttable("ethereal:dry_dirt", "default:dirt", "default:coal_lump")
   sickles.register_cuttable("ethereal:jungle_dirt", "default:dirt", "default:junglegrass")
   sickles.register_cuttable("ethereal:mushroom_dirt", "default:dirt", "ethereal:mushroom_sapling")
   sickles.register_cuttable("ethereal:prairie_dirt", "default:dirt", "sickles:petals")
   sickles.register_cuttable("ethereal:onion_5", "ethereal:onion_1")
   sickles.register_cuttable("ethereal:strawberry_8", "ethereal:strawberry_1")
end

if mod_gloopblocks then
   sickles.register_cuttable("gloopblocks:stone_brick_mossy", "default:stonebrick", "sickles:moss")
   sickles.register_cuttable("gloopblocks:stone_mossy", "default:stone", "sickles:moss")
   sickles.register_cuttable("gloopblocks:cobble_road_mossy", "gloopblocks:cobble_road", "sickles:moss")
end

if mod_gloopblocks and mod_stairs then
   sickles.register_cuttable("stairs:stair_stone_mossy", "stairs:stair_stone", "sickles:moss")
   sickles.register_cuttable("stairs:stair_inner_stone_mossy", "stairs:stair_inner_stone", "sickles:moss")
   sickles.register_cuttable("stairs:stair_outer_stone_mossy", "stairs:stair_outer_stone", "sickles:moss")
   sickles.register_cuttable("stairs:slab_stone_mossy", "stairs:slab_stone", "sickles:moss")
   sickles.register_cuttable("stairs:stair_stone_brick_mossy", "stairs:stair_stonebrick", "sickles:moss")
   sickles.register_cuttable("stairs:stair_inner_stone_brick_mossy", "stairs:stair_inner_stonebrick", "sickles:moss")
   sickles.register_cuttable("stairs:stair_outer_stone_brick_mossy", "stairs:stair_outer_stonebrick", "sickles:moss")
   sickles.register_cuttable("stairs:slab_stone_brick_mossy", "stairs:slab_stonebrick", "sickles:moss")
   sickles.register_cuttable("stairs:stair_cobble_road_mossy", "stairs:stair_cobble_road", "sickles:moss")
   sickles.register_cuttable("stairs:stair_inner_cobble_road_mossy", "stairs:stair_inner_cobble_road", "sickles:moss")
   sickles.register_cuttable("stairs:stair_outer_cobble_road_mossy", "stairs:stair_outer_cobble_road", "sickles:moss")
   sickles.register_cuttable("stairs:slab_cobble_road_mossy", "stairs:slab_cobble_road", "sickles:moss")
end


if mod_underch then
   sickles.register_cuttable("underch:mossy_dirt", "default:dirt", "sickles:moss")
   sickles.register_cuttable("underch:mossy_gravel", "default:gravel", "sickles:moss")
end

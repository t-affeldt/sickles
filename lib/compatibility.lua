local mod_flowers = minetest.get_modpath("flowers") ~= nil
local mod_bonemeal = minetest.get_modpath("bonemeal") ~= nil
local mod_trunks = minetest.get_modpath("trunks") ~= nil
local mod_cottages = minetest.get_modpath("cottages") ~= nil
local mod_gloopblocks = minetest.get_modpath("gloopblocks") ~= nil

-- turn moss into fertilizer by cooking
if mod_bonemeal then
	minetest.register_craft({
		type = "cooking",
		cooktime = 9,
		output = "bonemeal:fertiliser",
		recipe = "group:moss"
	})
end

-- turn moss from trunks mod into this mod's moss
if mod_trunks then
	minetest.register_alias_force("trunks:moss", "sickles:moss")

	minetest.register_craft({
		type = "shapeless",
		output = " trunks:moss_fungus",
		recipe = { "group:moss", "group:mushroom" }
	})
end

-- enable crafting of flower petals
if mod_flowers then
	minetest.register_craft({
		output = "sickles:petals",
		recipe = {
			{ "flowers:dandelion_white", "flowers:dandelion_white" },
			{ "flowers:dandelion_white", "flowers:dandelion_white" },
		}
	})
end

-- override pitchfork to use sickle mechanic
if mod_cottages then
	minetest.override_item("default:dirt_with_grass", {
		after_dig_node = function() end
	})

	local groups = minetest.registered_tools["cottages:pitchfork"].groups
	groups.sickle = 1
	groups.sickle_uses = 12
	minetest.override_item("cottages:pitchfork", {
		groups = groups
	})

	minetest.register_craft({
		output = "cottages:hay_mat",
		recipe = {{ "group:grass", "group:grass", "group:grass" }}
	})
end

-- change crafting recipes of mossy blocks to use moss item
if mod_gloopblocks then
	minetest.clear_craft({
		output = "gloopblocks:stone_brick_mossy"
	})
	minetest.register_craft({
		type = "shapeless",
		output = "gloopblocks:stone_brick_mossy",
		recipe = { "default:stonebrick", "sickles:moss" }
	})

	minetest.clear_craft({
		output = "gloopblocks:cobble_road_mossy"
	})
	minetest.register_craft({
		type = "shapeless",
		output = "gloopblocks:cobble_road_mossy",
		recipe = { "gloopblocks:cobble_road", "sickles:moss" }
	})

	minetest.clear_craft({
		output = "gloopblocks:stone_mossy"
	})
	minetest.register_craft({
		type = "shapeless",
		output = "gloopblocks:stone_mossy",
		recipe = { "default:stone", "sickles:moss" }
	})
end
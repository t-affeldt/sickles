local mod_flowers = minetest.get_modpath("flowers") ~= nil
local mod_bonemeal = minetest.get_modpath("bonemeal") ~= nil
local mod_trunks = minetest.get_modpath("trunks") ~= nil
local mod_cottages = minetest.get_modpath("cottages") ~= nil

if mod_bonemeal then
	minetest.register_craft({
		type = "cooking",
		cooktime = 9,
		output = "bonemeal:fertiliser",
		recipe = "group:moss"
	})
end

if mod_trunks then
	minetest.register_alias_force("trunks:moss", "sickles:moss")

	minetest.register_craft({
		type = "shapeless",
		output = " trunks:moss_fungus",
		recipe = { "group:moss", "group:mushroom" }
	})
end

if mod_flowers then
	minetest.register_craft({
		output = "sickles:petals",
		recipe = {
			{ "flowers:dandelion_white", "flowers:dandelion_white" },
			{ "flowers:dandelion_white", "flowers:dandelion_white" },
		}
	})
end

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
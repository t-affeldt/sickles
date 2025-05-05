local mod_stairs = minetest.get_modpath("stairs") ~= nil
local mod_mcl_stairs = minetest.get_modpath("mcl_stairs") ~= nil
local mod_dye = minetest.get_modpath("dye") ~= nil
local mod_mcl_dyes = minetest.get_modpath("mcl_dyes") ~= nil
local mod_mcl_lush_caves = minetest.get_modpath("mcl_lush_caves") ~= nil
local mod_mcl_sounds = minetest.get_modpath("mcl_sounds") ~= nil

local default_moss_png = "default_moss.png"
if mod_mcl_lush_caves then
	default_moss_png = "mcl_lush_caves_moss.png"
end

local S = sickles.i18n

local colors = {
	{ dye = "dark_green" },
	{ hex = "#894adb70", name = "purple", dye = "violet" },
	{ hex = "#6c7eb070", name = "blue", dye = "cyan" },
	{ hex = "#bcc56770", name = "yellow", dye = "yellow" }
}

local sounds
if mod_mcl_sounds then
sounds = mcl_sounds.node_sound_leaves_defaults({
	footstep = "default_grass_footstep",
	dug = "sickles_moss_dug",
	place = "sickles_moss_dug"
})
else
sounds = default.node_sound_leaves_defaults({
	footstep = "default_grass_footstep",
	dug = "sickles_moss_dug",
	place = "sickles_moss_dug"
})
end

local node_box = {
	type = "wallmounted",
	wall_side = { -0.5, -0.5, -0.5, -0.45, 0.5, 0.5 },
	wall_top = { -0.5, 0.45, -0.5, 0.5, 0.5, 0.5 },
	wall_bottom = { -0.5, -0.5, -0.5, 0.5, -0.45, 0.5 }
}

local function register_stairs(subname, recipeitem, groups, images, desc_stair, desc_slab, desc_slope, snds, wat)
	if mod_mcl_stairs then
	mcl_stairs.register_stair_and_slab(subname, {
		baseitem = recipeitem,
		description_stair = desc_stair,
		description_slab = desc_slab,
		groups = groups,
		sounds = snds
	})
	end
	if not mod_stairs then return end
	stairs.register_stair_and_slab(subname, recipeitem, groups, images, desc_stair, desc_slab, snds, wat)
	if stairs.mod == "redo" then
		stairs.register_slope(subname, recipeitem, groups, images, desc_slope, snds, wat)
	end
end

for _, color in ipairs(colors) do
	local name_suffix = ""
	local display_name_prefix = ""
	local texture_overlay = ""
	if color.name ~= nil then
		name_suffix = "_" .. color.name
		display_name_prefix = color.name:gsub("^%l", string.upper) .. " "
	end
	if color.hex ~= nil then
		texture_overlay = "^[colorize:" .. color.hex
	end

	minetest.register_node("sickles:moss" .. name_suffix, {
		description = S(display_name_prefix .. "Moss"),
		inventory_image = "sickles_moss_item.png" .. texture_overlay,
		wield_image = "sickles_moss_item.png" .. texture_overlay,
		tiles = { "trunks_moss.png" .. texture_overlay },
		groups = { snappy = 3, attached_node = 1, flora = 1, food = 1, moss = 1, food_moss = 1, flammable = 2 },
		on_use = minetest.item_eat(1),
		is_ground_content = false,
		sounds = sounds,
		use_texture_alpha = true,
		drawtype = "signlike",
		paramtype = "light",
		paramtype2 = "wallmounted",
		node_box = node_box,
		selection_box = node_box,
		sunlight_propagates = true,
		walkable = false,
		buildable_to = true,
		floodable = true
	})

	minetest.register_node("sickles:moss_block" .. name_suffix, {
		description = S(display_name_prefix .. "Moss Block"),
		tiles = { default_moss_png .. texture_overlay },
		is_ground_content = false,
		groups = { snappy = 3, moss_block = 1, flammable = 2, fall_damage_add_percent = -80 },
		sounds = sounds
	})

	register_stairs(
		"moss_block" .. name_suffix,
		"sickles:moss_block" .. name_suffix,
		{ snappy = 3, flammable = 2, fall_damage_add_percent = -80 },
		{ default_moss_png .. texture_overlay },
		S(display_name_prefix .. "Moss Stair"),
		S(display_name_prefix .. "Moss Slab"),
		S(display_name_prefix .. "Moss Slope"),
		sounds
	)

	minetest.register_craft({
		output = "sickles:moss_block" .. name_suffix .. " 3",
		recipe = {
			{ "sickles:moss" .. name_suffix, "sickles:moss" .. name_suffix, "sickles:moss" .. name_suffix },
			{ "sickles:moss" .. name_suffix, "sickles:moss" .. name_suffix, "sickles:moss" .. name_suffix },
			{ "sickles:moss" .. name_suffix, "sickles:moss" .. name_suffix, "sickles:moss" .. name_suffix }
		}
	})

	minetest.register_craft({
		output = "sickles:moss" .. name_suffix .. " 3",
		recipe = {{ "sickles:moss_block" .. name_suffix }}
	})

	if mod_dye then
		minetest.register_craft({
			type = "shapeless",
			output = "sickles:moss_block" .. name_suffix,
			recipe = { "group:moss_block", "dye:" .. color.dye }
		})

		minetest.register_craft({
			output = "dye:" .. color.dye,
			recipe = {{ "sickles:moss" .. name_suffix }}
		})
	end
	if mod_mcl_dyes then
		minetest.register_craft({
			type = "shapeless",
			output = "sickles:moss_block" .. name_suffix,
			recipe = { "group:moss_block", "mcl_dyes:" .. color.dye }
		})

		minetest.register_craft({
			output = "mcl_dyes:" .. color.dye,
			recipe = {{ "sickles:moss" .. name_suffix }}
		})
	end
end

minetest.register_craft({
	type = "fuel",
	recipe = "group:moss",
	burntime = 2
})

minetest.register_craft({
	type = "fuel",
	recipe = "group:moss_block",
	burntime = 18
})

local use_sounds
if mod_mcl_sounds then
	use_sounds = mcl_sounds.node_sound_leaves_defaults()
else
	use_sounds = default.node_sound_leaves_defaults()
end
minetest.register_node("sickles:petals", {
	description = S("Flower Petals"),
	tiles = { "nature_blossom.png" },
	inventory_image = "nature_blossom.png",
	wield_image = "nature_blossom.png",
	is_ground_content = false,
	groups = { snappy = 3, attached_node = 1 },
	sounds = use_sounds,
	use_texture_alpha = true,
	drawtype = "signlike",
	paramtype = "light",
	paramtype2 = "wallmounted",
	node_box = node_box,
	selection_box = node_box,
	sunlight_propagates = true,
	walkable = false,
	buildable_to = true,
	floodable = true
})

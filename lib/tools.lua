minetest.register_tool("sickles:sickle_bronze", {
	description = "Bronze Sickle",
	inventory_image = "sickles_sickle_bronze.png",
	tool_capabilities = {
		full_punch_interval = 0.8,
		max_drop_level = 1,
		groupcaps = {
			snappy = { times = { [1] = 2.75, [2] = 1.30, [3] = 0.375 }, uses = 60, maxlevel = 2 }
		},
		damage_groups = { fleshy = 3 },
		punch_attack_uses = 110
	},
	range = 6,
	groups = { sickle = 1, sickle_uses = 110 },
	sound = { breaks = "default_tool_breaks" }
})

minetest.register_craft({
	output = "sickles:sickle_bronze",
	recipe = {
		{ "default:bronze_ingot", "" },
		{ "", "default:bronze_ingot" },
		{ "group:stick", "" }
	}
})

minetest.register_tool("sickles:sickle_steel", {
	description = "Steel Sickle",
	inventory_image = "sickles_sickle_steel.png",
	tool_capabilities = {
		full_punch_interval = 0.8,
		max_drop_level = 1,
		groupcaps = {
			snappy = { times = { [1] = 2.5, [2] = 1.20, [3] = 0.35 }, uses = 60, maxlevel = 2 }
		},
		damage_groups = { fleshy = 3 },
		punch_attack_uses = 120
	},
	range = 6,
	groups = { sickle = 1, sickle_uses = 120 },
	sound = { breaks = "default_tool_breaks" }
})

minetest.register_craft({
	output = "sickles:sickle_steel",
	recipe = {
		{ "default:steel_ingot", "" },
		{ "", "default:steel_ingot" },
		{ "group:stick", "" }
	}
})

minetest.register_tool("sickles:sickle_gold", {
	description = "Golden Sickle",
	inventory_image = "sickles_sickle_gold.png",
	tool_capabilities = {
		full_punch_interval = 0.8,
		max_drop_level = 1,
		groupcaps = {
			snappy = { times = { [1] = 2.0, [2] = 1.00, [3] = 0.35 }, uses = 45, maxlevel = 3 }
		},
		damage_groups = { fleshy = 2 },
		punch_attack_uses = 90
	},
	range = 6,
	groups = { sickle = 1, sickle_uses = 90 },
	sound = { breaks = "default_tool_breaks" }
})

minetest.register_craft({
	output = "sickles:sickle_gold",
	recipe = {
		{ "default:gold_ingot", "" },
		{ "", "default:gold_ingot" },
		{ "group:stick", "" }
	}
})

minetest.register_tool("sickles:scythe_bronze", {
	description = "Bronze Scythe",
	inventory_image = "sickles_scythe_bronze.png",
	tool_capabilities = {
		full_punch_interval = 1.2,
		damage_groups = { fleshy = 5 },
		punch_attack_uses = 160
	},
	range = 12,
	on_use = sickles.use_scythe,
	groups = { scythe = 2, scythe_uses = 25 },
	sound = { breaks = "default_tool_breaks" }
})

minetest.register_craft({
	output = "sickles:scythe_bronze",
	recipe = {
		{ "", "default:bronze_ingot", "default:bronze_ingot" },
		{ "default:bronze_ingot", "", "group:stick" },
		{ "", "", "group:stick" }
	}
})

minetest.register_tool("sickles:scythe_steel", {
	description = "Bronze Scythe",
	inventory_image = "sickles_scythe_steel.png",
	tool_capabilities = {
		full_punch_interval = 1.2,
		damage_groups = { fleshy = 5 },
		punch_attack_uses = 180
	},
	range = 12,
	on_use = sickles.use_scythe,
	groups = { scythe = 2, scythe_uses = 30 },
	sound = { breaks = "default_tool_breaks" }
})

minetest.register_craft({
	output = "sickles:scythe_steel",
	recipe = {
		{ "", "default:steel_ingot", "default:steel_ingot" },
		{ "default:steel_ingot", "", "group:stick" },
		{ "", "", "group:stick" }
	}
})
local is_farming_redo = minetest.get_modpath("farming") ~= nil
		and farming ~= nil and farming.mod == "redo"
local mod_mcl_farming = minetest.get_modpath("mcl_farming") ~= nil

local MAX_ITEM_WEAR = 65535
local DEFAULT_SICKLE_USES = 120
local DEFAULT_SCYTHE_USES = 30

local function is_creative(playername)
	return minetest.settings:get_bool("creative_mode")
			or minetest.check_player_privs(playername, { creative = true })
end

local function get_wielded_item(player)
	if not minetest.is_player(player) then return end
	local itemstack = player:get_wielded_item()
	if itemstack == nil then return end
	return itemstack
end

local function get_item_group(def, group)
	if def == nil
			or def.groups == nil
			or def.groups[group] == nil then
		return 0
	end
	return def.groups[group]
end

function sickles.register_cuttable(nodename, base, item)
	local def = minetest.registered_nodes[nodename]
	if def == nil then return end
	local default_handler = def.on_punch or minetest.node_punch
	minetest.override_item(nodename, {
		on_punch = function(pos, node, puncher, pointed_thing)
			local itemstack = get_wielded_item(puncher)
			local itemdef = itemstack:get_definition()
			local level = get_item_group(itemdef, "sickle")
			if level == 0 then
				return default_handler(pos, node, puncher, pointed_thing)
			end
			local pname = puncher:get_player_name()
			if minetest.is_protected(pos, pname) then
				minetest.record_protection_violation(pos, pname)
				return
			end
			if mod_mcl_farming and item == "sickles:moss" then
				-- for some reason mineclonia does not want to drop moss, so just add to player inventory
				local invref = puncher:get_inventory()
				if invref:room_for_item("main", item) then
					invref:add_item("main", item)
				end
			else
				minetest.handle_node_drops(pos, { item }, puncher)
			end
			minetest.after(0, function()
				minetest.swap_node(pos, { name = base, param2 = node.param2 })
			end)
			if not is_creative(pname) then
				local max_uses = get_item_group(itemdef, "sickle_uses") or DEFAULT_SICKLE_USES
				itemstack:add_wear(math.ceil(MAX_ITEM_WEAR / (max_uses - 1)))
				if itemstack:get_count() == 0 and itemdef.sound and itemdef.sound.breaks then
					minetest.sound_play(itemdef.sound.breaks, { pos = pos, gain = 0.5 })
				end
				puncher:set_wielded_item(itemstack)
			end
		end
	})
end

function sickles.register_trimmable(node, base)
	local def = minetest.registered_nodes[node]
	if def == nil then return end
	local handler = def.after_dig_node
	minetest.override_item(node, {
		after_dig_node = function(pos, oldnode, oldmetadata, digger)
			local itemstack = get_wielded_item(digger)
			local itemdef = itemstack:get_definition()
			local level = get_item_group(itemdef, "sickle")
			if level == 0 then
				if handler ~= nil then
					return handler(pos, oldnode, oldmetadata, digger)
				else return end
			end
			local param2 = minetest.registered_nodes[base].place_param2
			minetest.set_node(pos, { name = base, param2 = param2 })
			-- timer values taken from farming mod (see tick function in api.lua)
			minetest.get_node_timer(pos):start(math.random(166, 286))
		end
	})
end

local function get_plant_definition(plant)
	if is_farming_redo then
		return farming.registered_plants[plant]
	else
		local mod = plant:split(":")[1] or ""
		local name = plant:split(":")[2] or ""
		local pname = name:gsub("(.*)_.*$", "%1")
		if mod_mcl_farming then
			-- from mineclonia/mods/ITEMS/mcl_farming/shared_functions.lua
			return mcl_farming.plant_lists["plant_" .. pname]
		end
		return farming.registered_plants[pname]
	end
end

local function get_seed_name(plant)
	if is_farming_redo then
		return farming.registered_plants[plant].seed
	else
		if mod_mcl_farming then
			return plant .. "_seeds"
		end
		local mod = plant:split(":")[1]
		local name = plant:split(":")[2]
		local pname = name:gsub("(.*)_.*$", "%1")
		return mod .. ":seed_" .. pname
	end
end

local function harvest_and_replant(pos, player)
	local playername = player:get_player_name()
	local node = minetest.get_node(pos)
	local node_id
	if mod_mcl_farming then
		node_id = node.name
	else
		node_id = node.name:gsub("(.*)_.*$", "%1")
	end
	local stage = tonumber(node.name:gsub(".*_(.*)$", "%1") or 0)
	local plantdef = get_plant_definition(node_id)
	if plantdef == nil then
		return false
	end
	if mod_mcl_farming then
		if plantdef.full_grown == nil then
			return false
		elseif plantdef.full_grown == node_id then else
			return false
		end
	else
		if plantdef.steps == nil or stage < plantdef.steps then
			return false
		end
	end
	if minetest.is_protected(pos, playername) then
		minetest.record_protection_violation(pos, playername)
		return false
	end
	minetest.node_dig(pos, node, player)
	minetest.sound_play("default_dig_snappy", { pos = pos, gain = 0.5, max_hear_distance = 8 }, true)
	minetest.after(0, function()
		local invref = player:get_inventory()
		local seeds = get_seed_name(node_id)
		if minetest.get_node(pos).name ~= "air" or
		not invref:contains_item("main", seeds) then
			return true
		end
		if not is_creative(playername) then
			invref:remove_item("main", seeds)
		end
		if is_farming_redo then
			-- plant first crop for farming redo
			local crop_name = node_id .. "_1"
			local crop_def = minetest.registered_nodes[crop_name]
			if crop_def == nil then return end
			minetest.set_node(pos, { name = crop_name, param2 = crop_def.place_param2 })
		else
			-- plant seeds for MTG and Mineclonia farming
			if mod_mcl_farming then
				local level1 = node_id .. "_1"
				-- keep the same paramtype2 = "meshoptions" from lua_api.md
				minetest.set_node(pos, { name = level1, param2 = node.param2 })
				-- need to remove seed again for Mineclonia, because it dropped seeds.
				minetest.after(0,function()
					if not is_creative(playername) then
						invref:remove_item("main", seeds)
					end
				end)
			else
				minetest.set_node(pos, { name = seeds, param2 = 1 })
			end
			-- timer values taken from farming mod (see tick function in api.lua)
			minetest.get_node_timer(pos):start(math.random(166, 286))
		end
	end)
	return true
end

function sickles.use_scythe(itemstack, user, pointed_thing)
	if pointed_thing == nil then return end
	local itemdef = itemstack:get_definition()
	if pointed_thing.type == "object" then
		local tool_capabilities = itemstack:get_tool_capabilities()
		local meta = itemstack:get_meta()
		local last_punch = meta:get_float("last_punch") or 0
		local now = minetest.get_gametime()
		meta:set_float("last_punch", now)
		pointed_thing.ref:punch(user, now - last_punch, tool_capabilities)
	end
	if pointed_thing.type ~= "node" then return end
	local max_uses = get_item_group(itemdef, "scythe_uses") or DEFAULT_SCYTHE_USES
	local range = (get_item_group(itemdef, "scythe") or 1) - 1
	local pos = pointed_thing.under
	local harvested = harvest_and_replant(pos, user)
	if not harvested then return end
	if range > 0 then
		local pos1 = vector.add(pos, { x = -range, y = 0, z = -range })
		local pos2 = vector.add(pos, { x =  range, y = 0, z =  range })
		local positions = minetest.find_nodes_in_area(pos1, pos2, "group:plant")
		for _, check_pos in ipairs(positions) do
			if pos ~= check_pos then
				harvest_and_replant(check_pos, user)
			end
		end
	end
	itemstack:add_wear(math.ceil(MAX_ITEM_WEAR / (max_uses - 1)))
	return itemstack
end

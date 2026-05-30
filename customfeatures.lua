-- Implement all of these features:

run(function()
	local SkinChanger
	local Players = playersService
	local RunService = runService
	local LocalPlayer = Players.LocalPlayer
	local RS = game.ReplicatedStorage

	local CURRENT_ITEM_SKIN = "Victorious Lyla"
	local CURRENT_SKIN_TYPE = "Nightmare"

	local ok1, ItemType = pcall(function()
		return require(RS.TS.item["item-type"]).ItemType
	end)
	if not ok1 then ItemType = {} end

	local ok2, ItemSkinType = pcall(function()
		return require(RS.TS.games.bedwars["item-skin"]["item-skin-types"]).ItemSkinType
	end)
	if not ok2 then ItemSkinType = {} end

	local KitSkinCtrl
	pcall(function()
		local KC = require(RS.rbxts_include.node_modules["@easy-games"].knit.src).KnitClient
		KitSkinCtrl = KC.Controllers.KitSkinController
	end)

	local BOW_ROT = CFrame.Angles(0, math.rad(-90), 0)
	local CROSSBOW_ROT = CFrame.new(0, 0, 0) * CFrame.Angles(0, math.rad(-360), 0)
	local LUNAR_CROSSBOW_ROT = CFrame.new(0, 0, 0) * CFrame.Angles(0, -190, math.rad(-180))
	local VICTORIOUS_ARCHER_BOW_ROT = CFrame.new(0, 0, 0) * CFrame.Angles(0, -52, math.rad(90))
	local VICTORIOUS_ARCHER_CROSSBOW_ROT = CFrame.new(0.00, 0.00, 0.00) * CFrame.Angles(math.rad(0), math.rad(80), math.rad(0.00))
	local VICTORIOUS_ARCHER_HEADHUNTER_ROT = CFrame.new(0, 0, 0) * CFrame.Angles(0, math.rad(180), 0)
	local HEADHUNTER_ROT = CFrame.new(0.4, 0, 0) * CFrame.Angles(0, math.rad(360), 0)
	local AXE_ROT = CFrame.new(0, 0, -0.4) * CFrame.Angles(0, math.rad(90), 0)
	local PICKAXE_ROT = CFrame.new(0, 0, -0.1) * CFrame.Angles(0, math.rad(110), 0)
	local LASSO_ROT = CFrame.Angles(0, math.rad(90), 0)
	local STAFF_ROT = CFrame.Angles(0, math.rad(90), 0)
	local PIXEL_SWORD_ROT = CFrame.new(0, 0, 0) * CFrame.Angles(0, math.rad(-180), 0)
	local SWORD_ROT = CFrame.new(0, -1.7, 0) * CFrame.Angles(0, math.rad(-180), 0)
	local HEARTBEAM_SWORD_ROT = CFrame.new(0, -1.2, 0) * CFrame.Angles(0, math.rad(0), 0)
	local LIFE_BOW_ROT = CFrame.Angles(0, math.rad(-20), 0)
	local DAO_ROT = CFrame.new(0, -1.7, 0) * CFrame.Angles(0, math.rad(-180), 0)
	local VIC_ROT = CFrame.new(0, -1.9, 0) * CFrame.Angles(0, math.rad(360), 0)
	local HEXED_DAO_ROT = CFrame.new(0.00, 0.00, 0.00) * CFrame.Angles(math.rad(180.00), math.rad(-4.00), math.rad(0.00))
	local SNOW_DAO_ROT = CFrame.new(-0.2, -0.9, 0) * CFrame.Angles(0, math.rad(-180), 0)
	local HARPOON_ROT = CFrame.new(0, -1.4, -0.15) * CFrame.Angles(0, math.rad(180), 0)
	local TRIDENT_ROT = CFrame.new(0, 0.5, 0.05) * CFrame.Angles(0, math.rad(180), 0)
	local LYLA_BOW_ROT = CFrame.new(0, 0, 0) * CFrame.Angles(30, -30, 183.56)
	local LYLA_CROSSBOW_ROT = CFrame.Angles(math.rad(0), math.rad(180), math.rad(0))
	local LYLA_HEADHUNTER_ROT = CFrame.new(0, 0, 0) * CFrame.Angles(0, math.rad(0), 0)
	local LYLA_FROST_CROSSBOW_ROT = CFrame.new(0.00, 0.00, 0.00) * CFrame.Angles(math.rad(180.00), math.rad(178.00), math.rad(0.00))

	local CANNON_HAND_SCALE = 0.34
	local CANNON_PLACED_OFFSET = CFrame.new(0, -1.0, 0)
	local CANNON_TOOL_NAME = "cannon"

	local CANNON_SKIN_NAMES = {
		["Victorious Cannon"] = {
			Gold = "cannon_gold_victorious",
			Platinum = "cannon_platinum_victorious",
			Diamond = "cannon_diamond_victorious",
			Emerald = "cannon_emerald_victorious",
			Nightmare = "cannon_nightmare_victorious",
		},
		["Ghost Cannon"] = { Default = "cannon_ghost" },
		["Deep Sea Cannon"] = { Default = "cannon_deepsea" },
	}

	local CANNON_SOUND_NAMES = {
		Gold = "CANNON_FIRE_VICTORIOUS_NIGHTMARE",
		Platinum = "CANNON_FIRE_VICTORIOUS_NIGHTMARE",
		Diamond = "CANNON_FIRE_VICTORIOUS_DIAMOND",
		Emerald = "CANNON_FIRE_VICTORIOUS_EMERALD",
		Nightmare = "CANNON_FIRE_VICTORIOUS_NIGHTMARE",
	}

	local SKIN_OFFSETS = {
		["nightmare_victorious_flower_bow"] = LYLA_BOW_ROT,
		["emerald_victorious_flower_bow"] = LYLA_BOW_ROT,
		["diamond_victorious_flower_bow"] = LYLA_BOW_ROT,
		["platinum_victorious_flower_bow"] = LYLA_BOW_ROT,
		["gold_victorious_flower_bow"] = LYLA_BOW_ROT,
		["nightmare_victorious_flower_crossbow"] = LYLA_CROSSBOW_ROT,
		["emerald_victorious_flower_crossbow"] = LYLA_CROSSBOW_ROT,
		["diamond_victorious_flower_crossbow"] = LYLA_CROSSBOW_ROT,
		["platinum_victorious_flower_crossbow"] = LYLA_CROSSBOW_ROT,
		["gold_victorious_flower_crossbow"] = LYLA_CROSSBOW_ROT,
		["nightmare_victorious_flower_headhunter"] = LYLA_HEADHUNTER_ROT,
		["emerald_victorious_flower_headhunter"] = LYLA_HEADHUNTER_ROT,
		["diamond_victorious_flower_headhunter"] = LYLA_HEADHUNTER_ROT,
		["platinum_victorious_flower_headhunter"] = LYLA_HEADHUNTER_ROT,
		["gold_victorious_flower_headhunter"] = LYLA_HEADHUNTER_ROT,
		["tactical_headhunter_victorious_nightmare"] = VICTORIOUS_ARCHER_HEADHUNTER_ROT,
		["tactical_headhunter_victorious_emerald"] = VICTORIOUS_ARCHER_HEADHUNTER_ROT,
		["tactical_headhunter_victorious_diamond"] = VICTORIOUS_ARCHER_HEADHUNTER_ROT,
		["tactical_headhunter_victorious_platinum"] = VICTORIOUS_ARCHER_HEADHUNTER_ROT,
		["tactical_headhunter_victorious_gold"] = VICTORIOUS_ARCHER_HEADHUNTER_ROT,
		["flower_bow_frost_queen"] = BOW_ROT,
		["tactical_crossbow_lunar_dragon"] = LUNAR_CROSSBOW_ROT,
		["life_bow_mummy"] = LIFE_BOW_ROT,
		["flower_headhunter_frost_queen"] = HEADHUNTER_ROT,
		["flower_crossbow_frost_queen"] = LYLA_FROST_CROSSBOW_ROT,
		["wood_sword_darkvalentine"] = SWORD_ROT,
		["stone_sword_darkvalentine"] = SWORD_ROT,
		["iron_sword_darkvalentine"] = SWORD_ROT,
		["diamond_sword_darkvalentine"] = SWORD_ROT,
		["emerald_sword_darkvalentine"] = SWORD_ROT,
		["wood_sword_heartbeam"] = HEARTBEAM_SWORD_ROT,
		["stone_sword_heartbeam"] = HEARTBEAM_SWORD_ROT,
		["iron_sword_heartbeam"] = HEARTBEAM_SWORD_ROT,
		["diamond_sword_heartbeam"] = HEARTBEAM_SWORD_ROT,
		["emerald_sword_heartbeam"] = HEARTBEAM_SWORD_ROT,
		["wood_bow_victorious_nightmare"] = VICTORIOUS_ARCHER_BOW_ROT,
		["wood_bow_victorious_emerald"] = VICTORIOUS_ARCHER_BOW_ROT,
		["wood_bow_victorious_diamond"] = VICTORIOUS_ARCHER_BOW_ROT,
		["wood_bow_victorious_platinum"] = VICTORIOUS_ARCHER_BOW_ROT,
		["wood_bow_victorious_gold"] = VICTORIOUS_ARCHER_BOW_ROT,
		["tactical_crossbow_victorious_nightmare"] = VICTORIOUS_ARCHER_CROSSBOW_ROT,
		["tactical_crossbow_victorious_emerald"] = VICTORIOUS_ARCHER_CROSSBOW_ROT,
		["tactical_crossbow_victorious_diamond"] = VICTORIOUS_ARCHER_CROSSBOW_ROT,
		["tactical_crossbow_victorious_platinum"] = VICTORIOUS_ARCHER_CROSSBOW_ROT,
		["tactical_crossbow_victorious_gold"] = VICTORIOUS_ARCHER_CROSSBOW_ROT,
		["life_crossbow_mummy"] = CROSSBOW_ROT,
		["life_headhunter_mummy"] = HEADHUNTER_ROT,
		["victorious_gold_triton"] = TRIDENT_ROT,
		["victorious_platinum_triton"] = TRIDENT_ROT,
		["victorious_diamond_triton"] = TRIDENT_ROT,
		["victorious_emerald_triton"] = TRIDENT_ROT,
		["victorious_nightmare_triton"] = TRIDENT_ROT,
		["demon_triton"] = HARPOON_ROT,
		["lasso_mummy"] = LASSO_ROT,
		["lasso_wrangler_reindeer_lassy"] = LASSO_ROT,
		["lasso_lifeguard"] = LASSO_ROT,
		["wood_axe_darkvalentine"] = AXE_ROT,
		["stone_axe_darkvalentine"] = AXE_ROT,
		["iron_axe_darkvalentine"] = AXE_ROT,
		["diamond_axe_darkvalentine"] = AXE_ROT,
		["wood_axe_valentine"] = AXE_ROT,
		["stone_axe_valentine"] = AXE_ROT,
		["iron_axe_valentine"] = AXE_ROT,
		["diamond_axe_valentine"] = AXE_ROT,
		["wood_pickaxe_darkvalentine"] = PICKAXE_ROT,
		["stone_pickaxe_darkvalentine"] = PICKAXE_ROT,
		["iron_pickaxe_darkvalentine"] = PICKAXE_ROT,
		["diamond_pickaxe_darkvalentine"] = PICKAXE_ROT,
		["wood_pickaxe_valentine"] = PICKAXE_ROT,
		["stone_pickaxe_valentine"] = PICKAXE_ROT,
		["iron_pickaxe_valentine"] = PICKAXE_ROT,
		["diamond_pickaxe_valentine"] = PICKAXE_ROT,
		["gold_victorious_wizard_staff"] = STAFF_ROT,
		["gold_victorious_wizard_staff_2"] = STAFF_ROT,
		["gold_victorious_wizard_staff_3"] = STAFF_ROT,
		["platinum_victorious_wizard_staff"] = STAFF_ROT,
		["platinum_victorious_wizard_staff_2"] = STAFF_ROT,
		["platinum_victorious_wizard_staff_3"] = STAFF_ROT,
		["diamond_victorious_wizard_staff"] = STAFF_ROT,
		["diamond_victorious_wizard_staff_2"] = STAFF_ROT,
		["diamond_victorious_wizard_staff_3"] = STAFF_ROT,
		["emerald_victorious_wizard_staff"] = STAFF_ROT,
		["emerald_victorious_wizard_staff_2"] = STAFF_ROT,
		["emerald_victorious_wizard_staff_3"] = STAFF_ROT,
		["nightmare_victorious_wizard_staff"] = STAFF_ROT,
		["nightmare_victorious_wizard_staff_2"] = STAFF_ROT,
		["nightmare_victorious_wizard_staff_3"] = STAFF_ROT,
		["wood_dao_victorious"] = VIC_ROT,
		["stone_dao_victorious"] = VIC_ROT,
		["iron_dao_victorious"] = VIC_ROT,
		["diamond_dao_victorious"] = VIC_ROT,
		["emerald_dao_victorious"] = VIC_ROT,
		["wood_dao_cursed"] = HEXED_DAO_ROT,
		["stone_dao_cursed"] = HEXED_DAO_ROT,
		["iron_dao_cursed"] = HEXED_DAO_ROT,
		["diamond_dao_cursed"] = HEXED_DAO_ROT,
		["emerald_dao_cursed"] = HEXED_DAO_ROT,
		["wood_dao_tiger"] = DAO_ROT,
		["stone_dao_tiger"] = DAO_ROT,
		["iron_dao_tiger"] = DAO_ROT,
		["diamond_dao_tiger"] = DAO_ROT,
		["emerald_dao_tiger"] = DAO_ROT,
		["wood_dao_snow_rabbit"] = SNOW_DAO_ROT,
		["stone_dao_snow_rabbit"] = SNOW_DAO_ROT,
		["iron_dao_snow_rabbit"] = SNOW_DAO_ROT,
		["diamond_dao_snow_rabbit"] = SNOW_DAO_ROT,
		["emerald_dao_snow_rabbit"] = SNOW_DAO_ROT,
		["wood_sword_pixel"] = PIXEL_SWORD_ROT,
		["stone_sword_pixel"] = PIXEL_SWORD_ROT,
		["iron_sword_pixel"] = PIXEL_SWORD_ROT,
		["diamond_sword_pixel"] = PIXEL_SWORD_ROT,
		["emerald_sword_pixel"] = PIXEL_SWORD_ROT,
		["wood_sword_short_pixel"] = PIXEL_SWORD_ROT,
		["stone_sword_short_pixel"] = PIXEL_SWORD_ROT,
		["iron_sword_short_pixel"] = PIXEL_SWORD_ROT,
		["diamond_sword_short_pixel"] = PIXEL_SWORD_ROT,
		["emerald_sword_short_pixel"] = PIXEL_SWORD_ROT,
	}

	local KIT_SKIN_MAP = {
		["Victorious Lyla"] = { Gold = "gold_victorious_lyla", Platinum = "platinum_victorious_lyla", Diamond = "diamond_victorious_lyla", Emerald = "emerald_victorious_lyla", Nightmare = "nightmare_victorious_lyla" },
		["Frost Queen Lyla"] = { Default = "flower_bee_frost_queen" },
		["Victorious Archer"] = { Gold = "archer_victorious_gold", Platinum = "archer_victorious_platinum", Diamond = "archer_victorious_diamond", Emerald = "archer_victorious_emerald", Nightmare = "archer_victorious_nightmare" },
		["Lunar Dragon Archer"] = { Default = "archer_lunar_dragon" },
		["Victorious Yuzi"] = { Default = "yuzi_victorious" },
		["Hexed Yuzi"] = { Default = "dasher_cursed" },
		["Tiger Yuzi"] = { Default = "dasher_tiger" },
		["Snow Rabbit Yuzi"] = { Default = "dasher_snow_rabbit" },
		["Victorious Zeno"] = { Gold = "gold_victorious_wizard", Platinum = "platinum_victorious_wizard", Diamond = "diamond_victorious_wizard", Emerald = "emerald_victorious_wizard", Nightmare = "nightmare_victorious_wizard" },
		["Victorious Triton"] = { Gold = "victorious_gold_triton", Platinum = "victorious_platinum_triton", Diamond = "victorious_diamond_triton", Emerald = "victorious_emerald_triton", Nightmare = "victorious_nightmare_triton" },
		["Demon Triton"] = { Default = "demon_triton" },
		["Mummy Life Bow"] = { Default = "mummy_nazar" },
		["Mummy Lasso"] = { Default = "cowgirl_mummy" },
		["Victorious Cannon"] = { Gold = "gold_victorious_davey", Platinum = "platinum_victorious_davey", Diamond = "diamond_victorious_davey", Emerald = "emerald_victorious_davey", Nightmare = "nightmare_victorious_davey" },
		["Ghost Cannon"] = { Default = "davey_ghost" },
		["Deep Sea Cannon"] = { Default = "davey_deepsea" },
	}

	local STORE_SKIN_MAP = {
		["Balloon Swords"] = function() return { { ItemType.WOOD_SWORD, ItemSkinType.BALLOON_WOOD_SWORD }, { ItemType.STONE_SWORD, ItemSkinType.BALLOON_STONE_SWORD }, { ItemType.IRON_SWORD, ItemSkinType.BALLOON_IRON_SWORD }, { ItemType.DIAMOND_SWORD, ItemSkinType.BALLOON_DIAMOND_SWORD }, { ItemType.EMERALD_SWORD, ItemSkinType.BALLOON_EMERALD_SWORD } } end,
		["Banana Swords"] = function() return { { ItemType.WOOD_SWORD, ItemSkinType.BANANA_WOOD_SWORD }, { ItemType.STONE_SWORD, ItemSkinType.BANANA_STONE_SWORD }, { ItemType.IRON_SWORD, ItemSkinType.BANANA_IRON_SWORD }, { ItemType.DIAMOND_SWORD, ItemSkinType.BANANA_DIAMOND_SWORD }, { ItemType.EMERALD_SWORD, ItemSkinType.BANANA_EMERALD_SWORD } } end,
		["Valentine Swords"] = function() return { { ItemType.WOOD_SWORD, ItemSkinType.VALENTINE_WOOD_SWORD }, { ItemType.STONE_SWORD, ItemSkinType.VALENTINE_STONE_SWORD }, { ItemType.IRON_SWORD, ItemSkinType.VALENTINE_IRON_SWORD }, { ItemType.DIAMOND_SWORD, ItemSkinType.VALENTINE_DIAMOND_SWORD }, { ItemType.EMERALD_SWORD, ItemSkinType.VALENTINE_EMERALD_SWORD } } end,
		["Darkheart Swords"] = function() return { { ItemType.WOOD_SWORD, ItemSkinType.DARKVALENTINE_WOOD_SWORD }, { ItemType.STONE_SWORD, ItemSkinType.DARKVALENTINE_STONE_SWORD }, { ItemType.IRON_SWORD, ItemSkinType.DARKVALENTINE_IRON_SWORD }, { ItemType.DIAMOND_SWORD, ItemSkinType.DARKVALENTINE_DIAMOND_SWORD }, { ItemType.EMERALD_SWORD, ItemSkinType.DARKVALENTINE_EMERALD_SWORD } } end,
		["Heartbeam Swords"] = function() return { { ItemType.WOOD_SWORD, ItemSkinType.HEARTBEAM_WOOD_SWORD }, { ItemType.STONE_SWORD, ItemSkinType.HEARTBEAM_STONE_SWORD }, { ItemType.IRON_SWORD, ItemSkinType.HEARTBEAM_IRON_SWORD }, { ItemType.DIAMOND_SWORD, ItemSkinType.HEARTBEAM_DIAMOND_SWORD }, { ItemType.EMERALD_SWORD, ItemSkinType.HEARTBEAM_EMERALD_SWORD } } end,
		["Valentine Pickaxes"] = function() return { { ItemType.WOOD_PICKAXE, ItemSkinType.VALENTINE_WOOD_PICKAXE }, { ItemType.STONE_PICKAXE, ItemSkinType.VALENTINE_STONE_PICKAXE }, { ItemType.IRON_PICKAXE, ItemSkinType.VALENTINE_IRON_PICKAXE }, { ItemType.DIAMOND_PICKAXE, ItemSkinType.VALENTINE_DIAMOND_PICKAXE } } end,
		["Darkheart Pickaxes"] = function() return { { ItemType.WOOD_PICKAXE, ItemSkinType.DARKVALENTINE_WOOD_PICKAXE }, { ItemType.STONE_PICKAXE, ItemSkinType.DARKVALENTINE_STONE_PICKAXE }, { ItemType.IRON_PICKAXE, ItemSkinType.DARKVALENTINE_IRON_PICKAXE }, { ItemType.DIAMOND_PICKAXE, ItemSkinType.DARKVALENTINE_DIAMOND_PICKAXE } } end,
		["Valentine Axes"] = function() return { { ItemType.WOOD_AXE, ItemSkinType.VALENTINE_WOOD_AXE }, { ItemType.STONE_AXE, ItemSkinType.VALENTINE_STONE_AXE }, { ItemType.IRON_AXE, ItemSkinType.VALENTINE_IRON_AXE }, { ItemType.DIAMOND_AXE, ItemSkinType.VALENTINE_DIAMOND_AXE } } end,
		["Darkheart Axes"] = function() return { { ItemType.WOOD_AXE, ItemSkinType.DARKVALENTINE_WOOD_AXE }, { ItemType.STONE_AXE, ItemSkinType.DARKVALENTINE_STONE_AXE }, { ItemType.IRON_AXE, ItemSkinType.DARKVALENTINE_IRON_AXE }, { ItemType.DIAMOND_AXE, ItemSkinType.DARKVALENTINE_DIAMOND_AXE } } end,
		["Mummy Life Bow"] = function() return { { ItemType.LIFE_BOW, ItemSkinType.LIFE_BOW_MUMMY }, { ItemType.LIFE_CROSSBOW, ItemSkinType.LIFE_CROSSBOW_MUMMY }, { ItemType.LIFE_HEADHUNTER, ItemSkinType.LIFE_HEADHUNTER_MUMMY } } end,
		["Mummy Lasso"] = function() return { { ItemType.LASSO, ItemSkinType.LASSO_MUMMY } } end,
	}

	local function yuziDaoMap(suffix)
		return {
			wood_dao = "wood_dao_" .. suffix,
			stone_dao = "stone_dao_" .. suffix,
			iron_dao = "iron_dao_" .. suffix,
			diamond_dao = "diamond_dao_" .. suffix,
			emerald_dao = "emerald_dao_" .. suffix,
		}
	end

	local SKIN_DATA = {
		["Victorious Lyla"] = function(t)
			local lt = t:lower()
			return {
				flower_bow = lt .. "_victorious_flower_bow",
				flower_crossbow = lt .. "_victorious_flower_crossbow",
				flower_headhunter = lt .. "_victorious_flower_headhunter",
			}
		end,
		["Frost Queen Lyla"] = function()
			return {
				flower_bow = "flower_bow_frost_queen",
				flower_crossbow = "flower_crossbow_frost_queen",
				flower_headhunter = "flower_headhunter_frost_queen",
			}
		end,
		["Victorious Archer"] = function(t)
			local lt = t:lower()
			return {
				wood_bow = "wood_bow_victorious_" .. lt,
				tactical_crossbow = "tactical_crossbow_victorious_" .. lt,
				tactical_headhunter = "tactical_headhunter_victorious_" .. lt,
			}
		end,
		["Lunar Dragon Archer"] = function()
			return {
				wood_bow = "wood_bow_lunar_dragon",
				tactical_crossbow = "tactical_crossbow_lunar_dragon",
				tactical_headhunter = "tactical_headhunter_lunar_dragon",
			}
		end,
		["Victorious Triton"] = function(t)
			return { harpoon = "victorious_" .. t:lower() .. "_triton" }
		end,
		["Demon Triton"] = function() return { harpoon = "demon_triton" } end,
		["Victorious Yuzi"] = function() return yuziDaoMap("victorious") end,
		["Hexed Yuzi"] = function() return yuziDaoMap("cursed") end,
		["Tiger Yuzi"] = function() return yuziDaoMap("tiger") end,
		["Snow Rabbit Yuzi"] = function() return yuziDaoMap("snow_rabbit") end,
		["Victorious Zeno"] = function(t)
			local lt = t:lower()
			return {
				wizard_staff = lt .. "_victorious_wizard_staff",
				wizard_staff_2 = lt .. "_victorious_wizard_staff_2",
				wizard_staff_3 = lt .. "_victorious_wizard_staff_3",
			}
		end,
		["Balloon Swords"] = function() return { wood_sword = "balloon_wood_sword", stone_sword = "balloon_stone_sword", iron_sword = "balloon_iron_sword", diamond_sword = "balloon_diamond_sword", emerald_sword = "balloon_emerald_sword" } end,
		["Banana Swords"] = function() return { wood_sword = "banana_wood_sword", stone_sword = "banana_stone_sword", iron_sword = "banana_iron_sword", diamond_sword = "banana_diamond_sword", emerald_sword = "banana_emerald_sword" } end,
		["Valentine Swords"] = function() return { wood_sword = "wood_sword_valentine", stone_sword = "stone_sword_valentine", iron_sword = "iron_sword_valentine", diamond_sword = "diamond_sword_valentine", emerald_sword = "emerald_sword_valentine" } end,
		["Darkheart Swords"] = function() return { wood_sword = "wood_sword_darkvalentine", stone_sword = "stone_sword_darkvalentine", iron_sword = "iron_sword_darkvalentine", diamond_sword = "diamond_sword_darkvalentine", emerald_sword = "emerald_sword_darkvalentine" } end,
		["Heartbeam Swords"] = function() return { wood_sword = "wood_sword_heartbeam", stone_sword = "stone_sword_heartbeam", iron_sword = "iron_sword_heartbeam", diamond_sword = "diamond_sword_heartbeam", emerald_sword = "emerald_sword_heartbeam" } end,
		["Valentine Pickaxes"] = function() return { wood_pickaxe = "wood_pickaxe_valentine", stone_pickaxe = "stone_pickaxe_valentine", iron_pickaxe = "iron_pickaxe_valentine", diamond_pickaxe = "diamond_pickaxe_valentine" } end,
		["Darkheart Pickaxes"] = function() return { wood_pickaxe = "wood_pickaxe_darkvalentine", stone_pickaxe = "stone_pickaxe_darkvalentine", iron_pickaxe = "iron_pickaxe_darkvalentine", diamond_pickaxe = "diamond_pickaxe_darkvalentine" } end,
		["Valentine Axes"] = function() return { wood_axe = "wood_axe_valentine", stone_axe = "stone_axe_valentine", iron_axe = "iron_axe_valentine", diamond_axe = "diamond_axe_valentine" } end,
		["Darkheart Axes"] = function() return { wood_axe = "wood_axe_darkvalentine", stone_axe = "stone_axe_darkvalentine", iron_axe = "iron_axe_darkvalentine", diamond_axe = "diamond_axe_darkvalentine" } end,
		["Mummy Lasso"] = function() return { lasso = "lasso_mummy" } end,
		["Mummy Life Bow"] = function() return { life_bow = "life_bow_mummy", life_crossbow = "life_crossbow_mummy", life_headhunter = "life_headhunter_mummy" } end,
		["Pixel Swords"] = function() return { wood_sword = "wood_sword_pixel", stone_sword = "stone_sword_pixel", iron_sword = "iron_sword_pixel", diamond_sword = "diamond_sword_pixel", emerald_sword = "emerald_sword_pixel" } end,
		["Pixel Swords Short"] = function() return { wood_sword = "wood_sword_short_pixel", stone_sword = "stone_sword_short_pixel", iron_sword = "iron_sword_short_pixel", diamond_sword = "diamond_sword_short_pixel", emerald_sword = "emerald_sword_short_pixel" } end,
	}

	local TIERED_SKINS = {
		["Victorious Lyla"] = true,
		["Victorious Archer"] = true,
		["Victorious Zeno"] = true,
		["Victorious Triton"] = true,
		["Victorious Cannon"] = true,
	}

	local function normalizeName(s)
		return s:lower():gsub("[_%s%-]", "")
	end

	local function isCannonSkin()
		return CANNON_SKIN_NAMES[CURRENT_ITEM_SKIN] ~= nil
	end

	local function getCurrentCannonSkinName()
		local tbl = CANNON_SKIN_NAMES[CURRENT_ITEM_SKIN]
		if not tbl then return nil end
		return tbl[CURRENT_SKIN_TYPE] or tbl.Default
	end

	local function getCannonSkinSource(skinName)
		local assets = RS:FindFirstChild("Assets")
		if not assets then return nil end
		local blocks = assets:FindFirstChild("Blocks")
		if not blocks then return nil end
		return blocks:FindFirstChild(skinName)
	end

	local function getCurrentMappings()
		local fn = SKIN_DATA[CURRENT_ITEM_SKIN]
		if not fn then return {} end
		return fn(CURRENT_SKIN_TYPE) or {}
	end

	local function getKitSkinValue()
		local m = KIT_SKIN_MAP[CURRENT_ITEM_SKIN]
		if not m then return nil end
		return m[CURRENT_SKIN_TYPE] or m.Default
	end

	local function getStoreSkins()
		local fn = STORE_SKIN_MAP[CURRENT_ITEM_SKIN]
		if not fn then return {} end
		return fn() or {}
	end

	local tagged = setmetatable({}, { __mode = "k" })
	local connections = {}
	local invisConns = setmetatable({}, { __mode = "k" })
	local oldGetKitSkin = nil
	local savedStoreSkins = {}

	local cannonTagged = setmetatable({}, { __mode = "k" })
	local cannonConnections = {}
	local cannonRenderConns = {}
	local oldFireCannon, oldLaunchSelf
	local soundsHooked = false

	local function firstBasePart(root)
		for _, d in ipairs(root:GetDescendants()) do
			if d:IsA("BasePart") then return d end
		end
	end

	local function makeInvisible(root)
		for _, d in ipairs(root:GetDescendants()) do
			if d:IsA("BasePart") then
				d.LocalTransparencyModifier = 1
				d.Transparency = 1
			elseif d:IsA("Decal") or d:IsA("Texture") then
				d.Transparency = 1
			end
		end
	end

	local function restoreVisibility(root)
		for _, d in ipairs(root:GetDescendants()) do
			if d:IsA("BasePart") then
				d.LocalTransparencyModifier = 0
				d.Transparency = 0
			elseif d:IsA("Decal") or d:IsA("Texture") then
				d.Transparency = 0
			end
		end
	end

	local function setNoCollide(model)
		for _, d in ipairs(model:GetDescendants()) do
			if d:IsA("BasePart") then
				d.CanCollide = false
				d.CanTouch = false
				d.CanQuery = false
				d.Massless = true
				d.Anchored = false
			end
		end
	end

	local function weldAllTo(anchor, container)
		for _, d in ipairs(container:GetDescendants()) do
			if d:IsA("BasePart") and d ~= anchor then
				local wc = Instance.new("WeldConstraint")
				wc.Part0 = anchor
				wc.Part1 = d
				wc.Parent = anchor
			end
		end
	end

	local function startInvisibilityEnforcer(tool)
		if invisConns[tool] then
			pcall(function() invisConns[tool]:Disconnect() end)
			invisConns[tool] = nil
		end
		local conn
		conn = RunService.RenderStepped:Connect(function()
			if not tool or not tool.Parent then
				conn:Disconnect()
				invisConns[tool] = nil
				return
			end
			local reskin = tool:FindFirstChild("LOCAL_ITEM_RESKIN")
			for _, d in ipairs(tool:GetDescendants()) do
				if reskin and d:IsDescendantOf(reskin) then continue end
				if d:IsA("BasePart") then
					d.LocalTransparencyModifier = 1
					d.Transparency = 1
				elseif d:IsA("Decal") or d:IsA("Texture") then
					d.Transparency = 1
				end
			end
		end)
		invisConns[tool] = conn
		table.insert(connections, conn)
	end

	local function attachReskin(tool, skinName)
		if not tool or tagged[tool] then return end
		tagged[tool] = true

		local origHandle = tool:FindFirstChild("Handle")
		if not (origHandle and origHandle:IsA("BasePart")) then
			origHandle = firstBasePart(tool)
		end
		if not origHandle then tagged[tool] = nil; return end

		local itemsFolder = RS:FindFirstChild("Items")
		if not itemsFolder then tagged[tool] = nil; return end
		local source = itemsFolder:FindFirstChild(skinName)
		if not source then tagged[tool] = nil; return end
		makeInvisible(tool)

		local clone = source:Clone()
		clone.Name = "LOCAL_ITEM_RESKIN"
		for _, d in ipairs(clone:GetDescendants()) do
			if d:IsA("Script") or d:IsA("LocalScript") or d:IsA("ModuleScript") then
				pcall(d.Destroy, d)
			end
		end

		setNoCollide(clone)
		clone.Parent = tool

		local cloneAnchor = clone:FindFirstChild("Handle")
		if not (cloneAnchor and cloneAnchor:IsA("BasePart")) then
			if clone:IsA("Model") then
				if not clone.PrimaryPart then
					local p = firstBasePart(clone)
					if p then pcall(function() clone.PrimaryPart = p end) end
				end
				cloneAnchor = clone.PrimaryPart
			end
			cloneAnchor = cloneAnchor or firstBasePart(clone)
		end

		if not cloneAnchor then
			clone:Destroy(); restoreVisibility(tool); tagged[tool] = nil; return
		end

		pcall(function() cloneAnchor.CFrame = origHandle.CFrame end)
		weldAllTo(cloneAnchor, clone)

		local w = Instance.new("Weld")
		w.Part0 = origHandle
		w.Part1 = cloneAnchor
		w.C0 = SKIN_OFFSETS[skinName] or CFrame.identity
		w.C1 = CFrame.identity
		w.Parent = cloneAnchor
		startInvisibilityEnforcer(tool)
	end

	local function weldAllToPrimary(model)
		local primary = model.PrimaryPart
		if not primary then return end
		for _, d in ipairs(model:GetDescendants()) do
			if d:IsA("BasePart") and d ~= primary then
				local wc = Instance.new("WeldConstraint")
				wc.Part0 = primary
				wc.Part1 = d
				wc.Parent = primary
			end
		end
	end

	local function attachCannonReskin(targetRoot, posOffset, heldScale)
		if not targetRoot or cannonTagged[targetRoot] then return end
		cannonTagged[targetRoot] = true

		local targetPart = targetRoot:FindFirstChild("Handle")
		if not (targetPart and targetPart:IsA("BasePart")) then
			targetPart = firstBasePart(targetRoot)
		end
		if not targetPart then cannonTagged[targetRoot] = nil; return end

		local skinName = getCurrentCannonSkinName()
		if not skinName then cannonTagged[targetRoot] = nil; return end
		local source = getCannonSkinSource(skinName)
		if not source then cannonTagged[targetRoot] = nil; return end

		makeInvisible(targetRoot)

		local clone = source:Clone()
		clone.Name = "LOCAL_CANNON_RESKIN"
		for _, d in ipairs(clone:GetDescendants()) do
			if d:IsA("Script") or d:IsA("LocalScript") or d:IsA("ModuleScript") then
				pcall(d.Destroy, d)
			end
		end

		if not clone:IsA("Model") then
			setNoCollide(clone)
			clone.Parent = targetRoot
			return
		end

		if not clone.PrimaryPart then
			local p = firstBasePart(clone)
			if p then pcall(function() clone.PrimaryPart = p end) end
		end
		if not clone.PrimaryPart then
			clone:Destroy(); cannonTagged[targetRoot] = nil; return
		end

		if heldScale and heldScale ~= 1 then
			pcall(function() clone:ScaleTo(heldScale) end)
		end

		setNoCollide(clone)
		clone.Parent = targetRoot

		local offset = posOffset or CFrame.identity
		pcall(function() clone:PivotTo(targetPart.CFrame * offset) end)

		weldAllToPrimary(clone)

		local wc = Instance.new("WeldConstraint")
		wc.Part0 = targetPart
		wc.Part1 = clone.PrimaryPart
		wc.Parent = clone.PrimaryPart
	end

	local function hookCannonThirdPerson(character)
		local function onChildAdded(child)
			if not (child:IsA("Tool") and child.Name == CANNON_TOOL_NAME) then return end
			task.wait()

			local handle = child:FindFirstChild("Handle") or firstBasePart(child)
			if not handle then return end

			local existing = child:FindFirstChild("LOCAL_CANNON_RESKIN")
			if existing then existing:Destroy(); cannonTagged[child] = nil end

			attachCannonReskin(child, CFrame.identity, CANNON_HAND_SCALE)

			local start = time()
			local conn
			conn = RunService.RenderStepped:Connect(function()
				if not child.Parent then conn:Disconnect(); return end
				makeInvisible(child)
				if time() - start > 3 then conn:Disconnect() end
			end)
			table.insert(cannonRenderConns, conn)
		end

		for _, c in ipairs(character:GetChildren()) do onChildAdded(c) end
		local conn = character.ChildAdded:Connect(onChildAdded)
		table.insert(cannonConnections, conn)
	end

	local function hookCannonViewmodel()
		local cam = workspace.CurrentCamera
		if not cam then return end
		local function hookVM(vm)
			for _, child in ipairs(vm:GetChildren()) do
				if child.Name == CANNON_TOOL_NAME then
					attachCannonReskin(child, CFrame.identity, CANNON_HAND_SCALE)
				end
			end
			local conn = vm.ChildAdded:Connect(function(child)
				if child.Name == CANNON_TOOL_NAME then
					task.wait()
					attachCannonReskin(child, CFrame.identity, CANNON_HAND_SCALE)
				end
			end)
			table.insert(cannonConnections, conn)
		end
		local vm = cam:FindFirstChild("Viewmodel")
		if vm then hookVM(vm) end
		local conn = cam.ChildAdded:Connect(function(child)
			if child.Name == "Viewmodel" then task.wait(); hookVM(child) end
		end)
		table.insert(cannonConnections, conn)
	end

	local function hookCannonContainer(container)
		if not container then return end
		for _, child in ipairs(container:GetChildren()) do
			if child.Name == CANNON_TOOL_NAME then
				attachCannonReskin(child, CFrame.identity, CANNON_HAND_SCALE)
			end
		end
		local conn = container.ChildAdded:Connect(function(child)
			if child.Name == CANNON_TOOL_NAME then
				task.wait()
				attachCannonReskin(child, CFrame.identity, CANNON_HAND_SCALE)
			end
		end)
		table.insert(cannonConnections, conn)
	end

	local function hookCannonBlocksFolder(blocksFolder)
		for _, child in ipairs(blocksFolder:GetChildren()) do
			if child.Name == CANNON_TOOL_NAME then
				attachCannonReskin(child, CANNON_PLACED_OFFSET, 1)
			end
		end
		local conn = blocksFolder.ChildAdded:Connect(function(child)
			if child.Name == CANNON_TOOL_NAME then
				task.wait()
				attachCannonReskin(child, CANNON_PLACED_OFFSET, 1)
			end
		end)
		table.insert(cannonConnections, conn)
	end

	local function hookAllWorldCannons()
		local map = workspace:FindFirstChild("Map")
		if not map then return end
		local worlds = map:FindFirstChild("Worlds")
		if not worlds then return end
		for _, world in ipairs(worlds:GetChildren()) do
			local blocks = world:FindFirstChild("Blocks")
			if blocks then hookCannonBlocksFolder(blocks) end
		end
		local conn = worlds.ChildAdded:Connect(function(world)
			task.wait()
			local blocks = world:FindFirstChild("Blocks")
			if blocks then hookCannonBlocksFolder(blocks) end
		end)
		table.insert(cannonConnections, conn)
	end

	local function hookCannonSounds()
		if soundsHooked then return end
		if not (bedwars and bedwars.CannonHandController) then return end
		soundsHooked = true
		oldFireCannon = bedwars.CannonHandController.fireCannon
		oldLaunchSelf = bedwars.CannonHandController.launchSelf

		local function replaceSound()
			for _, v in ipairs(workspace.SoundPool:GetChildren()) do
				if v:IsA("Sound") and v.SoundId == "rbxassetid://7121064180" then v:Destroy() end
			end
			local key = CANNON_SOUND_NAMES[CURRENT_SKIN_TYPE] or CANNON_SOUND_NAMES.Nightmare
			if bedwars.SoundManager and bedwars.SoundList and bedwars.SoundList[key] then
				bedwars.SoundManager:playSound(bedwars.SoundList[key])
			end
		end

		bedwars.CannonHandController.fireCannon = function(...) replaceSound(); return oldFireCannon(...) end
		bedwars.CannonHandController.launchSelf = function(...) replaceSound(); return oldLaunchSelf(...) end
	end

	local function unhookCannonSounds()
		if soundsHooked and bedwars and bedwars.CannonHandController then
			if oldFireCannon then bedwars.CannonHandController.fireCannon = oldFireCannon end
			if oldLaunchSelf then bedwars.CannonHandController.launchSelf = oldLaunchSelf end
		end
		oldFireCannon = nil; oldLaunchSelf = nil; soundsHooked = false
	end

	local function cleanupCannons()
		for _, c in pairs(cannonConnections) do pcall(function() c:Disconnect() end) end
		for _, c in pairs(cannonRenderConns) do pcall(function() c:Disconnect() end) end
		table.clear(cannonConnections)
		table.clear(cannonRenderConns)

		for root in pairs(cannonTagged) do
			if root and root.Parent then
				local r = root:FindFirstChild("LOCAL_CANNON_RESKIN")
				if r then r:Destroy() end
				restoreVisibility(root)
			end
		end
		table.clear(cannonTagged)

		local map = workspace:FindFirstChild("Map")
		if map then
			local worlds = map:FindFirstChild("Worlds")
			if worlds then
				for _, world in ipairs(worlds:GetChildren()) do
					local blocks = world:FindFirstChild("Blocks")
					if blocks then
						for _, child in ipairs(blocks:GetChildren()) do
							if child.Name == CANNON_TOOL_NAME then
								local r = child:FindFirstChild("LOCAL_CANNON_RESKIN")
								if r then r:Destroy() end
								restoreVisibility(child)
							end
						end
					end
				end
			end
		end

		unhookCannonSounds()
	end

	local function applyKitSkinHook()
		if not KitSkinCtrl then return end
		local val = getKitSkinValue()
		if not val then return end
		if not oldGetKitSkin then oldGetKitSkin = KitSkinCtrl.getKitSkin end
		KitSkinCtrl.getKitSkin = function(self, char)
			if char == LocalPlayer.Character then return val end
			return oldGetKitSkin(self, char)
		end
	end

	local function removeKitSkinHook()
		if KitSkinCtrl and oldGetKitSkin then
			KitSkinCtrl.getKitSkin = oldGetKitSkin
			oldGetKitSkin = nil
		end
	end

	local function applyStoreSkins()
		if not (bedwars and bedwars.Store) then return end
		local skins = getStoreSkins()
		savedStoreSkins = {}
		local state = bedwars.Store:getState()
		for _, pair in ipairs(skins) do
			if pair[1] and pair[2] then
				local prev = state.Locker and state.Locker.selectedItemSkins and state.Locker.selectedItemSkins[pair[1]]
				table.insert(savedStoreSkins, { pair[1], prev })
				pcall(function() bedwars.Store:dispatch({ type = "LockerSetItemSkin", itemType = pair[1], itemSkin = pair[2] }) end)
			end
		end
	end

	local function clearStoreSkins()
		if not (bedwars and bedwars.Store) then return end
		for _, saved in ipairs(savedStoreSkins) do
			pcall(function() bedwars.Store:dispatch({ type = "LockerSetItemSkin", itemType = saved[1], itemSkin = saved[2] }) end)
		end
		savedStoreSkins = {}
	end

	local function tryApply(child)
		if isCannonSkin() then return end
		local mappings = getCurrentMappings()

		local skinName = mappings[child.Name:lower()]

		if not skinName then
			local childNorm = normalizeName(child.Name)
			for k, v in pairs(mappings) do
				if normalizeName(k) == childNorm then skinName = v; break end
			end
		end

		if not skinName then return end
		task.wait()
		if child.Parent then attachReskin(child, skinName) end
	end

	local function hookViewmodel()
		local cam = workspace.CurrentCamera
		if not cam then return end
		local function hookVM(vm)
			for _, child in ipairs(vm:GetChildren()) do tryApply(child) end
			table.insert(connections, vm.ChildAdded:Connect(tryApply))
		end
		local vm = cam:FindFirstChild("Viewmodel")
		if vm then hookVM(vm) end
		table.insert(connections, cam.ChildAdded:Connect(function(child)
			if child.Name == "Viewmodel" then task.wait(); hookVM(child) end
		end))
	end

	local function hookContainer(container)
		if not container then return end
		for _, child in ipairs(container:GetChildren()) do tryApply(child) end
		table.insert(connections, container.ChildAdded:Connect(tryApply))
	end

	local function cleanupDeadTagged()
		for root in pairs(tagged) do
			if not root or not root.Parent then
				tagged[root] = nil
			end
		end
		for tool in pairs(invisConns) do
			if not tool or not tool.Parent then
				pcall(function() invisConns[tool]:Disconnect() end)
				invisConns[tool] = nil
			end
		end
	end

	local function onCharacterAdded(character)
		task.wait(0.2)
		cleanupDeadTagged()
		applyKitSkinHook()
		if isCannonSkin() then
			hookCannonContainer(LocalPlayer.Backpack)
			hookCannonContainer(character)
			hookCannonThirdPerson(character)
		else
			hookContainer(LocalPlayer.Backpack)
			hookContainer(character)
		end
	end

	local function cleanup()
		for tool, conn in pairs(invisConns) do
			pcall(function() conn:Disconnect() end)
		end
		table.clear(invisConns)

		for _, c in pairs(connections) do pcall(function() c:Disconnect() end) end
		table.clear(connections)
		for root in pairs(tagged) do
			if root and root.Parent then
				local r = root:FindFirstChild("LOCAL_ITEM_RESKIN")
				if r then r:Destroy() end
				restoreVisibility(root)
			end
		end
		table.clear(tagged)
		removeKitSkinHook()
		clearStoreSkins()
		cleanupCannons()
	end

	local skinNames = {}
	for name in pairs(SKIN_DATA) do table.insert(skinNames, name) end
	for name in pairs(CANNON_SKIN_NAMES) do table.insert(skinNames, name) end
	table.sort(skinNames)

	local SkinTypeDropdown

	SkinChanger = vape.Categories.Render:CreateModule({
		Name = "SkinChanger",
		Function = function(enabled)
			if enabled then
				if isCannonSkin() then
					hookCannonViewmodel()
					hookAllWorldCannons()
					hookCannonSounds()
					applyKitSkinHook()
					if LocalPlayer.Character then
						hookCannonContainer(LocalPlayer.Backpack)
						hookCannonContainer(LocalPlayer.Character)
						hookCannonThirdPerson(LocalPlayer.Character)
					end
				else
					hookViewmodel()
					applyKitSkinHook()
					applyStoreSkins()
					if LocalPlayer.Character then onCharacterAdded(LocalPlayer.Character) end
				end
				table.insert(connections, LocalPlayer.CharacterAdded:Connect(onCharacterAdded))
			else
				cleanup()
			end
		end,
		Tooltip = "Client-sided item skin changer",
	})

	SkinChanger:CreateDropdown({
		Name = "Item Skin",
		List = skinNames,
		Default = CURRENT_ITEM_SKIN,
		Function = function(val)
			CURRENT_ITEM_SKIN = val
			if SkinTypeDropdown and SkinTypeDropdown.Object then
				SkinTypeDropdown.Object.Visible = TIERED_SKINS[val] == true
			end
			if SkinChanger.Enabled then SkinChanger:Toggle(); SkinChanger:Toggle() end
		end,
	})

	SkinTypeDropdown = SkinChanger:CreateDropdown({
		Name = "Skin Type",
		List = { "Gold", "Platinum", "Diamond", "Emerald", "Nightmare", "Default" },
		Default = CURRENT_SKIN_TYPE,
		Function = function(val)
			CURRENT_SKIN_TYPE = val
			if SkinChanger.Enabled then SkinChanger:Toggle(); SkinChanger:Toggle() end
		end,
	})

	task.defer(function()
		if SkinTypeDropdown and SkinTypeDropdown.Object then
			SkinTypeDropdown.Object.Visible = TIERED_SKINS[CURRENT_ITEM_SKIN] == true
		end
		if SkinTypeDropdown and SkinTypeDropdown.Set then
			SkinTypeDropdown:Set(CURRENT_SKIN_TYPE)
		end
	end)
end)


----


local vape = shared.vape
local entitylib = vape.Libraries.entity
local runService = game:GetService('RunService')
local replicatedStorage = game:GetService('ReplicatedStorage')
local httpService = game:GetService('HttpService')
local playersService = game:GetService('Players')
local lplr = playersService.LocalPlayer
local OwlAura
local Targets
local RangeSlider
local PROJECTILE_SPEED = 220
local SHOOT_COOLDOWN = 0.87
local lastShot = 0

local function getOwlModel()
	return workspace:FindFirstChild("ClientOwl")
end

local function getBulletOrigin(owl)
	local primary = owl and owl.PrimaryPart
	if not primary then return nil end
	local bo = primary:FindFirstChild("bulletOrigin")
	return bo and bo.WorldPosition or primary.Position
end

local function fireOwlProjectile(fromPos, targetPos, targetVel)
	local owl = getOwlModel()
	if not owl then return end
	local owlHandle = owl:FindFirstChild("Handle") or owl.PrimaryPart
	if not owlHandle then return end

	local NetManaged = replicatedStorage
		:WaitForChild("rbxts_include")
		:WaitForChild("node_modules")
		:WaitForChild("@rbxts")
		:WaitForChild("net")
		:WaitForChild("out")
		:WaitForChild("_NetManaged")

	local owlAiming = NetManaged:FindFirstChild("OwlAiming")
	local owlFireProjectile = NetManaged:FindFirstChild("OwlFireProjectile")
	if not owlAiming or not owlFireProjectile then return end

	local direction = (targetPos - fromPos).Unit * PROJECTILE_SPEED
	local refId = httpService:GenerateGUID(false):sub(1, 8):upper()

	owlAiming:FireServer({ owl = owlHandle, starting = true })
	task.wait(0.05)
	owlAiming:FireServer({ owl = owlHandle, starting = false })
	owlFireProjectile:FireServer({
		fromPosition = fromPos,
		direction = direction,
		offset = nil,
		ProjectileRefId = refId,
		initialVelocity = direction
	})
end

OwlAura = vape.Categories.Blatant:CreateModule({
	Name = 'OwlAura',
	Tooltip = 'auto shoots at nearby enemies...',
	Function = function(callback)
		if callback then
			OwlAura:Clean(runService.Heartbeat:Connect(function()
				if tick() - lastShot < SHOOT_COOLDOWN then return end
				if not entitylib.isAlive then return end

				local owl = getOwlModel()
				local myRoot = lplr.Character and lplr.Character:FindFirstChild("HumanoidRootPart")
				if not myRoot then return end
				local fromPos = owl and getBulletOrigin(owl) or myRoot.Position

				local ent = entitylib.EntityPosition({
					Range = RangeSlider and RangeSlider.Value or 40,
					Part = 'RootPart',
					Origin = fromPos,
					Wallcheck = Targets.Walls.Enabled,
					Players = Targets.Players.Enabled,
					NPCs = Targets.NPCs.Enabled,
				})

				if not ent or not ent.RootPart then return end

				local rootPos = ent.RootPart.Position
				local vel = ent.RootPart.AssemblyLinearVelocity
				local dist = (fromPos - rootPos).Magnitude
				local timeToHit = dist / PROJECTILE_SPEED
				local predictedPos = rootPos + vel * timeToHit

				lastShot = tick()
				fireOwlProjectile(fromPos, predictedPos, Vector3.zero)
			end))
		end
	end
})

Targets = OwlAura:CreateTargets({})
RangeSlider = OwlAura:CreateSlider({
	Name = 'Range',
	Min = 10,
	Max = 60,
	Default = 40,
	Suffix = function(val)
		return val == 1 and 'stud' or 'studs'
	end
})


-----


local vape = shared.vape
local runService = game:GetService('RunService')
local KrystalDisabler
local old = nil
local renderConn = nil
local bedwarsCtrl = nil
local store = getgenv().store or {}

local function setup()
	local ok, Knit = pcall(function()
		return require(game.ReplicatedStorage.rbxts_include.node_modules['@easy-games'].knit.src).KnitClient
	end)
	if not ok or not Knit.Controllers.GlacialSkaterController then return false end
	if store.equippedKit ~= 'glacial_skater' then return false end
	local Client = require(game.ReplicatedStorage.TS.remotes).default.Client
	bedwarsCtrl = { GlacialSkaterController = Knit.Controllers.GlacialSkaterController }
	old = bedwarsCtrl.GlacialSkaterController.updateMomentum
	bedwarsCtrl.GlacialSkaterController.updateMomentum = function(self, ...)
		self.momentum = 9e9
		self.lastMomentumReport = 9e9
		pcall(function()
			Client:Get('MomentumUpdate'):SendToServer({ momentumValue = 9e9 })
		end)
	end
	return true
end

KrystalDisabler = vape.Categories.Blatant:CreateModule({
	Name = 'KrystalDisabler',
	Tooltip = 'Requires Krystal kit.',
	Function = function(callback)
		if callback then
			local ok = setup()
			if not ok then
				vape:CreateNotification("KrystalDisabler", "Not on Krystal kit!", 5, 'alert')
				KrystalDisabler:Toggle()
				return
			end
			renderConn = runService.RenderStepped:Connect(function()
				if not bedwarsCtrl then return end
				pcall(function()
					bedwarsCtrl.GlacialSkaterController:updateMomentum(9e9, 'newValue')
				end)
			end)
			vape:CreateNotification("KrystalDisabler", "Reset to use disabler", 5)
		else
			if renderConn then
				renderConn:Disconnect()
				renderConn = nil
			end
			if bedwarsCtrl and old then
				bedwarsCtrl.GlacialSkaterController.updateMomentum = old
				old = nil
			end
			bedwarsCtrl = nil
		end
	end
})

------


local cloneref = cloneref or function(obj) return obj end
local runService = cloneref(game:GetService('RunService'))
local replicatedStorage = cloneref(game:GetService('ReplicatedStorage'))
local httpService = cloneref(game:GetService('HttpService'))
local playersService = cloneref(game:GetService('Players'))
local inputService = cloneref(game:GetService('UserInputService'))
local statsService = cloneref(game:GetService("Stats"))


local gameCamera = workspace.CurrentCamera
local lplr = playersService.LocalPlayer

local vape = shared.vape or {}
local entitylib = vape.Libraries.entity
local targetinfo = vape.Libraries.targetinfo
local bedwars = getgenv().bedwars or {}
local store = getgenv().store or {}

local rakNet = (typeof(raknet) == 'table' or false)

run(function()
    local BackTrack
    local Mode
    local Delay

    local OldGet
    local enabled
    local posHistory = {}
    local rakhookLoop = nil
    local rakhookActive = false

    local function hook(pckt)
        if pckt.AsArray[1] == 0x1b then
            local data = pckt.AsBuffer
            buffer.writeu32(data,1,0xFFFFFFFF)
            pckt:SetData(data)
        end
    end
    
    local function getTargetRoot()
        local bestPlayer = nil
        local bestDot = -2
        local nearestDist = math.huge

        if not entitylib or not lplr.Character.HumanoidRootPart then return nil end
        if not entitylib.isAlive then return nil end

        for _, ent in entitylib.List do
            if ent.Player ~= lplr and ent.Character then
                local root = ent.Character:FindFirstChild('HumanoidRootPart')
                if root then
                    local dir = (root.Position - lplr.Character.HumanoidRootPart.Position).Unit
                    local dot = dir:Dot(gameCamera.CFrame.LookVector)
                    if dot > bestDot and dot > 0.5 then
                        bestDot = dot
                        bestPlayer = root
                    end
                    if not bestPlayer then
                        local dist = (root.Position - lplr.Character.HumanoidRootPart.Position).Magnitude
                        if dist < nearestDist then
                            nearestDist = dist
                            bestPlayer = root
                        end
                    end
                end
            end
        end

        return bestPlayer
    end

    local function calculateDynamicDelay()
        local targetRoot = getTargetRoot()
        if not targetRoot then return 0.2 end
        if not entitylib.isAlive then return 0.2 end
        if not entitylib.RootPart then return 0.2 end

        local selfpos = lplr.Character.HumanoidRootPart.Position
        local targetpos = targetRoot.Position
        local distance = (selfpos - targetpos).Magnitude

        local ping = 0.1
        local suc, res = pcall(function()
            ping = statsService.Network.ServerStatsItem["Data Ping"]:GetValue() / 1000
        end)
        if not suc then
            ping = lplr:GetNetworkPing()
        end

        local baseDelay = 0.2
        local PingFactor = ping * 1.5
        local distanceFactor = math.clamp((distance - 12) / 20, 0, 0.3)
        local dynamicDelay = math.clamp((baseDelay + PingFactor + distanceFactor),0.1,0.5)

        return dynamicDelay
    end

    local function getHistorialPos(ago)
        local currentTime = tick()
        local targetTime = (currentTime - ago)
        local best = nil
        local bestDiff = math.huge
        for _, entry in ipairs(posHistory) do
            local diff = math.abs(entry.time - targetTime) * math.pi
            if diff < bestDiff then
                bestDiff = diff
                best = entry.pos
            end
        end
        return best
    end

    local function startFetching()
        BackTrack:Clean(runService.RenderStepped:Connect(function()
            local targetRoot = getTargetRoot()
            if targetRoot then
                table.insert(posHistory,{
                    time = tick(),
                    pos = targetRoot.Position
                })
                if #posHistory > 200 then
                    table.remove(posHistory, 1)
                end
            end
        end))
    end

    local function hookClient()
        if OldGet then return end
        OldGet = bedwars.Client.Get
        bedwars.Client.Get = function(self, remoteName)
            local call = OldGet(self, remoteName)
            if remoteName == 'SwordHit' then
                return {
                    instance = call.instance,
                    SendToServer = function(_, attackTable, ...)
                        if Mode.Value == 'Repel' then
                            local selfpos = lplr.Character.HumanoidRootPart.Position
                            local targetpos = getTargetRoot()
                            if targetpos then
                                targetpos = targetpos.Position
                                local dist = (selfpos - targetpos).Magnitude
                                if dist >= 14.388 then
                                    attackTable.validate = attackTable.validate or {}
                                    attackTable.validate.selfPosition = attackTable.validate.selfPosition or {value = selfpos}
                                    attackTable.validate.selfPosition.value += CFrame.lookAt(selfpos, targetpos).LookVector * (dist - 14.388)
                                end
                            end
                        elseif Mode.Value == 'Default' then
                            local ago = Delay.Value / 1000
                            local oldpos = getHistorialPos(ago)
                            if oldpos then
                                attackTable.validate = attackTable.validate or {}
                                attackTable.validate.targetPosition = attackTable.validate.targetPosition or {value = oldpos}
                                attackTable.validate.targetPosition.value = oldpos
                            end
                        elseif Mode.Value == 'Dynamic' then
                            local dynDelay = calculateDynamicDelay()
                            local oldPos = getHistorialPos(dynDelay)
                            if oldPos then
                                attackTable.validate = attackTable.validate or {}
                                attackTable.validate.targetPosition = attackTable.validate.targetPosition or {value = oldPos}
                                attackTable.validate.targetPosition.value = oldPos
                            end
                        end
                        return call:SendToServer(attackTable, ...)
                    end
                }
            end
            return call
        end
    end

    local function unHookClient()
        if OldGet then
            bedwars.Client.Get = OldGet
            OldGet = nil
        end
    end

    local function startRaknetLoop()
        if rakhookLoop then return end
        if not rakNet then return end
        rakhookLoop = runService.Heartbeat:Connect(function()
            if not enabled then return end
            local tme = Delay.Value / 1000
            raknet.add_send_hook(hook)
            task.delay(tme, function()
                if rakhookLoop then
                    raknet.remove_send_hook(hook)
                end
            end)
            rakhookLoop:Disconnect()
            rakhookLoop = nil
            task.wait(tme)
            if enabled then startRaknetLoop() end
        end)
    end

    local function stopRaknetLoop()
        if rakhookLoop then
            rakhookLoop:Disconnect()
            rakhookLoop = nil
        end
        if rakNet then
            pcall(function() raknet.remove_send_hook(hook) end)
        end
    end

    local function fullCleanup()
        unHookClient()
        stopRaknetLoop()
    end

    BackTrack = vape.Categories.World:CreateModule({
        Name = 'BackTrack',
        Tooltip = 'allows you to manipulate the server movement to be delayed in a different report',
        Function = function(callback)
            if callback then
                if not rakNet then
                    vape:CreateNotification("Vape", "Raknet is not founded or enabled? BackTrack will be removed due to the core feature missing",16)
                    vape:Remove('BackTrack')
                    return
                end
                vape:CreateNotification("Vape", "Raknet is enabled and founded! using server side packets modifications",24)
                enabled = true
                startFetching()
                hookClient()
                startRaknetLoop()
            else
                enabled = false
                fullCleanup()
            end

        end
    })

    Mode = BackTrack:CreateDropdown({
        Name = "Mode",
        List = {"Repel", "Dynamic", "Default"},
        Default = "Default",
        Function = function(val)
            if val == "Default" or val == "Dynamic" then
                startFetching()
            end
        end
    })

    Delay = BackTrack:CreateSlider({
        Name = "Delay",
        Min = 0,
        Max = 10000,
        Default = math.random(2500, 4500),
        Suffix = "ms",
    })
end)


---------

local cloneref = cloneref or function(obj) return obj end
local runService = cloneref(game:GetService('RunService'))
local replicatedStorage = cloneref(game:GetService('ReplicatedStorage'))
local httpService = cloneref(game:GetService('HttpService'))
local playersService = cloneref(game:GetService('Players'))
local inputService = cloneref(game:GetService('UserInputService'))


local gameCamera = workspace.CurrentCamera
local lplr = playersService.LocalPlayer

local vape = shared.vape
local entitylib = vape.Libraries.entity
local targetinfo = vape.Libraries.targetinfo
local bedwars = getgenv().bedwars
local store = getgenv().store
local remotes = getgenv().remotes


local function getAccountTier(player)
	if getgenv().getAccountTier then
		return getgenv().getAccountTier(player)
	end
	return 0
end  

local function isFrozen(entity, threshold)
    threshold = threshold or 10
    local char
    if type(entity) == "table" and entity.Character then
        char = entity.Character
    elseif type(entity) == "Instance" and entity:IsA("Model") then
        char = entity
    elseif entity == nil then
        if not entitylib.isAlive then return false end
        char = entitylib.character.Character
    else
        return false
    end

    local stacks = char:GetAttribute("ColdStacks") or char:GetAttribute("FrostStacks")
               or char:GetAttribute("FreezeStacks") or char:GetAttribute("FROZEN_STACKS")
    if stacks and stacks >= threshold then return true end

    local statusEffects = char:GetAttribute("StatusEffects")
    if type(statusEffects) == "table" then
        for effectName, stackCount in pairs(statusEffects) do
            local nameLower = tostring(effectName):lower()
            if nameLower:match("cold") or nameLower:match("frost") or nameLower:match("freeze") then
                if type(stackCount) == "number" then
                    if stackCount >= threshold then return true end
                elseif stackCount then
                    return true
                end
            end
        end
    end

    if char:FindFirstChild("IceBlock") or char:FindFirstChild("FrozenBlock") or char:FindFirstChild("IceShell") then
        return true
    end

    local humanoid = char:FindFirstChildOfClass("Humanoid")
    if humanoid and humanoid.WalkSpeed <= 2 then
        return true
    end

    return false
end

local function switchItem(tool, delayTime)
	delayTime = delayTime or 0.05
	local check = lplr.Character and lplr.Character:FindFirstChild('HandInvItem') or nil
	if check and check.Value ~= tool and tool.Parent ~= nil then
		task.spawn(function()
			bedwars.Client:Get(remotes.EquipItem):CallServerAsync({hand = tool})
		end)
		check.Value = tool
		if delayTime > 0 then
			task.wait(delayTime)
		end
		return true
	end
end

run(function()
	local SilentAura
	local Targets
	local AimSpeed
	local AimSmoothness
	local AimShake
	local AimShakeValue
	local Angle
	local Sort
	local SyncHits
	local Mouse
	local Swing
	local SilentAim
	local Limit
	local TargetArea
	local ChargeTime
	local ChargeTimeSlider
	local UpdateRate
	local ExtendAttackRange
	local ExtendSwingRange

	local defaultAttackRange = 12.6
	local defaultSwingRange = 14.4
	local lastAttackTime = 0
	local Attacking = false
	local AnimDelay = 0
	local swingCooldown = 0
	local rng = Random.new()
	local SyncChecks = {
		ViewSwing = false,
		ThirdSwing = false,
	}
	local lastAnimationTime = 0
	local isClaw = false
    local lastCharge = tick()
    local lc = 0

	local AttackRemote = nil

	local Boxes = {}
	local suc, res = pcall(function()
		AttackRemote = bedwars.Client:Get('SwordHit')
	end)


	local kitChecks = {
		['Sophia'] = function() return isFrozen(nil, 10) end,
		['Sigrid'] = function() return entitylib.isAlive and lplr.Character and lplr.Character:FindFirstChild('elk') ~= nil end,
	}

	local function setupAnimationTracking()
		if not getgenv().oldViewModelKA then
			getgenv().oldViewModelKA = bedwars.ViewmodelController.playAnimation
		end
		bedwars.ViewmodelController.playAnimation = function(...)
			local call = {...}
			local id = select(2, ...)
			if id == 15 or id == '15' or id == 16 or id == '16' then
				SyncChecks.ViewSwing = true
				lastAnimationTime = tick()
				task.delay(0.2, function()
					SyncChecks.ViewSwing = false
				end)
			end
			return getgenv().oldViewModelKA(unpack(call))
		end

		if not getgenv().oldSwordCtlerKA then
			getgenv().oldSwordCtlerKA = bedwars.SwordController.playSwordEffect
		end
		bedwars.SwordController.playSwordEffect = function(...)
			local call = {...}
			SyncChecks.ThirdSwing = true
			lastAnimationTime = tick()
			task.delay(0.2, function()
				SyncChecks.ThirdSwing = false
			end)
			return getgenv().oldSwordCtlerKA(unpack(call))
		end
	end

	local function getAttackData()
		local stunTime = lplr.Character and lplr.Character:GetAttribute('StunnedUntilTime')
		if stunTime and stunTime > workspace:GetServerTimeNow() then return false end
		
		for _, check in pairs(kitChecks) do
			if check() then return false end
		end

		if bedwars.SummonerKitController:isPlayerCastingSpell(lplr) then return false end
		
		if Mouse.Enabled then
			local recentSwing = (tick() - bedwars.SwordController.lastSwing) <= 0.2
			if not recentSwing and not inputService:IsMouseButtonPressed(Enum.UserInputType.MouseButton1) then
				return false
			end
		end

		if bedwars.AppController:isLayerOpen(bedwars.UILayers.MAIN) then return false end

		local sword = Limit.Enabled and store.hand or store.tools.sword
		if not sword or not sword.tool then return false end

		if Limit.Enabled and (store.hand.toolType ~= 'sword' or bedwars.DaoController.chargingMaid) then 
			return false 
		end

		if SyncHits and SyncHits.Enabled then
			return sword, bedwars.ItemMeta[sword.tool.Name], true
		else
			local chargeTimeValue = (ChargeTime and ChargeTime.Enabled and ChargeTimeSlider and ChargeTimeSlider.Value) or 0.38
			return sword, bedwars.ItemMeta[sword.tool.Name], (tick() - lastAttackTime) >= chargeTimeValue
		end
	end

	local function playSwordAnimation(meta)
		if not meta then return end
		pcall(function()
			if isClaw then
				bedwars.SummonerClawController:clawAttack(lplr, entitylib.character.RootPart.Position, gameCamera.CFrame.LookVector, store.hand.tool.Name or 'summoner_claw_1')
			else
				bedwars.SwordController:playSwordEffect(meta, false)
				if meta.displayName and meta.displayName:find(' Scythe') then
					bedwars.ScytheController:playLocalAnimation()
				end
			end
		end)
	end

	local function SilentAimFunc(ent, dt)
		if not SilentAim.Enabled or not ent or not ent.RootPart then return end

		local root = entitylib.character.RootPart
		local aimPos

		if TargetArea.Value == 'Head' then
			local head = ent.Character and ent.Character:FindFirstChild('Head')
			aimPos = head and head.Position or ent.RootPart.Position + Vector3.new(0, 2.5, 0)
		else
			aimPos = ent.RootPart.Position + Vector3.new(0, 2, 0)
		end

		local noise = (rng:NextNumber() - 0.5) * (AimShake.Enabled and AimShakeValue.Value / 8 or 1.2)
		aimPos += Vector3.new(noise * 0.6, noise * 0.3 + (rng:NextNumber()-0.5)*0.4, noise * 0.6)

		local baseSpeed = (AimSpeed.Value or 4.2) / 10
		local smoothness = (AimSmoothness.Value or 12) / 30
		local speed = math.clamp(baseSpeed * (1 - smoothness) + 0.11, 0.07, 0.89)

		local targetCFrame = CFrame.lookAt(gameCamera.CFrame.Position, aimPos)
		gameCamera.CFrame = gameCamera.CFrame:Lerp(targetCFrame, speed)
	end

	SilentAura = vape.Categories.Combat:CreateModule({
		Name = 'SilentAura',
		Tooltip = 'legit killaura',
		Function = function(callback)
			if callback then
				if not suc then
					vape:CreateNotification('Vape', 'Remote fetch failed. Using fallback.', 16, 'warning')
                    AttackRemote = {
                        SendToServer = function(...)
                            local args = {...}
                            replicatedStorage:FindFirstChild("rbxts_include"):FindFirstChild("node_modules"):FindFirstChild("@rbxts"):FindFirstChild("net"):FindFirstChild("out"):FindFirstChild("_NetManaged"):FindFirstChild("SwordHit"):FireServer(unpack(args))
                        end,
                    }
				else
					AttackRemote = res
				end

				if vape.Modules.Killaura and vape.Modules.Killaura.Enabled then
					vape.Modules.Killaura:Toggle()
				end
				if vape.Modules.GrandKillaura and vape.Modules.GrandKillaura.Enabled then
					vape.Modules.GrandKillaura:Toggle()
				end

				setupAnimationTracking()

				local currentTarget = nil
				local lastTargetSwitch = 0
				local lastAttack = 0
				local lastSwingAnimTime = 0

				SilentAura:Clean(runService.Heartbeat:Connect(function(dt)
					if not entitylib.isAlive then return end

					local root = entitylib.character.RootPart
					if not root then return end

					local swingRange = defaultSwingRange + (ExtendSwingRange and ExtendSwingRange.Value or 0)
					
					local Plrs = entitylib.AllPosition({
						Range = swingRange,
						Wallcheck = Targets.Walls.Enabled,
						Part = 'RootPart',
						Players = Targets.Players.Enabled,
						NPCs = Targets.NPCs.Enabled,
						Limit = 1,
					})

					if #Plrs > 0 then
						local best = Plrs[1]
						if best ~= currentTarget and (tick() - lastTargetSwitch) > 0.12 then
							if currentTarget and math.random(1,100) <= 28 then
								return
							end
							currentTarget = best
							lastTargetSwitch = tick()
						end
					else
						currentTarget = nil
					end

					if not currentTarget or not currentTarget.RootPart then
						Attacking = false
						store.SilentauraTarget = nil
						return
					end

					Attacking = true
					store.SilentauraTarget = currentTarget

					SilentAimFunc(currentTarget, dt)

					local ent = currentTarget
					local delta = ent.RootPart.Position - root.Position
					local distance = delta.Magnitude

					local sword, meta, canAttack = getAttackData()
					local attackRange = defaultAttackRange + (ExtendAttackRange and ExtendAttackRange.Value or 0)

					if sword and canAttack and distance <= attackRange then
						switchItem(sword.tool, 0)
						local now = tick()
						local minDelay = 0.17
						
						if SyncHits and SyncHits.Enabled then
							minDelay = 0.12
						else
							minDelay = (ChargeTime and ChargeTime.Enabled and ChargeTimeSlider and ChargeTimeSlider.Value) or 0.38
						end

						if (now - lastAttack) >= minDelay + rng:NextNumber(0, 0.065) then
							if math.random(1, 100) <= 9 then
								lastAttack = now + 0.08
								return
							end

							if SyncHits and SyncHits.Enabled then
								playSwordAnimation(meta)
								lastSwingAnimTime = now
								task.wait(lplr:GetNetworkPing())
								if not SyncChecks.ViewSwing and not SyncChecks.ThirdSwing then
									task.wait(0.03)
								end
							else
								if not Swing.Enabled then
									playSwordAnimation(meta)
								end
							end

							local camPos = gameCamera.CFrame.Position
							local dir = (ent.RootPart.Position - camPos).Unit

							lastAttack = now
							lastAttackTime = now
                            lc = lastCharge
                            lastCharge = tick() - lc
                            

							local attackData = {
								weapon = sword.tool,
								entityInstance = ent.Character,
								chargedAttack = {chargeRatio = lastCharge},
								validate = {
									raycast = {
										cameraPosition = {value = camPos},
										cursorDirection = {value = dir}
									},
									targetPosition = {value = ent.RootPart.Position},
									selfPosition = {value = root.Position}
								}
							}

							local dsuc, dres = pcall(function()
								return playersService:GetPlayerFromCharacter(attackData.entityInstance)
							end)

							if dsuc then
								pcall(function()
									if getAccountTier(dres) == 4 and getAccountTier(lplr) == 0 then lastAttack = lastAttack * 6 end
									if getAccountTier(dres) >= 99 and getAccountTier(lplr) <= 4 then lastAttack = math.huge end
								end)
							end

							pcall(function()
                                lastCharge = tick()
								bedwars.Client:Get('SwordHit'):SendToServer(attackData)
							end)

							targetinfo.Targets[ent] = now + 1
						end
					end
				end))

			else
				Attacking = false
				store.SilentauraTarget = nil
				if getgenv().oldViewModelKA then
					bedwars.ViewmodelController.playAnimation = getgenv().oldViewModelKA
				end
				if getgenv().oldSwordCtlerKA then
					bedwars.SwordController.playSwordEffect = getgenv().oldSwordCtlerKA
				end
			end
		end
	})
	
	repeat task.wait(0.08) until SilentAura
	
	Targets = SilentAura:CreateTargets({ 
		Players = true, 
		Walls = true 
	})

	SilentAim = SilentAura:CreateToggle({
		Name = 'Silent Aim',
		Default = true,
		Function = function(c)
			if AimSpeed then AimSpeed.Object.Visible = c end
			if AimSmoothness then AimSmoothness.Object.Visible = c end
			if AimShake then AimShake.Object.Visible = c end
            if TargetArea then TargetArea.Object.Visible = c end
		end
	})

	TargetArea = SilentAura:CreateDropdown({ 
		Name = 'Target Area', 
		List = {'RootPart', 'Head'},
        Visible = SilentAim.Enabled,
	})

	AimSpeed = SilentAura:CreateSlider({ 
		Name = "Aim Speed", 
		Min = 1, 
		Max = 10, 
		Default = 4.2,
        Visible = SilentAim.Enabled,
	})

	AimSmoothness = SilentAura:CreateSlider({ 
		Name = "Aim Smoothness", 
		Min = 1, 
		Max = 30, 
		Default = 13,
        Visible = SilentAim.Enabled,
	})

	AimShake = SilentAura:CreateToggle({
		Name = "Aim Shake",
		Default = true,
        Visible = SilentAim.Enabled,
		Function = function(c)
			if AimShakeValue then AimShakeValue.Object.Visible = c end
		end
	})

	AimShakeValue = SilentAura:CreateSlider({ 
		Name = "Shake Amount", 
		Min = 1, 
		Max = 12,
		Default = 3.5, 
		Visible = AimShake.Enabled 
	})

	SyncHits = SilentAura:CreateToggle({
		Name = 'Sync Hits',
		Tooltip = 'when enabled syncs attacks with sword animations\n when enabled off uses Charge Time value for attack speed.',
		Default = false,
		Function = function(c)
			if ChargeTime then 
				ChargeTime.Object.Visible = not c
			end
			if ChargeTimeSlider then
				ChargeTimeSlider.Object.Visible = not c
			end
		end
	})

	ChargeTime = SilentAura:CreateToggle({
		Name = 'Custom Charge Time',
		Default = true,
		Visible = true,
		Function = function(c)
			if ChargeTimeSlider then
				ChargeTimeSlider.Object.Visible = c and not SyncHits.Enabled
			end
		end
	})

	ChargeTimeSlider = SilentAura:CreateSlider({
		Name = 'Charge Time Value', 
		Min = 0.1, 
		Max = 1, 
		Default = 0.38, 
		Decimal = 100,
		Suffix = 's',
		Tooltip = 'Time between attacks when Sync Hits is OFF',
		Visible = true
	})

	Mouse = SilentAura:CreateToggle({Name = "Require Mouse down"})
	Swing = SilentAura:CreateToggle({ Name = "Swing Only", Tooltip = "Only swings visually, doesn't attack" })
	Limit = SilentAura:CreateToggle({Name = "Limit to items"})

	Angle = SilentAura:CreateSlider({ 
		Name = 'Max Angle', 
		Min = 60,
		Max = 360,
		Default = 145 
	})

	ExtendAttackRange = SilentAura:CreateSlider({ 
		Name = 'Extend Attack Range', 
		Min = 0, 
		Max = 8, 
		Default = 1.4, 
		Decimal = 100
	})

	ExtendSwingRange = SilentAura:CreateSlider({ 
		Name = 'Extend Swing Range', 
		Min = 0, 
		Max = 12, 
		Default = 3.2,
		Decimal = 100
	})

	UpdateRate = SilentAura:CreateSlider({ 
		Name = 'Update Rate', 
		Suffix = 'hz', 
		Min = 15, 
		Max = 90, 
		Default = 45 
	})

	task.defer(function()
		if AimSpeed then AimSpeed.Object.Visible = SilentAim.Enabled end
		if AimSmoothness then AimSmoothness.Object.Visible = SilentAim.Enabled end
		if AimShake then AimShake.Object.Visible = SilentAim.Enabled end
		if ChargeTime and SyncHits then
			ChargeTime.Object.Visible = not SyncHits.Enabled
			if ChargeTimeSlider then
				ChargeTimeSlider.Object.Visible = not SyncHits.Enabled and ChargeTime.Enabled
			end
		end
	end)

end)


------------


local cloneref = cloneref or function(obj) return obj end
local runService = cloneref(game:GetService('RunService'))
local replicatedStorage = cloneref(game:GetService('ReplicatedStorage'))
local httpService = cloneref(game:GetService('HttpService'))
local playersService = cloneref(game:GetService('Players'))
local inputService = cloneref(game:GetService('UserInputService'))


local gameCamera = workspace.CurrentCamera
local lplr = playersService.LocalPlayer

local vape = shared.vape
local entitylib = vape.Libraries.entity
local targetinfo = vape.Libraries.targetinfo
local bedwars = getgenv().bedwars
local store = getgenv().store

local CK = {}

function CK:blood_assassin(callback, module)
    
    if not module then return end
    if callback then
        store.CleanKit[lplr:GetAttribute('PlayingAsKits') or 'none'] = true
        module:Clean(workspace.DescendantAdded:Connect(function(child)
            if vape.ThreadFix then setthreadidentity(8) end
            if child and child.Name == 'BloodAssassinDecay' then
                pcall(function()
                    child:Destroy()
                end)
            end
        end))
        for _, child in workspace:GetDescendants() do
            if vape.ThreadFix then setthreadidentity(8) end
            if child and child.Name == 'BloodAssassinDecay' then
                pcall(function()
                    child:Destroy()
                end)
            end
        end
    else
        store.CleanKit[lplr:GetAttribute('PlayingAsKits') or 'none'] = false
        print('caitlyn off')
    end
end

function CK:drill(callback, module)
    
    if not module then return end
    if callback then
        store.CleanKit[lplr:GetAttribute('PlayingAsKits') or 'none'] = true
        module:Clean(workspace.ChildAdded:Connect(function(child)
            if vape.ThreadFix then setthreadidentity(8) end
            if child and child.Name == 'Drill' then
                for _, v in child:GetDescendants() do
                    if v:IsA('BasePart') then
                        bedwars.QueryUtil:setQueryIgnored(v, true)
                    end
                end
            end
            if child and child.Name == 'diamond' or child.Name == 'gold' or child.Name == 'emerald' then
                if vape.ThreadFix then setthreadidentity(8) end
                pcall(function()
                    child:Destroy()
                end)
            end
        end))
        for _, child in workspace:GetChildren() do
            if vape.ThreadFix then setthreadidentity(8) end
            if child and child.Name == 'Drill' then
                for _, v in child:GetDescendants() do
                    if v:IsA('BasePart') then
                        bedwars.QueryUtil:setQueryIgnored(v, true)
                    end
                end
            end
            if child and child.Name == 'diamond' or child.Name == 'gold' or child.Name == 'emerald' then
                if vape.ThreadFix then setthreadidentity(8) end
                pcall(function()
                    child:Destroy()
                end)
            end
        end
    else
         store.CleanKit[lplr:GetAttribute('PlayingAsKits') or 'none'] = false
        for _, child in workspace:GetChildren() do
            if vape.ThreadFix then setthreadidentity(8) end
            if child and child.Name == 'Drill' then
                for _, v in child:GetDescendants() do
                    if v:IsA('BasePart') then
                        bedwars.QueryUtil:setQueryIgnored(v, false)
                    end
                end
            end
        end
    end
end

function CK:star_collector(callback, module)
    
    if not module then return end
    if callback then
        store.CleanKit[lplr:GetAttribute('PlayingAsKits') or 'none'] = true
        module:Clean(workspace.ChildAdded:Connect(function(child)
            if vape.ThreadFix then setthreadidentity(8) end
            if child and (child.Name == 'CritStar' or child.Name == 'VitalityStar') then
                local ID = game.HttpService:GenerateGUID(true)
                child:SetAttribute('id', ID)
                child.AnimationController:SetAttribute('id', ID)
                for _, v in child:GetDescendants() do
                    if v:IsA('BasePart') then
                        bedwars.QueryUtil:setQueryIgnored(v, true)
                        child.AnimationController.Parent = game.ReplicatedStorage
                    end
                end
            end
        end))
        for _, child in workspace:GetChildren() do
            if vape.ThreadFix then setthreadidentity(8) end
            if child and (child.Name == 'CritStar' or child.Name == 'VitalityStar') then
                local ID = game.HttpService:GenerateGUID(true)
                child:SetAttribute('id', ID)
                child.AnimationController:SetAttribute('id', ID)
                for _, v in child:GetDescendants() do
                    if v:IsA('BasePart') then
                        bedwars.QueryUtil:setQueryIgnored(v, true)
                        child.AnimationController.Parent = game.ReplicatedStorage
                    end
                end
            end
        end
    else
        store.CleanKit[lplr:GetAttribute('PlayingAsKits') or 'none'] = false
        for _, star in workspace:GetChildren() do
            if vape.ThreadFix then
                setthreadidentity(8)
            end
            if star and (star.Name == 'CritStar' or star.Name == 'VitalityStar') then
                local id = star:GetAttribute("id")
                if id then
                    for _, v in game.ReplicatedStorage:GetChildren() do
                        if v.Name == "AnimationController" and v:GetAttribute("id") == id then
                            v.Parent = star
                            v:SetAttribute("id", nil)
                            star:SetAttribute("id", nil)
                            for _, part in star:GetDescendants() do
                                if part:IsA("BasePart") then
                                    bedwars.QueryUtil:setQueryIgnored(part, false)
                                end
                            end
                            break
                        end
                    end
                end
            end
        end
    end
end

function CK:cat(callback, module)
    
    if not module then return end
    lplr.PlayerGui:FindFirstChild('ActionBarScreenGui'):WaitForChild('ActionBar',10):WaitForChild("CatStaminaBar",25).Visible = not callback
    if callback then
        module:Clean(workspace.DescendantAdded:Connect(function(child)
            if vape.ThreadFix then setthreadidentity(8) end
            if child and (child.Name == 'BlockRegionBox' or child.Name:find('Decay') or child.Name:find('decay')) then
                if vape.ThreadFix then setthreadidentity(8) end
                pcall(function()
                    child:Destroy()
                end)
            end
        end))
        for _, child in workspace:GetDescendants() do
            if vape.ThreadFix then setthreadidentity(8) end
            if child and (child.Name == 'BlockRegionBox' or child.Name:find('Decay') or child.Name:find('decay')) then
                if vape.ThreadFix then setthreadidentity(8) end
                pcall(function()
                    child:Destroy()
                end)
            end
        end
    else
        store.CleanKit[lplr:GetAttribute('PlayingAsKits') or 'none'] = false
    end
end

function CK:sword_shield(callback, module)
    
    if not module then return end
    if callback then
        store.CleanKit[lplr:GetAttribute('PlayingAsKits') or 'none'] = true
        for _, child in lplr.Character:GetDescendants() do
            if vape.ThreadFix then setthreadidentity(8) end
            if child and (child.Name:find('Shield')) then
                if vape.ThreadFix then setthreadidentity(8) end
                pcall(function()
                    child:Destroy()
                end)
            end
        end
        module:Clean(lplr.Character.DescendantAdded:Connect(function(child)
            if vape.ThreadFix then setthreadidentity(8) end
            if child and (child.Name:find('Shield')) then
                if vape.ThreadFix then setthreadidentity(8) end
                pcall(function()
                    child:Destroy()
                end)
            end
        end))
    else
        store.CleanKit[lplr:GetAttribute('PlayingAsKits') or 'none'] = false
    end
end

function CK:glacial_skater(callback, module)
    if not module then return end
    lplr.PlayerGui.ActionBarScreenGui.ActionBar.MomentumBarUi.Visible = not callback
    if callback then
        store.CleanKit[lplr:GetAttribute('PlayingAsKits') or 'none'] = true
        module:Clean(lplr.PlayerGui.StatusEffectHudScreen.StatusEffectHud.ChildAdded:Connect(function(child)
            if child and (child.Name == 'On Ice' or child.Name == 'High Speed Skating') then
                pcall(function()
                    child:Destroy()
                end)
            end
        end))
        for _, child in StatusEffectHudScreen.StatusEffectHud:GetChildren() do
            if child and (child.Name == 'On Ice' or child.Name == 'High Speed Skating') then
                pcall(function()
                    child:Destroy()
                end)
            end
        end
    else
        store.CleanKit[lplr:GetAttribute('PlayingAsKits') or 'none'] = false
    end
end

function CK:defender(callback, module)
    local old = {}
    if not module then return end
    if callback then
        store.CleanKit[lplr:GetAttribute('PlayingAsKits') or 'none'] = true
        for _, child in workspace:GetDescendants() do
            if child and (child.Name == 'DefenderSchematicBlock' or child.Name == 'DefenderCustomBlockHighlight') then
                child.Transparency = 0
            end
            if child and (child.Name == 'DefenderBlockPopup') then
                for _, v in child:GetChildren() do
                    v.Visible = (v.Name == 'Cost')
                end
            end
        end
        module:Clean(workspace.DescendantAdded:Connect(function(child)
            if child and (child.Name == 'DefenderSchematicBlock' or child.Name == 'DefenderCustomBlockHighlight') then
                child.Transparency = 0
            end
            if child and (child.Name == 'DefenderBlockPopup') then
                for _, v in child:GetChildren() do
                    v.Visible = (v.Name == 'Cost')
                end
            end
        end))
    else
        store.CleanKit[lplr:GetAttribute('PlayingAsKits') or 'none'] = false
        for _, child in workspace:GetDescendants() do
            if child and (child.Name == 'DefenderSchematicBlock' or child.Name == 'DefenderCustomBlockHighlight') then
                child.Transparency = 0.95
            end
            if child and (child.Name == 'DefenderBlockPopup') then
                for _, v in child:GetChildren() do
                    v.Visible = true
                end
            end
        end
    end
end

function CK:berserker(callback, module)
    if not module then return end
    if callback then
        store.CleanKit[lplr:GetAttribute('PlayingAsKits') or 'none'] = true
        for _, child in lplr.Character:GetDescendants() do
            if child and (child.Name == 'BerserkerRageEffect') then
                child:Destroy()
            end
        end
        module:Clean(lplr.Character.ChildAdded:Connect(function(child)
            if child and (child.Name == 'BerserkerRageEffect') then
                child:Destroy()
            end
        end))
    else
        store.CleanKit[lplr:GetAttribute('PlayingAsKits') or 'none'] = false
    end
end

--[[
function CK:(callback, module)
    
    if not module then return end
    if callback then
        store.CleanKit[lplr:GetAttribute('PlayingAsKits') or 'none'] = true
    else
        store.CleanKit[lplr:GetAttribute('PlayingAsKits') or 'none'] = false
    end
end

--[[
function CK:(callback, module)
    
    if not module then return end
    if callback then
        store.CleanKit[lplr:GetAttribute('PlayingAsKits') or 'none'] = true
    else
        store.CleanKit[lplr:GetAttribute('PlayingAsKits') or 'none'] = false
    end
end


function CK:(callback, module)
    
    if not module then return end
    if callback then
        store.CleanKit[lplr:GetAttribute('PlayingAsKits') or 'none'] = true
    else
        store.CleanKit[lplr:GetAttribute('PlayingAsKits') or 'none'] = false
    end
end

function CK:(callback, module)
    
    if not module then return end
    if callback then
        store.CleanKit[lplr:GetAttribute('PlayingAsKits') or 'none'] = true
    else
        store.CleanKit[lplr:GetAttribute('PlayingAsKits') or 'none'] = false
    end
end

function CK:(callback, module)
    
    if not module then return end
    if callback then
        store.CleanKit[lplr:GetAttribute('PlayingAsKits') or 'none'] = true
    else
        store.CleanKit[lplr:GetAttribute('PlayingAsKits') or 'none'] = false
    end
end


function CK:(callback, module)
    
    if not module then return end
    if callback then
        store.CleanKit[lplr:GetAttribute('PlayingAsKits') or 'none'] = true
    else
        store.CleanKit[lplr:GetAttribute('PlayingAsKits') or 'none'] = false
    end
end

function CK:(callback, module)
    
    if not module then return end
    if callback then
        store.CleanKit[lplr:GetAttribute('PlayingAsKits') or 'none'] = true
    else
        store.CleanKit[lplr:GetAttribute('PlayingAsKits') or 'none'] = false
    end
end
--]]


run(function()
    local CleanKit
    
    CleanKit = vape.Categories.Render:CreateModule({
        Name = 'Clean Kit',
        Function = function(callback)
            local suc, res = pcall(function()
                return CK[lplr:GetAttribute("PlayingAsKits") or 'none'](CK, callback, CleanKit)
            end)

            if not suc then
                print('failed', res)
            end
        end
    })
end)



------------


local cloneref = cloneref or function(obj) return obj end
local runService = cloneref(game:GetService('RunService'))
local playersService = cloneref(game:GetService('Players'))

local lplr = playersService.LocalPlayer
local vape = shared.vape

local tracker = {bed = nil, nuking = false, died = false, kaing=false, currentTarget =  nil}
local beds = {}
local players = {}
local currentbedpos = Vector3.zero

local oldMomentumUpdate

local function getAccountTier(player)
    if getgenv().getAccountTier then
        return getgenv().getAccountTier(player)
    end
    return 0
end

local function setup()
    if not bedwars.GlacialSkaterController then 
        warn('no controller to hook onto') 
        return false 
    end
    if store.equippedKit ~= 'glacial_skater' then 
        warn('not krystal kit') 
        return false 
    end

    if not oldMomentumUpdate then
        oldMomentumUpdate = bedwars.GlacialSkaterController.updateMomentum
    end

    bedwars.GlacialSkaterController.updateMomentum = function(self, ...)
        self.momentum = 9e9
        self.lastMomentumReport = 9e9
        pcall(function()
            bedwars.Client:Get('MomentumUpdate'):SendToServer({ momentumValue = 9e9 })
        end)
    end

    return true
end

local function isBedObjectAt(pos)
    for _, obj in ipairs(workspace:GetDescendants()) do
        if obj.Name == "bed" and obj:IsA("BasePart") and (obj.Position - pos).Magnitude < 2 then
            return true
        end
    end
    return false
end

local function cleanBedsTable()
    for i = #beds, 1, -1 do
        if not isBedObjectAt(beds[i]) then
            table.remove(beds, i)
        end
    end
end

local function AllbedPOS()
    beds = {}
    local mapCFrames = workspace:FindFirstChild("MapCFrames")
    if mapCFrames then
        for _, obj in ipairs(mapCFrames:GetChildren()) do
            if string.match(obj.Name, "_bed$") then
                table.insert(beds, obj.Value.Position)
            end
        end
    end
    cleanBedsTable()
end

local function UpdateCurrentBedPOS()
    local mapCFrames = workspace:FindFirstChild("MapCFrames")
    if not mapCFrames then return end
    local team = lplr.Character and lplr.Character:GetAttribute("Team")
    if team then
        local bedObj = mapCFrames:FindFirstChild(tostring(team) .. "_bed")
        if bedObj then
            currentbedpos = bedObj.Value.Position
        end
    end
end

local function closestBed(origin)
    local closest, dist = nil, math.huge
    for _, pos in ipairs(beds) do
        if (pos - currentbedpos).Magnitude > 5 then
            local d = (pos - origin).Magnitude
            if d < dist then
                dist, closest = d, pos
            end
        end
    end
    return closest
end

local function getallPlayers()
    players = {}
    for _, ent in entitylib.List do
        if ent.Player and ent.Player ~= lplr then
            table.insert(players, ent.Player)
        end
    end
end

local function configureBreaker()
	if not vape.Modules.Breaker.Enabled then
		vape.Modules.Breaker:Toggle()
	end
	task.wait()
	task.spawn(function()
		if vape.Modules.Breaker.Options['Break Iron Ore'].Enabled then
			vape.Modules.Breaker.Options['Break Iron Ore']:Toggle()
		end
		if vape.Modules.Breaker.Options['Break Crops'].Enabled then
			vape.Modules.Breaker.Options['Break Crops']:Toggle()
		end
		if vape.Modules.Breaker.Options['Break Hive'].Enabled then
			vape.Modules.Breaker.Options['Break Hive']:Toggle()
		end
		if vape.Modules.Breaker.Options['Require Mouse Down'].Enabled then
			vape.Modules.Breaker.Options['Require Mouse Down']:Toggle()
		end
		if not vape.Modules.Breaker.Options['Auto Tool'].Enabled then
			vape.Modules.Breaker.Options['Auto Tool']:Toggle()
		end
		if vape.Modules.Breaker.Options['Limit to items'].Enabled then
			vape.Modules.Breaker.Options['Limit to items']:Toggle()
		end
		if vape.Modules.Breaker.Options['Break Tesla'].Enabled then
			vape.Modules.Breaker.Options['Break Tesla']:Toggle()
		end
		if vape.Modules.Breaker.Options['Break Pinata'].Enabled then
			vape.Modules.Breaker.Options['Break Pinata']:Toggle()
		end
		if not vape.Modules.Breaker.Options['Break Bed'].Enabled then
			vape.Modules.Breaker.Options['Break Bed']:Toggle()
		end
        vape.Modules.Breaker.Options['Break range']:SetValue(30)
        vape.Modules.Breaker.Options['Break speed']:SetValue(0.25)
        vape.Modules.Breaker.Options['Update rate']:SetValue(120)
	end)
end

local function configureKillaura()
	if not vape.Modules.Killaura.Enabled then
		vape.Modules.Killaura:Toggle()
	end
	if vape.Modules.GrandKillaura.Enabled then
		vape.Modules.GrandKillaura:Toggle()
	end
	if vape.Modules.SilentAura.Enabled then
		vape.Modules.SilentAura:Toggle()
	end
	task.wait()
	task.spawn(function()
		if not vape.Modules.Killaura.Options.Targets.Players.Enabled then
			vape.Modules.Killaura.Options.Targets.Players:Toggle()
		end
		if vape.Modules.Killaura.Options.Targets.Walls.Enabled then
			vape.Modules.Killaura.Options.Targets.Walls:Toggle()
		end
		if vape.Modules.Killaura.Options.Targets.NPCs.Enabled then
			vape.Modules.Killaura.Options.Targets.NPCs:Toggle()
		end
		if vape.Modules.Killaura.Options.Targets.Invisible.Enabled then
			vape.Modules.Killaura.Options.Targets.Invisible:Toggle()
		end
		if vape.Modules.Killaura.Options['Range Visualiser'].Enabled then
			vape.Modules.Killaura.Options['Range Visualiser']:Toggle()
		end
		if vape.Modules.Killaura.Options['Require mouse down'].Enabled then
			vape.Modules.Killaura.Options['Require mouse down']:Toggle()
		end
		if vape.Modules.Killaura.Options['GUI check'].Enabled then
			vape.Modules.Killaura.Options['GUI check']:Toggle()
		end
		if not vape.Modules.Killaura.Options['Custom Swing Time'].Enabled then
			vape.Modules.Killaura.Options['Custom Swing Time']:Toggle()
		end
		if vape.Modules.Killaura.Options['Continue Swinging'].Enabled then
			vape.Modules.Killaura.Options['Continue Swinging']:Toggle()
		end
		if vape.Modules.Killaura.Options['Custom Hit Reg'].Enabled then
			vape.Modules.Killaura.Options['Custom Hit Reg']:Toggle()
		end
		if vape.Modules.Killaura.Options['Sync Hits'].Enabled then
			vape.Modules.Killaura.Options['Sync Hits']:Toggle()
		end
		if vape.Modules.Killaura.Options['Show target'].Enabled then
			vape.Modules.Killaura.Options['Show target']:Toggle()
		end
		if vape.Modules.Killaura.Options['Target particles'].Enabled then
			vape.Modules.Killaura.Options['Target particles']:Toggle()
		end
		if vape.Modules.Killaura.Options['Face target'].Enabled then
			vape.Modules.Killaura.Options['Face target']:Toggle()
		end
		if vape.Modules.Killaura.Options['Custom Animation'].Enabled then
			vape.Modules.Killaura.Options['Custom Animation']:Toggle()
		end
		if vape.Modules.Killaura.Options['Limit to items'].Enabled then
			vape.Modules.Killaura.Options['Limit to items']:Toggle()
		end
		if vape.Modules.Killaura.Options['Swing only'].Enabled then
			vape.Modules.Killaura.Options['Swing only']:Toggle()
		end
		if vape.Modules.Killaura.Options['Air Hits'].Enabled then
			vape.Modules.Killaura.Options['Air Hits']:Toggle()
		end
		if vape.Modules.Killaura.Options['Dynamic Reach'].Enabled then
			vape.Modules.Killaura.Options['Dynamic Reach']:Toggle()
		end
		if vape.Modules.Killaura.Options['Attack Check'].Enabled then
			vape.Modules.Killaura.Options['Attack Check']:Toggle()
		end
		if vape.Modules.Killaura.Options['Fast Hits'].Enabled then
			vape.Modules.Killaura.Options['Fast Hits']:Toggle()
		end
		if vape.Modules.Killaura.Options['FastHits Blacklist'].Enabled then
			vape.Modules.Killaura.Options['FastHits Blacklist']:Toggle()
		end
		if vape.Modules.Killaura.Options['No Swing'].Enabled then
			vape.Modules.Killaura.Options['No Swing']:Toggle()
		end
		vape.Modules.Killaura.Options['Target Priority']:SetValue('Distance')
		vape.Modules.Killaura.Options['Swing range']:SetValue(40)
		vape.Modules.Killaura.Options['Attack range']:SetValue(22)
		vape.Modules.Killaura.Options['Attack range']:SetValue(22)
		vape.Modules.Killaura.Options['Max angle']:SetValue(360)
		vape.Modules.Killaura.Options['Update rate']:SetValue(120)
		vape.Modules.Killaura.Options['Max targets']:SetValue(5)
		vape.Modules.Killaura.Options['Target Mode']:SetValue('Distance')
		vape.Modules.Killaura.Options['Swing Time']:SetValue(0)
	end)
end

run(function()
    local Autowin
    local Empty
    Autowin = vape.Categories.Minigames:CreateModule({
        Name = 'Autowin',
        Function = function(callback)
            repeat task.wait(0.08) until store.matchState ~= 0
            if not callback then
                if oldMomentumUpdate and bedwars.GlacialSkaterController then
                    bedwars.GlacialSkaterController.updateMomentum = oldMomentumUpdate
                end
                tracker.nuking = false
                tracker.kaing = false
                tracker.currentTarget = nil
                beds = {}
                return
            end
            if not setup() then
                vape:CreateNotification("Vape", "Autowin requires Krystal kit!", 8, 'warning')
                Autowin:Toggle(false)
                return
            end
            lplr.Character.Humanoid:ChangeState(Enum.HumanoidStateType.Dead)
            task.wait(playersService.RespawnTime or 3)
            Autowin:Clean(runService.RenderStepped:Connect(function()
                if not bedwars then return end
                pcall(function()
                    bedwars.GlacialSkaterController:updateMomentum({momentum=9e9,lastMomentumReport=9e9}, "newValue")
                end)
            end))
            UpdateCurrentBedPOS()
            AllbedPOS()
            if #beds <= 1 then
                vape:CreateNotification("Autowin", "Not enough beds to nuke!", 6, 'warning')
                Autowin:Toggle(false)
                return
            end
            configureBreaker()
            configureKillaura()
            tracker.nuking = true

            Autowin:Clean(lplr.CharacterAdded:Connect(function(char)
                task.wait(0.5)
                local root = char:WaitForChild('HumanoidRootPart', 5)
                if root then
                    if tracker.bed then
                        vape:CreateNotification("Autowin", "Reteleporting to old bed tracker...",4)
                        root.CFrame = CFrame.new(tracker.bed.X, tracker.bed.Y + 6, tracker.bed.Z)
                    elseif tracker.kaing and tracker.currentTarget then
                        local targetChar = tracker.currentTarget.Character
                        local targetRoot = targetChar and targetChar:FindFirstChild('HumanoidRootPart')
                        if targetRoot then
                            root.CFrame = CFrame.new(targetRoot.Position.X, targetRoot.Position.Y + 6, targetRoot.Position.Z)
                        elseif tracker.lastTargetPos then
                            root.CFrame = CFrame.new(tracker.lastTargetPos.X, tracker.lastTargetPos.Y + 6, tracker.lastTargetPos.Z)
                        end
                    end
                end
            end))

            task.spawn(function()
                while Autowin.Enabled and #beds > 1 and tracker.nuking do
                    local root = lplr.Character and lplr.Character:FindFirstChild('HumanoidRootPart')
                    if not root then 
                        task.wait(0.5)
                        continue 
                    end
                    local nextBed = closestBed(root.Position)
                    if not nextBed then break end

                    if not isBedObjectAt(nextBed) then
                        for i, v in ipairs(beds) do
                            if (v - nextBed).Magnitude < 0.1 then
                                table.remove(beds, i)
                                break
                            end
                        end
                        tracker.bed = nil
                        continue
                    end

                    tracker.bed = nextBed
                    root.CFrame = CFrame.new(nextBed.X, nextBed.Y + 6, nextBed.Z)
                    task.wait(0.1)
                    local conn
                    conn = workspace.DescendantRemoving:Connect(function(obj)
                        if obj and obj.Name == "bed" and (obj.Position - nextBed).Magnitude < 3 then
                            for i, v in ipairs(beds) do
                                if (v - nextBed).Magnitude < 3 then
                                    table.remove(beds, i)
                                    break
                                end
                            end
                            tracker.bed = nil
                            conn:Disconnect()
                        end
                    end)

                    task.wait(0.3)
                end

                tracker.nuking = false
                tracker.bed = nil
                vape:CreateNotification("Autowin",'Nuked all beds. Moving onto Players..',8)
                if lplr.Character and lplr.Character:FindFirstChild('Humanoid') then
                    lplr.Character.Humanoid:ChangeState(Enum.HumanoidStateType.Dead)
                end
                task.wait(playersService.RespawnTime or 3)

                getallPlayers()
                local function getAlivePlayers()
                    local alive = {}
                    for _, player in ipairs(players) do
                        if player ~= lplr then
                            local char = player.Character
                            if char then
                                local hum = char:FindFirstChild('Humanoid')
                                if hum and hum.Health > 0 then
                                    table.insert(alive, player)
                                end
                            end
                        end
                    end
                    return alive
                end

                local alivePlayers = getAlivePlayers()
                if #alivePlayers == 0 then
                    vape:CreateNotification("Autowin", "Done. no players needed to kill", 5)
                    Autowin:Toggle(false)
                    return
                end

                tracker.kaing = true

                for i = 1, #alivePlayers do
                    if not Autowin.Enabled or not tracker.kaing then break end

                    local targetPlayer = alivePlayers[i]
                    local char = targetPlayer.Character
                    local hum = char and char:FindFirstChild('Humanoid')
                    if not hum or hum.Health <= 0 then
                        for idx, p in ipairs(players) do
                            if p == targetPlayer then
                                table.remove(players, idx)
                                break
                            end
                        end
                        continue
                    end

                    tracker.currentTarget = targetPlayer
                    tracker.lastTargetPos = nil

                    local function teleportToTarget()
                        local char = targetPlayer.Character
                        if char then
                            local targetRoot = char:FindFirstChild('HumanoidRootPart')
                            if targetRoot then
                                local pos = targetRoot.Position
                                tracker.lastTargetPos = pos
                                local myRoot = lplr.Character and lplr.Character:FindFirstChild('HumanoidRootPart')
                                if myRoot then
                                    myRoot.CFrame = CFrame.new(pos.X, pos.Y + 6, pos.Z)
                                end
                            end
                        end
                    end
                    teleportToTarget()

                    while Autowin.Enabled and tracker.kaing and tracker.currentTarget == targetPlayer do
                        local char = targetPlayer.Character
                        local hum = char and char:FindFirstChild('Humanoid')
                        if not hum or hum.Health <= 0 then
                            break
                        end
                        local root = char:FindFirstChild('HumanoidRootPart')
                        if root then
                            tracker.lastTargetPos = root.Position
                        end
                        task.wait(0.3)
                    end

                    for idx, p in ipairs(players) do
                        if p == targetPlayer then
                            table.remove(players, idx)
                            break
                        end
                    end

                    if not Autowin.Enabled or not tracker.kaing then break end
                    vape:CreateNotification("Autowin", targetPlayer.Name .. " killed.", 3)
                end

                tracker.kaing = false
                tracker.currentTarget = nil
                if Autowin.Enabled then
                    vape:CreateNotification("Autowin", "Done. Killed all players and nuked all beds!", 5)
                    Autowin:Toggle(false)
                end
            end)
        end
    })
end)




----------



local vape = shared.vape
local Desync

local hooktypes = {
	rakhook1 = false,
	rakhook2 = false,
	fflag = false
}

local rakNet = typeof(raknet) == "table"

local function rakhook(pckt)
	if not pckt then return end
	if pckt.PacketId == 0x1B or (pckt.AsArray and pckt.AsArray[1] == 0x1B) then
		local success, err = pcall(function()
			local buf = pckt.AsBuffer or buffer.create(100)
			buffer.writeu32(buf, 1, 0xFFFFFFFF)
			pckt:SetData(buf)
		end)
		if not success then
			warn("[Desync] Hook error:", err)
		end
	end
end

local function rakHookk(pckt)
	if not pckt then return end
	if pckt.PacketId == 0x1B then
		local success, err = pcall(function()
			local buf = pckt.AsBuffer
			if buf then
				buffer.writeu32(buf, 1, 0xFFFFFFFF)
				pckt:SetData(buf)
			end
		end)
		if not success then
			warn("[Desync] Hook2 error:", err)
		end
	end
end

local old = 0

Desync = vape.Categories.Blatant:CreateModule({
	Name = "Desync",
	Tooltip = "Uses various methods to desync your position",
	Function = function(callback)
		if callback then
			old = tick()

			if rakNet then
				vape:CreateNotification("Vape", "RakNet founded! Attempting to use server-sided desync...", 8)

				local suc1 = pcall(function()
					return raknet.add_send_hook(rakhook)
				end)

				if suc1 then
					hooktypes.rakhook1 = true
					vape:CreateNotification("Vape", "Desync, raknet Hook applied successfully", 6)
					return
				end

				task.wait(0.5)
				local suc2 = pcall(function()
					return raknet.add_send_hook(rakHookk)
				end)

				if suc2 then
					hooktypes.rakhook2 = true
					vape:CreateNotification("Vape", "Desync, raknet Second Hook applied successfully", 6)
					return
				end

				vape:CreateNotification("Vape", "Both raknet hooks failed. Falling back to fflag...", 8, "warning")
			else
				vape:CreateNotification("Vape", "raknet not supported? Using fflag method.", 8)
			end

			local fflagSuccess = pcall(function()
				return setfflag("NextGenReplicatorEnabledWrite4", "true")
			end)

			if fflagSuccess then
				hooktypes.fflag = true
				vape:CreateNotification("Vape", "Desync, fflag enabled", 6)
			else
				vape:CreateNotification("Vape", "All desync methods failed. Disabling module...", 8, "alert")
				task.delay(1.5, function()
					Desync:Toggle(false)
				end)
			end

		else
			if rakNet then
				if hooktypes.rakhook1 then
					pcall(function() raknet.remove_send_hook(rakhook) end)
				elseif hooktypes.rakhook2 then
					pcall(function() raknet.remove_send_hook(rakHookk) end)
				end
			end
			if hooktypes.fflag then
				pcall(function()
					setfflag("NextGenReplicatorEnabledWrite4", "false")
				end)
			end
			hooktypes.rakhook1 = false
			hooktypes.rakhook2 = false
			hooktypes.fflag = false
		end
	end
})


-----

--REACHV2 :


run(function()
	local Attack
	local Mine
	local Place
	local oldAttackReach, oldMineReach, oldPlaceReach
	local SwordReach, MineReach

	Reach = vape.Categories.Combat:CreateModule({
		Name = 'Reach',
		Function = function(callback)
			if callback then
				if SwordReach and SwordReach.Enabled then
					oldAttackReach = bedwars.CombatConstant.RAYCAST_SWORD_CHARACTER_DISTANCE
					bedwars.CombatConstant.RAYCAST_SWORD_CHARACTER_DISTANCE = Attack.Value + 2
				end
				
				task.spawn(function()
					repeat task.wait(0.1) until bedwars.BlockBreakController or not Reach.Enabled
					if not Reach.Enabled or not MineReach or not MineReach.Enabled then return end
					
					pcall(function()
						local blockBreaker = bedwars.BlockBreakController:getBlockBreaker()
						if blockBreaker then
							oldMineReach = oldMineReach or blockBreaker:getRange()
							blockBreaker:setRange(Mine.Value)
						end
					end)
				end)
				
				local _reachLoopThread = task.spawn(function()
					while Reach.Enabled do
						task.wait(5)
						if not Reach.Enabled then break end
						if SwordReach.Enabled and bedwars.CombatConstant.RAYCAST_SWORD_CHARACTER_DISTANCE ~= Attack.Value + 2 then
							bedwars.CombatConstant.RAYCAST_SWORD_CHARACTER_DISTANCE = Attack.Value + 2
						end
						if MineReach.Enabled then
							pcall(function()
								local blockBreaker = bedwars.BlockBreakController:getBlockBreaker()
								if blockBreaker and blockBreaker:getRange() ~= Mine.Value then
									blockBreaker:setRange(Mine.Value)
								end
							end)
						end
					end
				end)
				Reach:Clean(function()
					if _reachLoopThread then
						pcall(task.cancel, _reachLoopThread)
						_reachLoopThread = nil
					end
				end)
			else
				if oldAttackReach then
					bedwars.CombatConstant.RAYCAST_SWORD_CHARACTER_DISTANCE = oldAttackReach
				end
				
				if oldMineReach then
					pcall(function()
						local blockBreaker = bedwars.BlockBreakController:getBlockBreaker()
						if blockBreaker then
							blockBreaker:setRange(oldMineReach)
						end
					end)
				end

				oldAttackReach, oldMineReach = nil, nil
			end
		end,
		Tooltip = 'Extends reach for attacking, mining, and placing blocks'
	})
	
	SwordReach = Reach:CreateToggle({
		Name = 'Sword Reach',
		Default = true,
		Function = function(v)
			if Attack then Attack.Object.Visible = v end
			if Reach.Enabled then
				if v then
					bedwars.CombatConstant.RAYCAST_SWORD_CHARACTER_DISTANCE = Attack.Value + 2
				else
					bedwars.CombatConstant.RAYCAST_SWORD_CHARACTER_DISTANCE = oldAttackReach or 14.4
				end
			end
		end
	})

	Attack = Reach:CreateSlider({
		Name = 'Attack Range',
		Darker = true,
		Visible = true,
		Min = 0,
		Max = 20,
		Default = 18,
		Function = function(val)
			if Reach.Enabled then
				bedwars.CombatConstant.RAYCAST_SWORD_CHARACTER_DISTANCE = val + 2
			end
		end,
		Suffix = function(val)
			return val == 1 and 'stud' or 'studs'
		end
	})
	
	MineReach = Reach:CreateToggle({
		Name = 'Mine Reach',
		Default = false,
		Function = function(v)
			if Mine then Mine.Object.Visible = v end
		end
	})

	Mine = Reach:CreateSlider({
		Name = 'Mine Range',
		Darker = true,
		Visible = false,
		Min = 0,
		Max = 30,
		Default = 18,
		Function = function(val)
			if Reach.Enabled then
				pcall(function()
					local blockBreaker = bedwars.BlockBreakController:getBlockBreaker()
					if blockBreaker then
						blockBreaker:setRange(val)
					end
				end)
			end
		end,
		Suffix = function(val)
			return val == 1 and 'stud' or 'studs'
		end
	})
end)


----------


-- KillAuraV2: 

-- aero killaura 
local Attacking
run(function()
    local Killaura
    local Targets
    local Sort
    local SwingRange
    local AttackRange
    local RangeCircle
    local RangeCirclePart
    local UpdateRate
    local AngleSlider
    local MaxTargets
    local Mouse
    local Swing
    local GUI
    local BoxSwingColor
    local BoxAttackColor
    local ParticleTexture
    local ParticleColor1
    local ParticleColor2
    local ParticleSize
    local Face
    local FaceSpeed
    local Animation
    local AnimationMode
    local AnimationSpeed
    local AnimationTween
    local Limit
    local LegitAura
    local SyncHits
    local lastAttackTime = 0
    local lastManualSwing = 0
    local lastSwingServerTime = 0
    local lastSwingServerTimeDelta = 0
    local AttackCheck
    local kitChecks
    local SwingTime
    local SwingTimeSlider
    local swingCooldown = 0
    local ContinueSwinging
    local ContinueSwingTime
    local lastTargetTime = 0
    local continueSwingCount = 0
    local Particles, Boxes = {}, {}
    local anims, AnimDelay, AnimTween, armC0 = vape.Libraries.auraanims, tick()
    local AttackRemote
    local TargetPriority
    local CustomHitReg
    local CustomHitRegSlider
    local lastCustomHitTime = 0
    local AirHit
    local AirHitsChance
    local FROZEN_THRESHOLD = 10
    local FastHits
    local FastHitsMode
    local LegitSwitch
    local OldShootInterval
    local OldSwitchDelay
    local OldWaitDelay
    local OldFirstPersonCheck
    local lastOldShootTime = 0
    local Legit
    local FireRate
    local autoShootLoop = nil
    local projectileRemote = {InvokeServer = function() end}
    local ProjectileDelay = {}
    local FastHitsFireDelays = {}
    local fhUsageIndex = 1
    local responded = true
    local preserveSwordIcon = false
    local FASTHITS_HIT_DEBOUNCE = 0.1
    local fastHitsHitTarget = nil
    local fastHitsTrackedEntity = nil
    local fastHitsHitCount = 0
    local fastHitsActivationReady = false
    local fastHitsLastHitTime = 0

    task.spawn(function()
        AttackRemote = bedwars.Client:Get(remotes.AttackEntity).instance
        projectileRemote = bedwars.Client:Get(remotes.FireProjectile).instance
    end)

    local DynamicReach
    local lastOptimizedAttackTime = 0

    local function optimizeHitData(selfpos, targetpos, delta, cameraPosition, cursorDirection)
        if not DynamicReach or not DynamicReach.Enabled then return true end
        if not selfpos or not targetpos or not delta or not cameraPosition or not cursorDirection then return true end
        local direction = (targetpos - selfpos).Unit
        local selfPush, targetPull
        if delta > 20 then selfPush, targetPull = 2.6, 0.95
        elseif delta > 18 then selfPush, targetPull = 2.4, 0.7
        elseif delta > 14.4 then selfPush, targetPull = 2.2, 0.5
        elseif delta > 10 then selfPush, targetPull = 1.8, 0.3
        else selfPush, targetPull = 0.6, 0 end
        local optimizedSelfPos = selfpos + (direction * selfPush) + Vector3.new(0, 0.8, 0)
        local optimizedTargetPos = targetpos - (direction * targetPull) + Vector3.new(0, 1.2, 0)
        local camToTarget = (targetpos - cameraPosition).Unit
        local camPush
        if delta > 20 then camPush = 2.2
        elseif delta > 18 then camPush = 1.8
        elseif delta > 14.4 then camPush = 1.4
        elseif delta > 10 then camPush = 0.9
        else camPush = 0.4 end
        local optimizedCameraPos = cameraPosition + (camToTarget * camPush) + Vector3.new(0, 0.4, 0)
        local optimizedCamToTarget = (optimizedTargetPos - optimizedCameraPos).Unit
        local blendFactor
        if delta > 20 then blendFactor = 0.945
        elseif delta > 18 then blendFactor = 0.75
        elseif delta > 14.4 then blendFactor = 0.55
        elseif delta > 10 then blendFactor = 0.35
        else blendFactor = 0.15 end
        local optimizedCursorDirection = (cursorDirection + (optimizedCamToTarget * blendFactor)).Unit
        return optimizedSelfPos, optimizedTargetPos, optimizedCameraPos, optimizedCursorDirection
    end

    local function getOptimizedAttackTiming(delta)
        if not DynamicReach or not DynamicReach.Enabled then return true end
        if not delta then return false end
        local currentTime = tick()
        local delayBetweenAttacks
        if delta > 20 then delayBetweenAttacks = 0.38
        elseif delta > 18 then delayBetweenAttacks = 0.18
        elseif delta > 14.4 then delayBetweenAttacks = 0.09
        elseif delta > 10 then delayBetweenAttacks = 0.04
        else delayBetweenAttacks = 0 end
        local elapsed = currentTime - lastOptimizedAttackTime
        if elapsed >= delayBetweenAttacks then
            lastOptimizedAttackTime = elapsed > delayBetweenAttacks * 2 and currentTime or lastOptimizedAttackTime + delayBetweenAttacks
            return true
        end
        return false
    end

    local function canHitWithCustomReg()
        if not CustomHitReg or not CustomHitReg.Enabled then return true end
        if not CustomHitRegSlider then return true end
        if CustomHitRegSlider.Value >= 36 then return true end
        local currentTime = tick()
        local delayBetweenHits = 10 / CustomHitRegSlider.Value
        if currentTime - lastCustomHitTime >= delayBetweenHits then
            lastCustomHitTime = lastCustomHitTime + delayBetweenHits
            if currentTime - lastCustomHitTime > delayBetweenHits then
                lastCustomHitTime = currentTime
            end
            return true
        end
        return false
    end

    local _t4LastHit = {}

    local function FireAttackRemote(attackTable)
        if not AttackRemote then return end
        if not canHitWithCustomReg() then return end
        local _atkPlr = playersService:GetPlayerFromCharacter(attackTable.entityInstance)
        if _atkPlr then
            local targetTier = getAccountTier(_atkPlr)
            if targetTier >= 99 then return end
            if targetTier == 4 and getAccountTier(lplr) == 0 then
                local uid = _atkPlr.UserId
                local now = tick()
                if _t4LastHit[uid] and now - _t4LastHit[uid] < (10/32) then return end
                _t4LastHit[uid] = now
            end
            -- whitelist removed
        end
        if DynamicReach and DynamicReach.Enabled then
            if not getOptimizedAttackTiming((attackTable.validate.selfPosition.value - attackTable.validate.targetPosition.value).Magnitude) then
                return
            end
            local ns, nt, nc, ncu = optimizeHitData(
                attackTable.validate.selfPosition.value,
                attackTable.validate.targetPosition.value,
                (attackTable.validate.selfPosition.value - attackTable.validate.targetPosition.value).Magnitude,
                attackTable.validate.raycast.cameraPosition.value,
                attackTable.validate.raycast.cursorDirection.value
            )
            if ns then
                attackTable.validate.selfPosition.value = ns
                attackTable.validate.targetPosition.value = nt
                attackTable.validate.raycast.cameraPosition.value = nc
                attackTable.validate.raycast.cursorDirection.value = ncu
            end
        end
        return AttackRemote:FireServer(attackTable)
    end

    local function createRangeCircle()
        local suc, err = pcall(function()
            if (not shared.CheatEngineMode) then
                RangeCirclePart = Instance.new("MeshPart")
                RangeCirclePart.MeshId = "rbxassetid://3726303797"
                if shared.RiseMode and GuiLibrary.GUICoreColor and GuiLibrary.GUICoreColorChanged then
                    RangeCirclePart.Color = GuiLibrary.GUICoreColor
                    GuiLibrary.GUICoreColorChanged.Event:Connect(function()
                        RangeCirclePart.Color = GuiLibrary.GUICoreColor
                    end)
                else
                    RangeCirclePart.Color = Color3.fromHSV(BoxSwingColor["Hue"], BoxSwingColor["Sat"], BoxSwingColor.Value)
                end
                RangeCirclePart.CanCollide = false
                RangeCirclePart.Anchored = true
                RangeCirclePart.Material = Enum.Material.Neon
                RangeCirclePart.Size = Vector3.new(SwingRange.Value * 0.7, 0.01, SwingRange.Value * 0.7)
                if Killaura.Enabled then
                    RangeCirclePart.Parent = gameCamera
                end
                RangeCirclePart:SetAttribute("gamecore_GameQueryIgnore", true)
            end
        end)
        if (not suc) then
            pcall(function()
                if RangeCirclePart then
                    RangeCirclePart:Destroy()
                    RangeCirclePart = nil
                end
                notif("Killaura - Range Visualiser Circle", "There was an error creating the circle. Disabling...", 2)
            end)
        end
    end

    local function getAttackData()
        if AttackCheck and AttackCheck.Enabled then
            local stunTime = lplr.Character and lplr.Character:GetAttribute('StunnedUntilTime')
            if stunTime and stunTime > workspace:GetServerTimeNow() then return false end
            if kitChecks then
                for _, check in pairs(kitChecks) do
                    if check() then return false end
                end
            end
        end

        if Mouse and Mouse.Enabled then
            local recentSwing = LegitAura and LegitAura.Enabled and (tick() - bedwars.SwordController.lastSwing) <= 0.2
            if not recentSwing then
                local mousePressed = inputService:IsMouseButtonPressed(Enum.UserInputType.MouseButton1)
                if not mousePressed then return false end
            end
        end

        if tick() - store.silasAbilityTime < 2.2 then return false end
        if tick() - store.terraStompTime < 0.7 then return false end
        if tick() - store.terraKickTime < 0.5 then return false end

        if GUI and GUI.Enabled then
            if bedwars.AppController:isLayerOpen(bedwars.UILayers.MAIN) then return false end
        end

        local sword = Limit and Limit.Enabled and store.hand or store.tools.sword
        if not sword or not sword.tool then return false end

        local meta = bedwars.ItemMeta[sword.tool.Name]
        if not meta then return false end

        if Limit and Limit.Enabled then
            if store.hand.toolType ~= 'sword' or bedwars.DaoController.chargingMaid then return false end
        end

        if LegitAura and LegitAura.Enabled then
            if (tick() - bedwars.SwordController.lastSwing) > 0.2 then return false end
        end

        if SwingTime and SwingTime.Enabled then
            local swingSpeed = SwingTimeSlider.Value
            if (tick() - lastAttackTime) < swingSpeed then return false end
        end
        return sword, meta
    end

    local function resetSwordCooldown()
        if bedwars.SwordController then
            bedwars.SwordController.lastAttack = 0
            bedwars.SwordController.lastSwing = 0
            if bedwars.SwordController.lastChargedAttackTimeMap then
                for weaponName, _ in pairs(bedwars.SwordController.lastChargedAttackTimeMap) do
                    bedwars.SwordController.lastChargedAttackTimeMap[weaponName] = 0
                end
            end
        end
    end

    local function shouldContinueSwinging()
        if not ContinueSwinging or not ContinueSwinging.Enabled then return false end
        if lastTargetTime == 0 then return false end
        return (tick() - lastTargetTime) <= ContinueSwingTime.Value
    end

    local function getAmmo(check)
        for _, item in store.inventory.inventory.items do
            if check.ammoItemTypes and table.find(check.ammoItemTypes, item.itemType) then
                return item.itemType
            end
        end
    end

    local _projectilesCache = {}
    local _projectilesCacheTime = 0
    local function getProjectiles()
        local now = tick()
        if now - _projectilesCacheTime < 0.5 and #_projectilesCache > 0 then
            return _projectilesCache
        end
        _projectilesCacheTime = now
        table.clear(_projectilesCache)
        for _, item in store.inventory.inventory.items do
            local meta = bedwars.ItemMeta[item.itemType]
            if not meta then continue end
            local proj = meta.projectileSource
            local ammo = proj and getAmmo(proj)
            if ammo and table.find({'arrow'}, ammo) then
                table.insert(_projectilesCache, {
                    item,
                    ammo,
                    proj.projectileType(ammo),
                    proj
                })
            end
        end
        return _projectilesCache
    end

    local function canShoot(proj)
        return tick() > (ProjectileDelay[proj[1].itemType] or 0)
    end

    local sharedFastHitsRayParams = RaycastParams.new()
    local function shootProjectile(item, ammo, projectile, itemMeta, selfPos, ent, ignoreSwitch)
        local meta = bedwars.ProjectileMeta[projectile]
        if not meta then return false end

        local projSpeed = meta.launchVelocity
        local gravity = meta.gravitationalAcceleration or 196.2
        local targetPart = ent.RootPart
        local targetVel = targetPart.Velocity
        local playerGravity = workspace.Gravity
        local balloons = ent.Character and ent.Character:GetAttribute('InflatedBalloons')
        if balloons and balloons > 0 then
            playerGravity = workspace.Gravity * (1 - (balloons >= 4 and 1.2 or balloons >= 3 and 1 or 0.975))
        end
        if ent.Character and ent.Character.PrimaryPart and ent.Character.PrimaryPart:FindFirstChild('rbxassetid://8200754399') then
            playerGravity = 6
        end
        if ent.Player and ent.Player:GetAttribute('IsOwlTarget') then
            local _owls = collectionService:GetTagged('Owl')
            if #_owls > 0 then
                local _uid = ent.Player.UserId
                for _, owl in ipairs(_owls) do
                    if owl:GetAttribute('Target') == _uid and owl:GetAttribute('Status') == 2 then
                        playerGravity = 0
                        break
                    end
                end
            end
        end

        local bowRelX = bedwars.BowConstantsTable.RelX or 0
        local bowRelY = bedwars.BowConstantsTable.RelY or 0
        local bowRelZ = bedwars.BowConstantsTable.RelZ or 0
        local ping = math.clamp(lplr:GetNetworkPing(), 0.03, 0.25) 
        local chestPos = targetPart.Position + Vector3.new(0, (ent.HipHeight or 2) * (ammo == 'fireball' and 1.0 or 0.15), 0)
        local extPos = chestPos + targetVel * ping
        local lookCF = CFrame.new(selfPos, extPos) * CFrame.new(bowRelX, bowRelY, bowRelZ)

        local calc = prediction.SolveTrajectory(
            lookCF.p,
            projSpeed,
            gravity,
            extPos,
            targetVel,
            playerGravity,
            ent.HipHeight or 2,
            ent.Jumping and 42.6 or nil,
            sharedFastHitsRayParams
        )

        if not calc then return false end

        local switched = false
        if not ignoreSwitch then
            switched = switchItem(item.tool, 0.05)
        end

        local aimCF = CFrame.lookAt(lookCF.Position, calc)
        local dir = aimCF.LookVector
        local shootPos = (aimCF * CFrame.new(-bowRelX, -bowRelY, -bowRelZ)).Position
        local id = httpService:GenerateGUID(true)

        targetinfo.Targets[ent] = tick() + 1
        ProjectileDelay[item.itemType] = tick() + (itemMeta.fireDelaySec or 0.5)
        bedwars.ProjectileController:createLocalProjectile(
            meta, ammo, projectile, shootPos, id, dir * projSpeed,
            {drawDurationSeconds = 1}
        )

		task.spawn(function()
		local res = projectileRemote:InvokeServer(
			item.tool, ammo, projectile, shootPos, selfPos,
			dir * projSpeed, id,
			{drawDurationSeconds = 1, shotId = httpService:GenerateGUID(false)},
			workspace:GetServerTimeNow() - ping
		)
		if res then
			pcall(function() res.Parent = replicatedStorage end)
			local sound = itemMeta.launchSound
			sound = sound and sound[math.random(1, #sound)] or nil
			if sound then bedwars.SoundManager:playSound(sound) end
		else
			ProjectileDelay[item.itemType] = tick() + (itemMeta.fireDelaySec or 0.5) + 0.1
		end
	end)

        if switched and not ignoreSwitch then task.wait(0.05) end
        return true
    end

    local function doFastHitsNEW(ent)
        if not ent or not ent.RootPart then return end
        if not entitylib.isAlive then return end

        local selfPos = entitylib.character.RootPart.Position
        local projectiles = getProjectiles()
        if not projectiles or #projectiles == 0 then return end
        local startIndex = fhUsageIndex
        local found = false
        repeat
            fhUsageIndex = fhUsageIndex % #projectiles + 1
            if canShoot(projectiles[fhUsageIndex]) then
                found = true
                break
            end
        until fhUsageIndex == startIndex

        if not found then return end

        local item, ammo, projectile, itemMeta = unpack(projectiles[fhUsageIndex])
        shootProjectile(item, ammo, projectile, itemMeta, selfPos, ent, false)
    end

    local function doFastHitsLegitSwitch(ent)
        if not ent or not ent.RootPart then return end
        if not entitylib.isAlive then return end

        local selfPos = entitylib.character.RootPart.Position
        local projectiles = getProjectiles()
        if not projectiles or #projectiles == 0 then return end
		
        local readyProj = nil
        for _, proj in projectiles do
            if canShoot(proj) then
                readyProj = proj
                break
            end
        end

        if not readyProj then return end
        local item, ammo, projectile, itemMeta = unpack(readyProj)
        local bowSlot = nil
        local swordSlot = nil
        local originalSlot = store.inventory.hotbarSlot
        local hotbar = store.inventory.hotbar
        for i = 1, #hotbar do
            local hv = hotbar[i]
            if hv and hv.item and hv.item.itemType then
                if hv.item.itemType == item.itemType and not bowSlot then
                    bowSlot = i - 1
                end
                local hm = bedwars.ItemMeta[hv.item.itemType]
                if hm and hm.sword and not swordSlot then
                    swordSlot = i - 1
                end
            end
        end

        if not bowSlot then return end
        if hotbarSwitch(bowSlot) then task.wait(0.05) end

        local isCrossbow = item.itemType:find('crossbow')
        if isCrossbow then
            pcall(function() bedwars.ViewmodelController:playAnimation(bedwars.AnimationType.FP_CROSSBOW_FIRE) end)
            bedwars.GameAnimationUtil:playAnimation(lplr, bedwars.AnimationType.CROSSBOW_FIRE)
        else
            pcall(function() bedwars.ViewmodelController:playAnimation(bedwars.AnimationType.FP_CROSSBOW_FIRE) end)
            bedwars.GameAnimationUtil:playAnimation(lplr, bedwars.AnimationType.BOW_FIRE)
        end

        shootProjectile(item, ammo, projectile, itemMeta, selfPos, ent, true)

        task.wait(0.05)
        hotbarSwitch(swordSlot or originalSlot)
    end

    local function doOldFastHits()
        if not store.KillauraTarget then return end
        local currentTime = tick()
        if (currentTime - lastOldShootTime) < OldShootInterval.Value then return end

        if OldFirstPersonCheck and OldFirstPersonCheck.Enabled then
            local cf = gameCamera.CFrame
            local char = entitylib.character
            if char and char.RootPart then
                local dist = (cf.Position - char.RootPart.Position).Magnitude
                if dist > 1 then return end
            end
        end

        local arrowItem = getItem('arrow')
        if not arrowItem or arrowItem.amount <= 0 then return end

        local bows = {}
        local swordSlot = nil
        local hotbar = store.inventory.hotbar
        for i = 1, #hotbar do
            local v = hotbar[i]
            if v and v.item and v.item.itemType then
                local itemMeta = bedwars.ItemMeta[v.item.itemType]
                if itemMeta then
                    if itemMeta.projectileSource then
                        local ps = itemMeta.projectileSource
                        if ps.ammoItemTypes and table.find(ps.ammoItemTypes, 'arrow') then
                            table.insert(bows, i - 1)
                        end
                    end
                    if itemMeta.sword and not swordSlot then
                        swordSlot = i - 1
                    end
                end
            end
        end

        if #bows == 0 then return end

        lastOldShootTime = currentTime
        local originalSlot = store.inventory.hotbarSlot
        for i = 1, #bows do
            local bowSlot = bows[i]
            if hotbarSwitch(bowSlot) then
                task.wait(OldSwitchDelay.Value)
                leftClick()
                task.wait(0.05)
            end
        end
        if swordSlot then
            hotbarSwitch(swordSlot)
        else
            hotbarSwitch(originalSlot)
        end
    end

    local function getEntityFromCharacterFH(char)
        for _, ent in ipairs(entitylib.List) do
            if ent.Character == char then return ent end
        end
        return nil
    end

    local function doFastHits()
        if not FastHits or not FastHits.Enabled then return end
        if not Killaura or not Killaura.Enabled then return end
        if not Attacking then return end
        if not store.KillauraTarget then return end
        if not entitylib.isAlive then return end

        local ent = store.KillauraTarget
        if not ent or not ent.RootPart then return end
        local selfPos = entitylib.character.RootPart.Position
        local dist = (ent.RootPart.Position - selfPos).Magnitude
        if dist > (AttackRange.Value + 2) then return end

        if FireRate and FireRate.Value > 0 then
            local now = tick()
            if (now - (ProjectileDelay._lastFHShot or 0)) < FireRate.Value then return end
            ProjectileDelay._lastFHShot = now
        end

        local mode = FastHitsMode and FastHitsMode.Value or 'NEWFastHits'
        if mode == 'NEWFastHits' then
            if LegitSwitch and LegitSwitch.Enabled then
                doFastHitsLegitSwitch(ent)
            else
                doFastHitsNEW(ent)
            end
        elseif mode == 'OLDFastHits' then
            doOldFastHits()
        end
    end

    local function startAutoShootLoop()
        if autoShootLoop then return end
        fastHitsHitTarget = nil
        fastHitsTrackedEntity = nil
        fastHitsHitCount = 0
        fastHitsActivationReady = false
        fastHitsLastHitTime = 0
        fhUsageIndex = 1
        table.clear(ProjectileDelay)
        table.clear(FastHitsFireDelays)

        autoShootLoop = task.spawn(function()
            while Killaura and Killaura.Enabled and FastHits and FastHits.Enabled do
                doFastHits()
                task.wait(0.05)
            end
            autoShootLoop = nil
        end)
    end

    local function stopAutoShootLoop()
        if autoShootLoop then
            task.cancel(autoShootLoop)
            autoShootLoop = nil
        end
        table.clear(ProjectileDelay)
        table.clear(FastHitsFireDelays)
        fhUsageIndex = 1
        fastHitsHitTarget = nil
        fastHitsTrackedEntity = nil
        fastHitsHitCount = 0
        fastHitsActivationReady = false
        fastHitsLastHitTime = 0
    end

    local attacked = {}
    local hadTargetsLastTick = false
    Killaura = vape.Categories.Blatant:CreateModule({
        Name = 'Killaura',
        Function = function(callback)
            if callback then
                lastAttackTime = 0
                swingCooldown = 0
                lastTargetTime = 0
                continueSwingCount = 0
                resetSwordCooldown()
                if Mouse and LegitAura and Mouse.Enabled and LegitAura.Enabled then
                    Mouse:Toggle(false)
                    LegitAura:Toggle(false)
                    notif("Killaura", "yo u cant have require mouse down AND swing only both on at da same time turned both off 4 u", 5)
                end

                if RangeCircle and RangeCircle.Enabled then
                    createRangeCircle()
                end
                if inputService.TouchEnabled and not preserveSwordIcon then
                    pcall(function()
                        lplr.PlayerGui.MobileUI['2'].Visible = Limit and Limit.Enabled
                    end)
                end

                 if FastHits and FastHits.Enabled then
                    startAutoShootLoop()
                end

                if Animation and Animation.Enabled and not (identifyexecutor and table.find({'Argon', 'Delta'}, ({identifyexecutor()})[1])) then
                    task.spawn(function()
                        local started = false
                        repeat
                            if Attacking then
                                if not armC0 then
                                    armC0 = gameCamera.Viewmodel.RightHand.RightWrist.C0
                                end
                                local first = not started
                                started = true
                                if AnimationMode.Value == 'Random' then
                                    anims.Random = {{CFrame = CFrame.Angles(math.rad(math.random(1, 360)), math.rad(math.random(1, 360)), math.rad(math.random(1, 360))), Time = 0.12}}
                                end
                                for _, v in anims[AnimationMode.Value] do
                                    if AnimTween then AnimTween:Destroy() AnimTween = nil end
                                	AnimTween = tweenService:Create(gameCamera.Viewmodel.RightHand.RightWrist, TweenInfo.new(first and (AnimationTween.Enabled and 0.001 or 0.1) or v.Time / AnimationSpeed.Value, Enum.EasingStyle.Linear), {
                                        C0 = armC0 * v.CFrame
                                    })
                                    AnimTween:Play()
                                    AnimTween.Completed:Wait()
                                    first = false
                                    if (not Killaura.Enabled) or (not Attacking) then break end
                                end
                            elseif started then
                                started = false
                                if AnimTween then AnimTween:Destroy() AnimTween = nil end
                                AnimTween = tweenService:Create(gameCamera.Viewmodel.RightHand.RightWrist, TweenInfo.new(AnimationTween.Enabled and 0.001 or 0.3, Enum.EasingStyle.Exponential), {
                                    C0 = armC0
                                })
                                AnimTween:Play()
                            end
                            if not started then
                                task.wait(1 / UpdateRate.Value)
                            end
                        until (not Killaura.Enabled) or (not Animation.Enabled)
                    end)
                end

                local function gatherTargets(selfpos)
                        local walls = Targets.Walls.Enabled or nil
                        local players = Targets.Players.Enabled
                        local npcs = Targets.NPCs.Enabled
                        local limit = MaxTargets.Value
                        local sort = sortmethods[Sort.Value]
                        local swingPlrs = entitylib.AllPosition({
                            Range = SwingRange.Value,
                            Wallcheck = walls,
                            Part = 'RootPart',
                            Players = players,
                            NPCs = npcs,
                            Limit = limit,
                            Sort = sort
                        })
                        if AttackRange.Value == SwingRange.Value then
                            return swingPlrs, swingPlrs
                        end
                        local attackPlrs = entitylib.AllPosition({
                            Range = AttackRange.Value,
                            Wallcheck = walls,
                            Part = 'RootPart',
                            Players = players,
                            NPCs = npcs,
                            Limit = limit,
                            Sort = sort
                        })
                        return swingPlrs, attackPlrs
                    end

                local _cachedSwordType = nil
                local _cachedIsClaw = false
                local _swingCooldown = 0

                repeat
                    if AttackCheck and AttackCheck.Enabled then
                        local triggered = false
                        local stunTime = lplr.Character and lplr.Character:GetAttribute('StunnedUntilTime')
                        if stunTime and stunTime > workspace:GetServerTimeNow() then triggered = true end
                        if not triggered and kitChecks then
                            for _, check in pairs(kitChecks) do
                                if check() then triggered = true break end
                            end
                        end
                        if triggered then
                            Attacking = false
                            store.KillauraTarget = nil
                            task.wait(0.3)
                            continue
                        end
                    end

                    pcall(function()
                        if entitylib.isAlive and entitylib.character.HumanoidRootPart and RangeCirclePart then
                            RangeCirclePart.Position = entitylib.character.HumanoidRootPart.Position - Vector3.new(0, entitylib.character.Humanoid.HipHeight, 0)
                        end
                    end)

                    table.clear(attacked)
                    local sword, meta = getAttackData()
                    Attacking = false
                    store.KillauraTarget = nil

                    if vapeTargetInfo and vapeTargetInfo.Targets then
                        vapeTargetInfo.Targets.Killaura = nil
                    end

                    if sword then
                        if sword.itemType ~= _cachedSwordType then
                            _cachedSwordType = sword.itemType
                            _cachedIsClaw = sword.itemType and sword.itemType:find("summoner_claw") ~= nil
                        end
                        local isClaw = _cachedIsClaw

                        local selfpos = entitylib.character.RootPart.Position
                        local flatLV = entitylib.character.RootPart.CFrame.LookVector * Vector3.new(1, 0, 1)
                        local localfacing = flatLV.Magnitude > 0.001 and flatLV.Unit or entitylib.character.RootPart.CFrame.RightVector
                        local maxAngle = math.rad(AngleSlider.Value) / 2
                        local _cachedPing = math.clamp(lplr:GetNetworkPing(), 0.03, 0.4)
                        local swingPlrs, attackPlrs = gatherTargets(selfpos)

                        local hasValidSwingTargets = false
                        local hasValidAttackTargets = false

						for _, v in swingPlrs do
							local flat = (v.RootPart.Position - selfpos) * Vector3.new(1, 0, 1)
							if flat.Magnitude <= 1.0 or math.acos(math.clamp(localfacing:Dot(flat.Unit), -1, 1)) <= maxAngle then
								hasValidSwingTargets = true
								break
							end
						end

						for _, v in attackPlrs do
							local flat = (v.RootPart.Position - selfpos) * Vector3.new(1, 0, 1)
							if flat.Magnitude <= 1.0 or math.acos(math.clamp(localfacing:Dot(flat.Unit), -1, 1)) <= maxAngle then
								hasValidAttackTargets = true
								break
							end
						end

                        if hasValidSwingTargets or hasValidAttackTargets then
                            lastTargetTime = tick()
                        end

                        if hasValidAttackTargets and not hadTargetsLastTick then
                            resetSwordCooldown()
                        end
                        hadTargetsLastTick = hasValidAttackTargets

                        local shouldSwing = hasValidSwingTargets or hasValidAttackTargets or shouldContinueSwinging()

                        if shouldSwing then
                            switchItem(sword.tool, 0)

                            if hasValidAttackTargets then
                                for _, v in attackPlrs do
                                    local delta = v.RootPart.Position - selfpos
                                    local flat = delta * Vector3.new(1, 0, 1)
                                    if flat.Magnitude > 1.0 and math.acos(math.clamp(localfacing:Dot(flat.Unit), -1, 1)) > maxAngle then continue end

                                    table.insert(attacked, {
                                        Entity = v,
                                        Check = delta.Magnitude > AttackRange.Value and BoxSwingColor or BoxAttackColor
                                    })
                                    targetinfo.Targets[v] = tick() + 1

                                    if vapeTargetInfo and vapeTargetInfo.Targets then
                                        local info = {Humanoid = {Health = v.Health, MaxHealth = v.MaxHealth}, Player = v.Player}
                                        vapeTargetInfo.Targets.Killaura = info
                                    end

                                    if not Attacking then
                                        Attacking = true
                                        store.KillauraTarget = v
                                        if not isClaw then
                                            local allowSwingAnim = not (Swing and Swing.Enabled) and AnimDelay <= tick() and not (LegitAura and LegitAura.Enabled)
                                            if allowSwingAnim then
                                                local swingSpeed = SwingTime and SwingTime.Enabled and math.max(SwingTimeSlider.Value, 0.11) or (meta.sword and meta.sword.respectAttackSpeedForEffects and meta.sword.attackSpeed or 0.25)
                                                AnimDelay = tick() + swingSpeed
                                                pcall(function()
                                                    bedwars.SwordController:playSwordEffect(meta, false)
                                                    if meta.displayName:find(' Scythe') then
                                                        bedwars.ScytheController:playLocalAnimation()
                                                    end
                                                end)
                                                if vape.ThreadFix and setthreadidentity then
                                                    pcall(setthreadidentity, 8)
                                                end
                                            end
                                        end
                                    end

                                    local predictedPos = v.RootPart.Position + v.RootPart.Velocity * _cachedPing
                                    local canHit = (predictedPos - selfpos).Magnitude <= AttackRange.Value
                                    if not canHit then continue end

                                    if AirHit and AirHit.Enabled then
                                        local humanoid = v.Character:FindFirstChildOfClass("Humanoid")
                                        if humanoid then
                                            local state = humanoid:GetState()
                                            if state == Enum.HumanoidStateType.Jumping or state == Enum.HumanoidStateType.Freefall or state == Enum.HumanoidStateType.Physics then
                                                if math.random(1, 100) > AirHitsChance.Value then continue end
                                            end
                                        end
                                    end

                                    local swingSpeed = SwingTime and SwingTime.Enabled and SwingTimeSlider.Value or (meta.sword and meta.sword.respectAttackSpeedForEffects and meta.sword.attackSpeed or 0.42)
                                    if SyncHits and SyncHits.Enabled then
                                        local timeSinceLastSwing = tick() - swingCooldown
                                        if timeSinceLastSwing < math.max(swingSpeed * 0.15, 0.03) then continue end
                                    end

                                    local actualRoot = v.Character.PrimaryPart
                                    if not actualRoot then continue end

                                    local targetPos = actualRoot.Position + actualRoot.Velocity * _cachedPing
                                    local camOrigin = gameCamera.CFrame.Position
                                    local dir = CFrame.lookAt(camOrigin, targetPos).LookVector
                                    local spoofedPos = camOrigin + dir * math.max((targetPos - camOrigin).Magnitude - 14.399, 0)

                                    if SyncHits and SyncHits.Enabled then
                                        if (tick() - swingCooldown) >= math.max(swingSpeed * 0.15, 0.03) then
                                            swingCooldown = tick()
                                        end
                                    else
                                        swingCooldown = tick()
                                    end

                                    local _serverNow = workspace:GetServerTimeNow()
                                    lastSwingServerTimeDelta = _serverNow - lastSwingServerTime
                                    lastSwingServerTime = _serverNow
                                    store.attackReach = (delta.Magnitude * 100) // 1 / 100
                                    store.attackReachUpdate = tick() + 1
                                    lastAttackTime = tick()

                                    if delta.Magnitude < 14.4 and SwingTime and SwingTime.Enabled and SwingTimeSlider.Value > 0.11 then
                                        AnimDelay = tick()
                                    end

                                    if isClaw then
                                        pcall(function() KaidaController:request(v.Character) end)
                                    else
                                        bedwars.SwordController.lastAttack = _serverNow
                                        _swingCooldown = tick()
                                        FireAttackRemote({
                                            weapon = sword.tool,
                                            chargedAttack = {chargeRatio = 0},
                                            lastSwingServerTimeDelta = math.clamp(lastSwingServerTimeDelta, 0.2, 0.8),
                                            entityInstance = v.Character,
                                            validate = {
                                                raycast = {
                                                    cameraPosition = {value = camOrigin},
                                                    cursorDirection = {value = dir}
                                                },
                                                targetPosition = {value = targetPos},
                                                selfPosition = {value = spoofedPos}
                                            }
                                        })
                                    end
                                end
                            else
                                Attacking = true
                                if not isClaw then
                                    if not (Swing and Swing.Enabled) and AnimDelay <= tick() and not (LegitAura and LegitAura.Enabled) then
                                        local swingSpeed = SwingTime and SwingTime.Enabled and math.max(SwingTimeSlider.Value, 0.11) or (meta.sword and meta.sword.respectAttackSpeedForEffects and meta.sword.attackSpeed or 0.25)
                                        AnimDelay = tick() + swingSpeed
                                        pcall(function()
                                            bedwars.SwordController:playSwordEffect(meta, false)
                                            if meta.displayName:find(' Scythe') then
                                                bedwars.ScytheController:playLocalAnimation()
                                            end
                                        end)
                                        if vape.ThreadFix and setthreadidentity then
                                            pcall(setthreadidentity, 8)
                                        end
                                    end
                                end
                                local currentSwingSpeed = SwingTime and SwingTime.Enabled and SwingTimeSlider.Value or (meta.sword and meta.sword.respectAttackSpeedForEffects and meta.sword.attackSpeed or 0.42)
                                if not (SyncHits and SyncHits.Enabled) or (tick() - swingCooldown) >= math.max(currentSwingSpeed, 0.05) then
                                    swingCooldown = tick()
                                end
                            end
                        end
                    end

                    pcall(function()
                        for i, v in Boxes do
                            v.Adornee = attacked[i] and attacked[i].Entity.RootPart or nil
                            if v.Adornee then
                                v.Color3 = Color3.fromHSV(attacked[i].Check.Hue, attacked[i].Check.Sat, attacked[i].Check.Value)
                                v.Transparency = 1 - attacked[i].Check.Opacity
                            end
                        end
                        for i, v in Particles do
                            v.Position = attacked[i] and attacked[i].Entity.RootPart.Position or Vector3.new(9e9, 9e9, 9e9)
                            v.Parent = attacked[i] and gameCamera or nil
                        end
                    end)

                    if Face and Face.Enabled and attacked[1] then
                        local vec = attacked[1].Entity.RootPart.Position * Vector3.new(1, 0, 1)
                        local targetCFrame = CFrame.lookAt(entitylib.character.RootPart.Position, Vector3.new(vec.X, entitylib.character.RootPart.Position.Y + 0.001, vec.Z))
                        local speed = FaceSpeed and FaceSpeed.Value or 15
                        entitylib.character.RootPart.CFrame = entitylib.character.RootPart.CFrame:Lerp(targetCFrame, math.clamp(speed / 100, 0.01, 1))
                    end

                    pcall(function() if RangeCirclePart ~= nil then RangeCirclePart.Parent = gameCamera end end)
                    task.wait(1 / UpdateRate.Value)
                until not Killaura.Enabled
            else
                stopAutoShootLoop()
                table.clear(ProjectileDelay)
                table.clear(attacked)
                store.KillauraTarget = nil
                for _, v in Boxes do v.Adornee = nil end
                for _, v in Particles do v.Parent = nil end
                if inputService.TouchEnabled then
                    pcall(function() lplr.PlayerGui.MobileUI['2'].Visible = true end)
                end
                Attacking = false
                if armC0 then
                    if AnimTween then AnimTween:Destroy() AnimTween = nil end
                    AnimTween = tweenService:Create(gameCamera.Viewmodel.RightHand.RightWrist, TweenInfo.new(AnimationTween and AnimationTween.Enabled and 0.001 or 0.3, Enum.EasingStyle.Exponential), {
                        C0 = armC0
                    })
                    AnimTween:Play()
                end
                if RangeCirclePart ~= nil then RangeCirclePart:Destroy() end
            end
        end,
        Tooltip = 'Attack players around you\nwithout aiming at them.'
    })

    pcall(function()
        local PSI = Killaura:CreateToggle({
            Name = 'Preserve Sword Icon',
            Function = function(callback)
                preserveSwordIcon = callback
            end,
            Default = true
        })
        PSI.Object.Visible = inputService.TouchEnabled
    end)

    Targets = Killaura:CreateTargets({
        Players = true,
        NPCs = true
    })

    TargetPriority = Killaura:CreateDropdown({
        Name = 'Target Priority',
        List = {'Players First', 'NPCs First', 'Distance'},
        Default = 'Players First',
        Tooltip = 'Choose which targets to prioritize'
    })

    local methods = {'Damage', 'Distance'}
    for i in sortmethods do
        if not table.find(methods, i) then
            table.insert(methods, i)
        end
    end
    SwingRange = Killaura:CreateSlider({
        Name = 'Swing range',
        Min = 1,
        Max = 40,
        Default = 22,
        Suffix = function(val) return val == 1 and 'stud' or 'studs' end
    })
    AttackRange = Killaura:CreateSlider({
        Name = 'Attack range',
        Min = 1,
        Max = 22,
        Default = 22,
        Suffix = function(val) return val == 1 and 'stud' or 'studs' end
    })
    RangeCircle = Killaura:CreateToggle({
        Name = "Range Visualiser",
        Function = function(call)
            if call then
                createRangeCircle()
            else
                if RangeCirclePart then
                    RangeCirclePart:Destroy()
                    RangeCirclePart = nil
                end
            end
        end
    })
    AngleSlider = Killaura:CreateSlider({Name = 'Max angle', Min = 1, Max = 360, Default = 360})
    UpdateRate = Killaura:CreateSlider({Name = 'Update rate', Min = 1, Max = 120, Default = 60, Suffix = 'hz'})
    MaxTargets = Killaura:CreateSlider({Name = 'Max targets', Min = 1, Max = 5, Default = 5})
    Sort = Killaura:CreateDropdown({Name = 'Target Mode', List = methods})
    Mouse = Killaura:CreateToggle({
        Name = 'Require mouse down',
        Function = function(callback)
            if callback and LegitAura and LegitAura.Enabled then
                Mouse:Toggle(false)
                LegitAura:Toggle(false)
                notif("Killaura", "yo u cant have require mouse down AND swing only on at da same time turned both off 4 u ", 5)
            end
        end
    })
    Swing = Killaura:CreateToggle({Name = 'No Swing'})
    GUI = Killaura:CreateToggle({Name = 'GUI check'})
    SwingTime = Killaura:CreateToggle({
        Name = 'Custom Swing Time',
        Function = function(callback)
            SwingTimeSlider.Object.Visible = callback
        end
    })
    SwingTimeSlider = Killaura:CreateSlider({
        Name = 'Swing Time',
        Min = 0,
        Max = 1,
        Default = 0.42,
        Decimal = 100,
        Visible = false
    })
    ContinueSwinging = Killaura:CreateToggle({
        Name = 'Continue Swinging',
        Tooltip = 'Swing X times after losing target (based on swing speed)',
        Function = function(callback)
            if ContinueSwingTime then
                ContinueSwingTime.Object.Visible = callback
            end
        end
    })
    ContinueSwingTime = Killaura:CreateSlider({
        Name = 'Swing Duration',
        Min = 0,
        Max = 5,
        Default = 1,
        Decimal = 10,
        Suffix = 's',
        Visible = false
    })
    CustomHitReg = Killaura:CreateToggle({
        Name = 'Custom Hit Reg',
        Tooltip = 'Limit how many hits per second',
        Function = function(callback)
            if CustomHitRegSlider then
                CustomHitRegSlider.Object.Visible = callback
            end
            if callback then
                lastCustomHitTime = 0
            end
        end
    })
    CustomHitRegSlider = Killaura:CreateSlider({
        Name = 'Hits Per Second',
        Min = 1,
        Max = 36,
        Default = 30,
        Tooltip = 'Maximum hits per second',
        Visible = false
    })
    SyncHits = Killaura:CreateToggle({
        Name = 'Sync Hits',
        Tooltip = 'Waits for sword animation before attacking'
    })
    Killaura:CreateToggle({
        Name = 'Show target',
        Function = function(callback)
            BoxSwingColor.Object.Visible = callback
            BoxAttackColor.Object.Visible = callback
            if callback then
                for i = 1, 10 do
                    local box = Instance.new('BoxHandleAdornment')
                    box.Adornee = nil
                    box.AlwaysOnTop = true
                    box.Size = Vector3.new(3, 5, 3)
                    box.CFrame = CFrame.new(0, -0.5, 0)
                    box.ZIndex = 0
                    box.Parent = vape.gui
                    Boxes[i] = box
                end
            else
                for _, v in Boxes do v:Destroy() end
                table.clear(Boxes)
            end
        end
    })
    BoxSwingColor = Killaura:CreateColorSlider({
        Name = 'Target Color',
        Darker = true,
        DefaultHue = 0.6,
        DefaultOpacity = 0.5,
        Visible = false,
        Function = function(hue, sat, val)
            if Killaura.Enabled and RangeCirclePart ~= nil then
                RangeCirclePart.Color = Color3.fromHSV(hue, sat, val)
            end
        end
    })
    BoxAttackColor = Killaura:CreateColorSlider({
        Name = 'Attack Color',
        Darker = true,
        DefaultOpacity = 0.5,
        Visible = false
    })
    Killaura:CreateToggle({
        Name = 'Target particles',
        Function = function(callback)
            ParticleTexture.Object.Visible = callback
            ParticleColor1.Object.Visible = callback
            ParticleColor2.Object.Visible = callback
            ParticleSize.Object.Visible = callback
            if callback then
                for i = 1, 10 do
                    local part = Instance.new('Part')
                    part.Size = Vector3.new(2, 4, 2)
                    part.Anchored = true
                    part.CanCollide = false
                    part.Transparency = 1
                    part.CanQuery = false
                    part.Parent = Killaura.Enabled and gameCamera or nil
                    local particles = Instance.new('ParticleEmitter')
                    particles.Brightness = 1.5
                    particles.Size = NumberSequence.new(ParticleSize.Value)
                    particles.Shape = Enum.ParticleEmitterShape.Sphere
                    particles.Texture = ParticleTexture.Value
                    particles.Transparency = NumberSequence.new(0)
                    particles.Lifetime = NumberRange.new(0.4)
                    particles.Speed = NumberRange.new(16)
                    particles.Rate = 128
                    particles.Drag = 16
                    particles.ShapePartial = 1
                    particles.Color = ColorSequence.new({
                        ColorSequenceKeypoint.new(0, Color3.fromHSV(ParticleColor1.Hue, ParticleColor1.Sat, ParticleColor1.Value)),
                        ColorSequenceKeypoint.new(1, Color3.fromHSV(ParticleColor2.Hue, ParticleColor2.Sat, ParticleColor2.Value))
                    })
                    particles.Parent = part
                    Particles[i] = part
                end
            else
                for _, v in Particles do v:Destroy() end
                table.clear(Particles)
            end
        end
    })
    ParticleTexture = Killaura:CreateTextBox({
        Name = 'Texture',
        Default = 'rbxassetid://14736249347',
        Function = function()
            for _, v in Particles do
                v.ParticleEmitter.Texture = ParticleTexture.Value
            end
        end,
        Darker = true,
        Visible = false
    })
    ParticleColor1 = Killaura:CreateColorSlider({
        Name = 'Color Begin',
        Function = function(hue, sat, val)
            for _, v in Particles do
                v.ParticleEmitter.Color = ColorSequence.new({
                    ColorSequenceKeypoint.new(0, Color3.fromHSV(hue, sat, val)),
                    ColorSequenceKeypoint.new(1, Color3.fromHSV(ParticleColor2.Hue, ParticleColor2.Sat, ParticleColor2.Value))
                })
            end
        end,
        Darker = true,
        Visible = false
    })
    ParticleColor2 = Killaura:CreateColorSlider({
        Name = 'Color End',
        Function = function(hue, sat, val)
            for _, v in Particles do
                v.ParticleEmitter.Color = ColorSequence.new({
                    ColorSequenceKeypoint.new(0, Color3.fromHSV(ParticleColor1.Hue, ParticleColor1.Sat, ParticleColor1.Value)),
                    ColorSequenceKeypoint.new(1, Color3.fromHSV(hue, sat, val))
                })
            end
        end,
        Darker = true,
        Visible = false
    })
    ParticleSize = Killaura:CreateSlider({
        Name = 'Size',
        Min = 0,
        Max = 1,
        Default = 0.2,
        Decimal = 100,
        Function = function(val)
            for _, v in Particles do
                v.ParticleEmitter.Size = NumberSequence.new(val)
            end
        end,
        Darker = true,
        Visible = false
    })
    Face = Killaura:CreateToggle({
        Name = 'Face target',
        Function = function(callback)
            if FaceSpeed then FaceSpeed.Object.Visible = callback end
        end
    })
    FaceSpeed = Killaura:CreateSlider({
        Name = 'Face Speed',
        Min = 1,
        Max = 100,
        Default = 15,
        Decimal = 10,
        Darker = true,
        Visible = false,
        Tooltip = 'How fast to snap towards target (lower = slower/smoother)'
    })
    Animation = Killaura:CreateToggle({
        Name = 'Custom Animation',
        Function = function(callback)
            AnimationMode.Object.Visible = callback
            AnimationTween.Object.Visible = callback
            AnimationSpeed.Object.Visible = callback
            if Killaura.Enabled then
                Killaura:Toggle()
                Killaura:Toggle()
            end
        end
    })
    local animnames = {}
    for i in anims do table.insert(animnames, i) end
    AnimationMode = Killaura:CreateDropdown({
        Name = 'Animation Mode',
        List = animnames,
        Darker = true,
        Visible = false
    })
    AnimationSpeed = Killaura:CreateSlider({
        Name = 'Animation Speed',
        Min = 0,
        Max = 2,
        Default = 1,
        Decimal = 10,
        Darker = true,
        Visible = false
    })
    AnimationTween = Killaura:CreateToggle({Name = 'No Tween', Darker = true, Visible = false})
    Limit = Killaura:CreateToggle({
        Name = 'Limit to items',
        Function = function(callback)
            if inputService.TouchEnabled and Killaura.Enabled then
                pcall(function() lplr.PlayerGui.MobileUI['2'].Visible = callback end)
            end
        end,
        Tooltip = 'Only attacks when the sword is held'
    })
    LegitAura = Killaura:CreateToggle({
        Name = 'Swing only',
        Tooltip = 'Only attacks while swinging manually',
        Function = function(callback)
            if callback and Mouse and Mouse.Enabled then
                LegitAura:Toggle(false)
                Mouse:Toggle(false)
                notif("Killaura", "yo u cant have swing only AND require mouse down on at da same time lol turned both off 4 u ", 5)
            end
        end
    })
    AirHit = Killaura:CreateToggle({
        Name = 'Air Hits',
        Default = true,
        Tooltip = 'Control hit chance when target is airborne',
        Function = function(callback)
            if AirHitsChance then
                AirHitsChance.Object.Visible = callback
            end
        end
    })
    AirHitsChance = Killaura:CreateSlider({
        Name = 'Air Hits Chance',
        Min = 0,
        Max = 100,
        Default = 100,
        Suffix = '%',
        Decimal = 5,
        Darker = true,
        Visible = false
    })

    local _silasThread = task.spawn(function()
        local wasAvailable = true
        while vape.Loaded do
            task.wait(0.05)
            if bedwars.AbilityController then
                local ok, nowAvailable = pcall(bedwars.AbilityController.canUseAbility, bedwars.AbilityController, 'rebellion_shield')
                nowAvailable = ok and nowAvailable
                if wasAvailable and not nowAvailable then
                    store.silasAbilityTime = tick()
                end
                wasAvailable = nowAvailable
            end
        end
    end)
    local _terraThread = task.spawn(function()
        local wasStompAvailable = true
        local wasKickAvailable = true
        while vape.Loaded do
            task.wait(0.05)
            if bedwars.AbilityController then
                local ok1, nowStomp = pcall(bedwars.AbilityController.canUseAbility, bedwars.AbilityController, 'BLOCK_STOMP')
                local ok2, nowKick = pcall(bedwars.AbilityController.canUseAbility, bedwars.AbilityController, 'BLOCK_KICK')
                nowStomp = ok1 and nowStomp
                nowKick = ok2 and nowKick
                if wasStompAvailable and not nowStomp then store.terraStompTime = tick() end
                if wasKickAvailable and not nowKick then store.terraKickTime = tick() end
                wasStompAvailable = nowStomp
                wasKickAvailable = nowKick
            end
        end
    end)

    kitChecks = {
        ['Sophia'] = function() return isFrozen(nil, FROZEN_THRESHOLD) end,
        ['Sigrid'] = function() return entitylib.isAlive and lplr.Character and lplr.Character:FindFirstChild('elk') ~= nil end,
    }
	DynamicReach = Killaura:CreateToggle({
        Name = 'Dynamic Reach',
        Default = false,
        Tooltip = 'Optimizes hit data and timing at far ranges'
    })
    AttackCheck = Killaura:CreateToggle({
        Name = 'Attack Check',
        Tooltip = 'Stops Killaura when a kit ability is detected (Sophia, etc) or when asleep',
        Function = function(callback) end,
        Default = false
    })

    FastHits = Killaura:CreateToggle({
        Name = 'Fast Hits',
        Tooltip = 'Deals more damage quicker using projectiles',
        Default = false,
        Function = function(call)
            FastHitsMode.Object.Visible = call
            FireRate.Object.Visible = call and FastHitsMode.Value == 'NEWFastHits'
            if LegitSwitch then LegitSwitch.Object.Visible = call and FastHitsMode.Value == 'NEWFastHits' end
            if OldShootInterval then OldShootInterval.Object.Visible = call and FastHitsMode.Value == 'OLDFastHits' end
            if OldSwitchDelay then OldSwitchDelay.Object.Visible = call and FastHitsMode.Value == 'OLDFastHits' end
            if OldWaitDelay then OldWaitDelay.Object.Visible = call and FastHitsMode.Value == 'OLDFastHits' end
            if OldFirstPersonCheck then OldFirstPersonCheck.Object.Visible = call and FastHitsMode.Value == 'OLDFastHits' end
            if call then
                 if Killaura and Killaura.Enabled then
                    startAutoShootLoop()
                end
            else
                stopAutoShootLoop()
            end
        end
    })
    FastHitsMode = Killaura:CreateDropdown({
        Name = 'Fast Hits Mode',
        List = {'NEWFastHits', 'OLDFastHits'},
        Default = 'NEWFastHits',
        Darker = true,
        Visible = false,
        Function = function(val)
            FireRate.Object.Visible = val == 'NEWFastHits'
            LegitSwitch.Object.Visible = val == 'NEWFastHits'
            OldShootInterval.Object.Visible = val == 'OLDFastHits'
            OldSwitchDelay.Object.Visible = val == 'OLDFastHits'
            OldWaitDelay.Object.Visible = val == 'OLDFastHits'
            OldFirstPersonCheck.Object.Visible = val == 'OLDFastHits'
        end
    })
    LegitSwitch = Killaura:CreateToggle({
        Name = 'Legit Switch',
        Default = false,
        Darker = true,
        Visible = false,
        Tooltip = 'Uses hotbarSwitch to switch to crossbow before shooting instead of silent switch'
    })
    OldShootInterval = Killaura:CreateSlider({
        Name = 'Shoot Interval',
        Min = 0.1, Max = 3, Default = 0.5, Decimal = 10, Suffix = 's',
        Darker = true, Visible = false,
        Tooltip = 'How often to shoot bows'
    })
    OldSwitchDelay = Killaura:CreateSlider({
        Name = 'Switch Delay',
        Min = 0, Max = 0.2, Default = 0.05, Decimal = 100, Suffix = 's',
        Darker = true, Visible = false,
        Tooltip = 'Delay between switching and shooting'
    })
    OldWaitDelay = Killaura:CreateSlider({
        Name = 'Wait Delay',
        Min = 0, Max = 1, Default = 0, Decimal = 100, Suffix = 's',
        Darker = true, Visible = false,
        Tooltip = 'Delay before shooting'
    })
    OldFirstPersonCheck = Killaura:CreateToggle({
        Name = 'First Person Only',
        Default = false, Darker = true, Visible = false,
        Tooltip = 'Only works in first person mode'
    })
    FireRate = Killaura:CreateSlider({
        Name = 'Fire rate',
        Suffix = 's',
        Min = 0, Max = 2, Decimal = 100,
        Darker = true, Visible = false,
        Default = 0
    })

    task.defer(function()
        if AirHit and AirHit.Enabled and AirHitsChance and AirHitsChance.Object then
            AirHitsChance.Object.Visible = true
        end
    end)
end)


-----------



--// Note: 

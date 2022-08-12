local MOD_ROOT = "__TheArcFurnaceImp__"
local furnace_type = settings.startup["ArcFurnace-type"].value
local furnace_crafting_category = settings.startup["ArcFurnace-crafting-category"].value

if furnace_crafting_category == "smelting+kiln" then
    -- Check if space exploration >= 0.6 is there for the kiln crafting category.
    if mods["space-exploration"] ~= nil then
        local major, minor, patch = string.match(mods["space-exploration"], "(%d+)%.(%d+)%.(%d+)")
        if (tonumber(major) == 0 and tonumber(minor) >= 6) or (tonumber(major) >= 1) then
            furnace_crafting_category = {"smelting", "kiln"}
        else
            furnace_crafting_category = {"smelting"}
        end
    end
else
    furnace_crafting_category = {furnace_crafting_category}
end

data:extend({
	-- Tech Tree Recipe
    {
        type = "technology",
        name = "arc-furnace",
        icon_size = 357,
        icon = MOD_ROOT .. "/graphics/hr-arc-furnace-square.png",
        effects = {{type = "unlock-recipe", recipe = "arc-furnace"}},
        prerequisites = {"advanced-material-processing-2"},
        unit = {
            count = 500,
            ingredients = {
				{"automation-science-pack", 1},
				{"logistic-science-pack", 1},
                {"chemical-science-pack", 1}
            },
            time = 30
        },
        order = "c-c-b"
	},

    -- Arc Furnace Recipe
    {type = "recipe-category", name = "arc-smelting"},

    {
        type = "recipe",
        name = "arc-furnace",
        ingredients = {
            {"steel-plate", 1000},
            {"advanced-circuit", 100},
            {"electric-furnace", 20}
        },
        result = "arc-furnace",
        energy_required = 50,
        enabled = false
	},
	{
        type = "item",
        name = "arc-furnace",
        icon = MOD_ROOT .. "/graphics/hr-arc-furnace-square.png",
        icon_size = 357,
        subgroup = "smelting-machine",
        order = "d[arc-furnace]",
        place_result = "arc-furnace",
        stack_size = 50
	},
	{
        type = furnace_type,
        name = "arc-furnace",
        icon = MOD_ROOT .. "/graphics/hr-arc-furnace-square.png",
        icon_size = 357,
        flags = {"placeable-neutral", "placeable-player", "player-creation"},
        minable = {mining_time = 5, result = "arc-furnace"},
        max_health = 5000,
        corpse = "big-remnants",
        dying_explosion = "medium-explosion",
        resistances = {{type = "fire", percent = 80}},
        collision_box = {{-10, -2.8}, {10, 6.3}},
        selection_box = {{-10, -2.8}, {10, 6.3}},
        drawing_box   = {{-10, -2.8}, {10, 6.3}},
        module_specification = {
            module_slots = 8,
            module_info_icon_shift = {0, 0.8}
        },
        allowed_effects = {"consumption", "speed", "productivity", "pollution"},
        crafting_categories = furnace_crafting_category,
        result_inventory_size = 2,
        crafting_speed = settings.startup["ArcFurnace-CraftingSpeed"].value,
        energy_usage = "100000kW",
        source_inventory_size = 1,
        energy_source = {
            type = "electric",
            usage_priority = "secondary-input",
            emissions = 0.005
        },
        vehicle_impact_sound = {
            filename = "__base__/sound/car-metal-impact.ogg",
            volume = 0.7
        },
        working_sound = {
            sound = {
                filename = "__base__/sound/electric-furnace.ogg",
                volume = 0.7
            },
            apparent_volume = 2.0
        },
        animation = {
            layers = {
                {
                    filename = MOD_ROOT .. "/graphics/hr-arc-furnace.png",
                    priority = "high",
                    width = 357,
                    height = 230,
                    frame_count = 1,
                    shift = {0, 0},
                    scale = 4,
                    hr_version = {
                        filename = MOD_ROOT .. "/graphics/hr-arc-furnace.png",
                        priority = "high",
                        width = 357,
                        height = 230,
                        frame_count = 1,
                        shift = {0, 0},
                        scale = 2
                    }
                }, {
                    filename = MOD_ROOT .. "/graphics/hr-arc-furnace-shadow.png",
                    priority = "high",
                    width = 357,
                    height = 230,
                    frame_count = 1,
                    scale = 4,
                    shift = {1, -2},
                    draw_as_shadow = true,
                    hr_version = {
                        filename = MOD_ROOT .. "/graphics/hr-arc-furnace-shadow.png",
                        priority = "high",
                        width = 357,
                        height = 230,
                        frame_count = 1,
                        draw_as_shadow = true,
                        shift = {1, -2},
                        scale = 2
                    }
                }
            }
        },
        working_visualisations = {
            {
                animation = {
                    filename = MOD_ROOT .. "/graphics/arc-furnace-light.png",
                    priority = "high",
                    width = 114,
                    height = 84,
                    animation_speed = 1,
                    scale = 4,
                    shift = {0, -3.95},
                    hr_version = {
                        filename = MOD_ROOT .. "/graphics/arc-furnace-light.png",
                        priority = "high",
                        width = 114,
                        height = 84,
                        animation_speed = 1,
                        shift = {0, -3.95},
                        scale = 2
                    }
                },
                light = {
                    intensity = 0.6,
                    size = 20,
                    shift = {0.0, -2.0},
                    color = {r = 0.4, g = 0.4, b = 1.0}
                }
			},
        }
	}
})

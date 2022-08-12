data:extend({
    {
        type = "double-setting",
        name = "ArcFurnace-CraftingSpeed",
        setting_type = "startup",
        default_value = 100,
        minimum_value = 0.1,
        maximum_value = 200
    },
    {
        type = "string-setting",
        name = "ArcFurnace-type",
        setting_type = "startup",
        default_value = "furnace",
        allowed_values = {"assembling-machine", "furnace"},
        order = "a"
    },
    {
        type = "string-setting",
        name = "ArcFurnace-crafting-category",
        setting_type = "startup",
        default_value = "arc-smelting",
        allowed_values = {"smelting", "arc-smelting"},
        order = "a"
    }
})

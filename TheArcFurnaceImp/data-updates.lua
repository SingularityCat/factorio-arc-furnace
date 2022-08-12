local utils_table = require('__stdlib__/stdlib/utils/table')
local furnace_crafting_category = settings.startup["ArcFurnace-crafting-category"].value

local function mimic_recipe_module_limitations(source_recipe, target_recipe)
    for _, module in pairs(data.raw["module"]) do
        if module.limitation ~= nil then
            for _, recipe in ipairs(module.limitation) do
                if recipe == source_recipe then
                    table.insert(module.limitation, target_recipe)
                    break
                end
            end
        end

        if module.limitation_blacklist ~= nil then
            for _, recipe in ipairs(module.limitation_blacklist) do
                if recipe == source_recipe then
                    table.insert(module.limitation_blacklist, target_recipe)
                    break
                end
            end
        end
    end
end

local function scale_recipe(recipe, scale)
    if recipe["normal"] ~= nil or recipe["expensive"] ~= nil then
        if type(recipe["normal"]) == "table" then
            scale_recipe(recipe["normal"], scale)
        end
    
        if type(recipe["expensive"]) == "table" then
            scale_recipe(recipe["expensive"], scale)
        end
    else
        for idx, ispec in pairs(recipe["ingredients"]) do
            -- Ingredient prototypes exist in two flavours: array-like and map-like.
            if #ispec > 1 then
                recipe["ingredients"][idx] = {
                    ispec[1],
                    ispec[2] * scale
                }
            else
                recipe["ingredients"][idx]["amount"] = ispec["amount"] * scale
                if recipe["ingredients"][idx]["catalyst_amount"] ~= nil then
                    recipe["ingredients"][idx]["catalyst_amount"] = ispec["catalyst_amount"] * scale
                end
            end
        end
        
        if recipe["result"] ~= nil then
            recipe["result_count"] = (recipe["result_count"] or 1) * scale
        end

        if recipe["results"] ~= nil then
            for idx, rspec in pairs(recipe["results"]) do
                if rspec["amount"] ~= nil then
                    recipe["results"][idx]["amount"] = rspec["amount"] * scale
                else -- Contains a result with probability
                    recipe["results"][idx]["amount_min"] = rspec["amount_min"] * scale
                    recipe["results"][idx]["amount_max"] = rspec["amount_max"] * scale
                end
            end
        end
    end
end

local function generate_arc_smelting_recipe(original_recipe)
    if original_recipe["category"] ~= "smelting" then
        return
    end

    recipe = utils_table.deep_copy(original_recipe)

    recipe["name"] = "arc-" .. original_recipe["name"]
    recipe["category"] = "arc-smelting"
    --Enable all recipes, since I do not know how to enable it after the specific research has been activated (like when enriched ores tech from Krastorio is unlocked)
    if type(recipe["normal"]) == "table" then
        recipe["normal"]["enabled"] = true
    end
    if type(recipe["expensive"]) == "table" then
        recipe["expensive"]["enabled"] = true
    end
    recipe["enabled"] = true 

    local scaling_factor = 10
    scale_recipe(recipe, scaling_factor)

    data:extend({recipe})
    mimic_recipe_module_limitations(original_recipe["name"], recipe["name"])
end


-- Generate smelting recipes
if furnace_crafting_category == "arc-smelting" then
    for _, recipe in pairs(data.raw["recipe"]) do
        if recipe["category"] == "smelting" then
            generate_arc_smelting_recipe(recipe)
        end
    end
end

local function copy_recipe_data(src, dst, scale)
    if src["normal"] ~= nil or src["expensive"] ~= nil then
        if type(src["normal"]) == "table" then
            dst["normal"] = {}
            copy_recipe_data(src["normal"], dst["normal"], scale)
        else
            dst["normal"] = src["normal"]
        end
    
        if type(src["expensive"]) == "table" then
            dst["expensive"] = {}
            copy_recipe_data(src["expensive"], dst["expensive"], scale)
        else
            dst["expensive"] = src["expensive"]
        end
    else
        dst["ingredients"] = {}
        for idx, ispec in pairs(src["ingredients"]) do
            dst["ingredients"][idx] = {
                ispec[1],
                ispec[2] * scale
            }
        end

        if src["result"] ~= nil then
            dst["result"] = src["result"]
            dst["result_count"] = (src["result_count"] or 1) * scale
        end

        if src["results"] ~= nil then
            dst["results"] = {}
            for idx, rspec in pairs(src["results"]) do
                dst["results"][idx] = {
                    ["type"] = rspec["type"],
                    ["name"] = rspec["name"],
                    ["amount"] = rspec["amount"] * scale,
                    ["temperture"] = rspec["temperature"]
                }
            end
        end
    end
end


local function generate_arc_smelting_recipe(original_recipe)
    if original_recipe["category"] ~= "smelting" then
        return
    end

    recipe = {
        type = "recipe",
        name = "arc-" .. original_recipe["name"],
        category = "arc-smelting",
        energy_required = (original_recipe["energy_required"] or 0.5) * 2
    }

    copy_recipe_data(original_recipe, recipe, 10)

    data:extend({recipe})
end


-- Generate smelting recipes
for _, recipe in pairs(data.raw["recipe"]) do
    if recipe["category"] == "smelting" then
        generate_arc_smelting_recipe(recipe)
    end
end

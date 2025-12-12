if not AlloySmelting then

  AlloySmelting = {
	brick_kiln_categories = {"kiln-smelting", "organic-or-kiln-smelting"},
	electric_kiln_categories = {"kiln-smelting", "organic-or-kiln-smelting", "kiln-smelting-or-crafting", "electric-kiln-smelting"},
  }
  
  function AlloySmelting.smelt_in_kiln(recipe_name, catalyst_ingredient, recipe_scale, recipe_category)
    local recipe = data.raw.recipe[recipe_name]
    if not recipe then return end

    -- update 
    recipe.category = recipe_category or "kiln-smelting"
    recipe.auto_recycle = false

    AlloySmelting.add_catalyst(recipe_name, catalyst_ingredient, recipe_scale)
  end

  function AlloySmelting.add_catalyst(recipe_name, catalyst_ingredient, recipe_scale)
    local recipe = data.raw.recipe[recipe_name]
    if not recipe then return end

    if recipe_scale then
      recipe.energy_required = recipe_scale * (recipe.energy_required or 0.5)
      for _,ingredient in pairs(recipe.ingredients) do
        ingredient.amount = recipe_scale * ingredient.amount
      end
      for _,result in pairs(recipe.results) do
        if result.probability and recipe_scale * result.probability < 1 then
          result.probability = recipe_scale * result.probability
        else
          if result.amount then
            result.amount = recipe_scale * result.amount
          end
          if result.amount_min then
            result.amount_min = recipe_scale * result.amount_min
          end
          if result.amount_max then
            result.amount_max = recipe_scale * result.amount_max
          end
        end
      end
    end
    
    if catalyst_ingredient then
      table.insert(recipe.ingredients, catalyst_ingredient)
    end
  end
end

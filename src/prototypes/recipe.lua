if settings.startup["alloy-smelting-create-kilns"].value then
	data:extend({
	  {
		type = "recipe",
		name = "brick-kiln",
		enabled = false,
		ingredients = {
		  {type="item", name="stone-furnace", amount=1},
		  {type="item", name="stone-brick", amount=5}
		},
		results = {{type="item", name="brick-kiln", amount=1}}
	  },
	  {
		type = "recipe",
		name = "electric-kiln",
		enabled = false,
		energy_required = 5,
		ingredients = mods["aai-industry"] and {
		  {type="item", name="brick-kiln", amount=1},
		  {type="item", name="steel-plate", amount=10},
		  {type="item", name="advanced-circuit", amount=10},
		  {type="item", name="concrete", amount=10}
		} or {
		  {type="item", name="steel-plate", amount=20},
		  {type="item", name="advanced-circuit", amount=10},
		  {type="item", name="concrete", amount=20}
		},
		results = {{type="item", name="electric-kiln", amount=1}}
	  },
	})
end

if settings.startup["alloy-smelting-coke"].value then
  data:extend({
    {
      type = "recipe",
      name = "coke",
      category = "kiln-smelting",
      enabled = false,
      allow_productivity = true,
      auto_recycle = false,
      energy_required = 6.4,
      ingredients = {{type="item", name="coal", amount=1}},
      results = {{type="item", name="coke", amount=2}}
    }
  })
  if mods["crushing-industry"] and settings.startup["crushing-industry-coal"].value then
    data:extend({
      {
        type = "recipe",
        name = "coke-from-crushed-coal",
        localised_name = {"recipe-name.crushed-crafting", {"item-name.coke"}, {"item-name.coal"}},
        icons = {
          {icon="__crushing-industry__/graphics/icons/crushed-coal.png", shift={-12, -12}, scale=0.4},
          {icon="__alloy-smelting__/graphics/icons/coke.png", draw_background=true}
        },
        category = "kiln-smelting",
        order = "b[chemistry]-A[coke]-b[crushed]",
        enabled = false,
        allow_productivity = true,
        auto_recycle = false,
        hide_from_player_crafting = settings.startup["crushing-industry-hide-player-crafting"].value == true,
        energy_required = 6.4,
        ingredients = {{type="item", name="crushed-coal", amount=1}},
        results = {{type="item", name="coke", amount=2}}
      }
    })
  end
  if mods["space-age"] then
    data:extend({
      {
        type = "recipe",
        name = "coke-from-carbon",
        icons = {
          {icon="__space-age__/graphics/icons/carbon.png", shift={-12, -12}, scale=0.4},
          {icon="__alloy-smelting__/graphics/icons/coke.png", draw_background=true}
        },
        category = "kiln-smelting",
        order = "b[chemistry]-A[coke]-d[carbon]",
        enabled = false,
        allow_productivity = true,
        auto_recycle = false,
        energy_required = 6.4,
        ingredients = {{type="item", name="carbon", amount=1}},
        results = {{type="item", name="coke", amount=4}}
      }
    })
  end
end

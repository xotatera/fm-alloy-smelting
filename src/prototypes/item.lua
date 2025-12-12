local item_sounds = require("__base__.prototypes.item_sounds")
local item_tints = require("__base__.prototypes.item-tints")

if settings.startup["alloy-smelting-create-kilns"].value then
	data:extend({
	  {
		type = "item",
		name = "brick-kiln",
		icon = "__alloy-smelting__/graphics/icons/brick-kiln.png",
		subgroup = "smelting-machine",
		order = "b[kiln]-a[brick]",
		inventory_move_sound = item_sounds.brick_inventory_move,
		pick_sound = item_sounds.brick_inventory_pickup,
		drop_sound = item_sounds.brick_inventory_move,
		place_result = "brick-kiln",
		stack_size = 50,
		weight = 20*kg
	  },
	  {
		type = "item",
		name = "electric-kiln",
		icon = "__alloy-smelting__/graphics/icons/electric-kiln.png",
		subgroup = "smelting-machine",
		order = "b[kiln]-b[electric]",
		inventory_move_sound = item_sounds.electric_large_inventory_move,
		pick_sound = item_sounds.electric_large_inventory_pickup,
		drop_sound = item_sounds.electric_large_inventory_move,
		place_result = "electric-kiln",
		stack_size = 50,
		weight = 20*kg
	  },
	})
end

data:extend({
  {
    type = "item",
    name = "coke",
    icon = "__alloy-smelting__/graphics/icons/coke.png",
    pictures = {
      {size=64, filename="__alloy-smelting__/graphics/icons/coke.png", scale=0.5, mipmap_count=4},
      {size=64, filename="__alloy-smelting__/graphics/icons/coke-1.png", scale=0.5, mipmap_count=4},
      {size=64, filename="__alloy-smelting__/graphics/icons/coke-2.png", scale=0.5, mipmap_count=4},
    },
    subgroup = "raw-material",
    order = "b[chemistry]-A[coke]",
    hidden = not settings.startup["alloy-smelting-coke"].value,
    fuel_category = "chemical",
    fuel_value = settings.startup["alloy-smelting-coke-fuel-value"].value or "1.6MJ",
    fuel_emissions_multiplier = 1.5,
    inventory_move_sound = item_sounds.solid_fuel_inventory_move,
    pick_sound = item_sounds.solid_fuel_inventory_pickup,
    drop_sound = item_sounds.solid_fuel_inventory_move,
    random_tint_color = item_tints.yellowing_coal,
    stack_size = 50,
    weight = 2*kg
  }
})

data:extend({
	{
		type = "item",
		name = "wcu-proxy-kilns",
		icons = {
			{icon="__alloy-smelting__/graphics/icons/brick-kiln.png", shift={-4,-4}, scale=0.4},
			{icon="__alloy-smelting__/graphics/icons/electric-kiln.png", shift={4,4}, scale=0.4}
		},
		hidden = true,
		stack_size = 1
	}
})

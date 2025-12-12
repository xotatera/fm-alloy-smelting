if settings.startup["alloy-smelting-create-kilns"].value then return end

local stone_furnace = data.raw.furnace["stone-furnace"]
stone_furnace.type = "assembling-machine"
data.raw.furnace["stone-furnace"] = nil

local steel_furnace = data.raw.furnace["steel-furnace"]
steel_furnace.type = "assembling-machine"
data.raw.furnace["steel-furnace"] = nil

local electric_furnace = data.raw.furnace["electric-furnace"]
electric_furnace.type = "assembling-machine"
data.raw.furnace["electric-furnace"] = nil

for i=1,#AlloySmelting.brick_kiln_categories do
	table.insert(stone_furnace.crafting_categories, AlloySmelting.brick_kiln_categories[i])
	table.insert(steel_furnace.crafting_categories, AlloySmelting.brick_kiln_categories[i])	
end

for i=1,#AlloySmelting.electric_kiln_categories do
	table.insert(electric_furnace.crafting_categories, AlloySmelting.electric_kiln_categories[i])
end
electric_furnace.fluid_boxes = AlloySmelting.electric_kiln_fluid_boxes
electric_furnace.fluid_boxes_off_when_no_fluid_recipe = true

-- make the selector box look nicer
data.raw.recipe["stone-brick"].subgroup = "raw-material"

data:extend({stone_furnace, steel_furnace, electric_furnace})
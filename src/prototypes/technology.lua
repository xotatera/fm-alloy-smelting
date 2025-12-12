local kiln_smelting_effects = nil
if settings.startup["alloy-smelting-create-kilns"].value then
	kiln_smelting_effects = {
		{type="unlock-recipe", recipe="brick-kiln"}
    }
end

data:extend({
  {
    type = "technology",
    name = "kiln-smelting",
    icon = "__alloy-smelting__/graphics/technology/kiln-smelting.png",
    icon_size = 256,
    effects = kiln_smelting_effects,
    research_trigger = {
      type = "craft-item",
      item = "stone-brick",
      count = 10
    },
  }
})

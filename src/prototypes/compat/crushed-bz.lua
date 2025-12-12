if mods["crushing-industry"] and settings.startup["crushing-industry-ore"].value then
  if mods["bzlead"] and settings.startup["alloy-smelting-coke"].value then
    AlloySmelting.smelt_in_kiln("crushed-lead-smelting", {type="item", name="coke", amount=1}, 2.5)
  end

  if mods["bztitanium"] and settings.startup["alloy-smelting-coke"].value then
    if data.raw.recipe["crushed-titanium-smelting"] then
      AlloySmelting.smelt_in_kiln("crushed-titanium-smelting", {type="item", name="coke", amount=2})
    end
  end
end

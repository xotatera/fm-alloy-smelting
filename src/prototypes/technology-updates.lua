local ftech = require("__fdsl__.lib.technology")

-------------------------------------------------------------------------- Coke

-- needs to find ALL unlocks? that or technology needs to be done in updates
local function find_unlock_tech(recipe_name)
  for _,tech in pairs(data.raw.technology) do
    if not tech.hidden then
      for _,effect in pairs(tech.effects or {}) do
        if effect.type == "unlock-recipe" and effect.recipe == recipe_name then
          return tech
        end
      end
    end
  end
  return nil
end

if settings.startup["alloy-smelting-coke"].value then
  ftech.add_unlock("kiln-smelting", "coke")
  ftech.add_prereq("steel-processing", "kiln-smelting")

  if mods["crushing-industry"] and settings.startup["crushing-industry-coal"].value then
    local tech = find_unlock_tech("crushed-coal")
    if tech then
      ftech.add_unlock(tech.name, "coke-from-crushed-coal")
    end
  end

  if mods["space-age"] then
    local carbon_tech = find_unlock_tech("carbon")
    if carbon_tech then
      ftech.add_unlock(carbon_tech.name, "coke-from-carbon")
    end
    local carbonic_tech = find_unlock_tech("carbonic-asteroid-crushing")
    if carbonic_tech and carbonic_tech ~= carbon_tech then
      ftech.add_unlock(carbonic_tech.name, "coke-from-carbon")
    end
  end
end

-------------------------------------------------------------------------- Kilns
if settings.startup["alloy-smelting-create-kilns"].value then
	ftech.add_unlock("advanced-material-processing-2", "electric-kiln")
end
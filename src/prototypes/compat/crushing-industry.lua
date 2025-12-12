local frep = require("__fdsl__.lib.recipe")
local ftech = require("__fdsl__.lib.technology")

if mods["crushing-industry"] then
  if not mods["aai-industry"] then
    ftech.add_unlock("kiln-smelting", "burner-crusher")
    ftech.add_unlock("kiln-smelting", "sand")

    if settings.startup["crushing-industry-glass"].value then
      ftech.add_prereq("automation-science-pack", "kiln-smelting")
    end
  end
end

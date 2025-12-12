for _,force in pairs(game.forces) do
  local technologies = force.technologies
  local recipes = force.recipes
  local mods = script.active_mods

  if technologies["advanced-material-processing-2"].researched then
	if recipes["electric-kiln"] then
		recipes["electric-kiln"].enabled = true
	end
  end
end

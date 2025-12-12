local function register_with_resource_registry()
  if not (remote.interfaces["resource_registry"] and remote.interfaces["resource_registry"]["register"]) then
    return
  end

  local function register(type, name)
    remote.call("resource_registry", "register", type, name)
  end

  register("recipe_category", "alloying", {
    "kiln-smelting",
    "organic-or-kiln-smelting",
    "kiln-smelting-or-crafting",
    "electric-kiln-smelting"
  })

  if settings.startup["alloy-smelting-coke"].value then
    register("item", "coke")
  end

  if settings.startup["alloy-smelting-create-kilns"].value then
    register("furnace", "brick-kiln")
    register("furnace", "electric-kiln")
  end
end

script.on_load(register_with_resource_registry)
script.on_init(register_with_resource_registry)


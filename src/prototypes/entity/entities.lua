local function assemblerpipepicturesfrozen()
  return mods["space-age"] and {
    north = {
      filename = "__space-age__/graphics/entity/frozen/assembling-machine/assembling-machine-pipe-N-frozen.png",
      priority = "extra-high",
      width = 71,
      height = 38,
      shift = util.by_pixel(2.25, 13.5),
      scale = 0.5
    },
    east = {
      filename = "__space-age__/graphics/entity/frozen/assembling-machine/assembling-machine-pipe-E-frozen.png",
      priority = "extra-high",
      width = 42,
      height = 76,
      shift = util.by_pixel(-24.5, 1),
      scale = 0.5
    },
    south = {
      filename = "__space-age__/graphics/entity/frozen/assembling-machine/assembling-machine-pipe-S-frozen.png",
      priority = "extra-high",
      width = 88,
      height = 61,
      shift = util.by_pixel(0, -31.25),
      scale = 0.5
    },
    west = {
      filename = "__space-age__/graphics/entity/frozen/assembling-machine/assembling-machine-pipe-W-frozen.png",
      priority = "extra-high",
      width = 39,
      height = 73,
      shift = util.by_pixel(25.75, 1.25),
      scale = 0.5
    }
  } or nil
end

AlloySmelting.electric_kiln_fluid_boxes = {
  {
	production_type = "input",
	pipe_picture = assembler3pipepictures(),
	pipe_picture_frozen = assemblerpipepicturesfrozen(),
	pipe_covers = pipecoverspictures(),
	always_draw_covers = false,
	volume = 1000,
	pipe_connections = {{flow_direction="input",direction=defines.direction.south, position={-1, 1}}}
  },
  {
	production_type = "input",
	pipe_picture = assembler3pipepictures(),
	pipe_picture_frozen = assemblerpipepicturesfrozen(),
	pipe_covers = pipecoverspictures(),
	always_draw_covers = false,
	volume = 1000,
	pipe_connections = {{flow_direction="input",direction=defines.direction.south, position={1, 1}}}
  },
  {
	production_type = "output",
	pipe_picture = assembler3pipepictures(),
	pipe_picture_frozen = assemblerpipepicturesfrozen(),
	pipe_covers = pipecoverspictures(),
	always_draw_covers = false,
	volume = 100,
	pipe_connections = {{flow_direction="output", direction=defines.direction.north, position={-1, -1}}}
  },
  {
	production_type = "output",
	pipe_picture = assembler3pipepictures(),
	pipe_picture_frozen = assemblerpipepicturesfrozen(),
	pipe_covers = pipecoverspictures(),
	always_draw_covers = false,
	volume = 100,
	pipe_connections = {{flow_direction="output", direction=defines.direction.north, position={1, -1}}}
  }
}

if (not settings.startup["alloy-smelting-create-kilns"].value) then return end

local hit_effects = require("__base__.prototypes.entity.hit-effects")
local sounds = require("__base__.prototypes.entity.sounds")

data:extend({
  {
    type = "assembling-machine",
    name = "brick-kiln",
    icon = "__alloy-smelting__/graphics/icons/brick-kiln.png",
    flags = {"placeable-neutral", "placeable-player", "player-creation"},
    minable = {mining_time = 0.2, result = "brick-kiln"},
    max_health = 250,
    corpse = "brick-kiln-remnants",
    dying_explosion = "stone-furnace-explosion",
    resistances = {
      {type="fire", percent=90},
      {type="explosion", percent=30},
      {type="impact", percent=30}
    },
    surface_conditions = data.raw.furnace["stone-furnace"].surface_conditions,
    collision_box = {{-0.7, -0.7}, {0.7, 0.7}},
    selection_box = {{-1.0, -1.0}, {1.0, 1.0}},
    damaged_trigger_effect = hit_effects.rock(),
    circuit_wire_max_distance = furnace_circuit_wire_max_distance,
    circuit_connector = circuit_connector_definitions["stone-furnace"],
    crafting_categories = AlloySmelting.brick_kiln_categories,
    crafting_speed = 1,
    energy_usage = "90kW",
    energy_source = {
      type = "burner",
      fuel_categories = {"chemical"},
      effectivity = 1,
      fuel_inventory_size = 1,
      emissions_per_minute = {pollution=2},
      light_flicker = {
        color = {0,0,0},
        minimum_intensity = 0.6,
        maximum_intensity = 0.95
      },
      smoke = {
        {
          name = "smoke",
          deviation = {0.1, 0.1},
          frequency = 3,
          position = {0.0, -0.8},
          starting_vertical_speed = 0.08,
          starting_frame_deviation = 60
        }
      }
    },
    repair_sound = sounds.manual_repair,
    mined_sound = sounds.deconstruct_bricks(0.8),
    open_sound = sounds.machine_open,
    close_sound = sounds.machine_close,
    vehicle_impact_sound = sounds.car_stone_impact,
    allowed_effects = {"speed", "consumption", "pollution"},
    effect_receiver = {uses_module_effects = false, uses_beacon_effects = false, uses_surface_effects = true},
    impact_category = "stone",
    icon_draw_specification = {scale = 0.66, shift = {0, -0.1}},
    working_sound = {
      sound = {
        filename = "__alloy-smelting__/sound/brick-kiln.ogg",
        volume = 0.6,
        modifiers = {
          volume_multiplier("main-menu", 1.5),
          volume_multiplier("tips-and-tricks", 1.4)
        }
      },
      audible_distance_modifier = 0.4,
      fade_in_ticks = 4,
      fade_out_ticks = 20
    },
    graphics_set = {
      animation = {
        layers = {
          {
            filename = "__alloy-smelting__/graphics/entity/brick-kiln/brick-kiln.png",
            priority = "extra-high",
            width = 151,
            height = 146,
            frame_count = 1,
            shift = util.by_pixel(-0.25, 6),
            scale = 0.5
          },
          {
            filename = "__base__/graphics/entity/stone-furnace/stone-furnace-shadow.png",
            priority = "extra-high",
            width = 164,
            height = 74,
            frame_count = 1,
            draw_as_shadow = true,
            force_hr_shadow = true,
            shift = util.by_pixel(14.5, 13),
            scale = 0.5
          }
        }
      },
      working_visualisations = data.raw.furnace["stone-furnace"].graphics_set.working_visualisations,
      water_reflection = data.raw.furnace["stone-furnace"].graphics_set.water_reflection
    },
  },
  {
    type = "assembling-machine",
    name = "electric-kiln",
    icon = "__alloy-smelting__/graphics/icons/electric-kiln.png",
    flags = {"placeable-neutral", "placeable-player", "player-creation"},
    minable = {mining_time = 0.2, result = "electric-kiln"},
    max_health = 350,
    corpse = "electric-kiln-remnants",
    dying_explosion = "electric-furnace-explosion",
    resistances = {
      {type="fire", percent=90},
      {type="explosion", percent=30},
      {type="impact", percent=30}
    },
    collision_box = {{-1.2, -1.2}, {1.2, 1.2}},
    selection_box = {{-1.5, -1.5}, {1.5, 1.5}},
    damaged_trigger_effect = hit_effects.entity(),
    circuit_wire_max_distance = furnace_circuit_wire_max_distance,
    circuit_connector = circuit_connector_definitions["electric-furnace"],
    module_slots = 2,
    icon_draw_specification = {shift = {0, -0.1}},
    icons_positioning = {
      {inventory_index = defines.inventory.furnace_modules, shift = {0, 0.8}}
    },
    allowed_effects = {"consumption", "speed", "productivity", "pollution", "quality"},
    crafting_categories = AlloySmelting.electric_kiln_categories,
    crafting_speed = 2,
    energy_usage = "180kW",
    energy_source = {
      type = "electric",
      usage_priority = "secondary-input",
      emissions_per_minute = {pollution=1}
    },
    fluid_boxes = AlloySmelting.electric_kiln_fluid_boxes,
    fluid_boxes_off_when_no_fluid_recipe = true,
    vehicle_impact_sound = sounds.generic_impact,
    open_sound = sounds.machine_open,
    close_sound = sounds.machine_close,
    working_sound = {
      sound = {
        filename = "__alloy-smelting__/sound/electric-kiln.ogg",
        volume = 0.85,
        modifiers = volume_multiplier("main-menu", 4.2),
        advanced_volume_control = {attenuation="exponential"}
      },
      max_sounds_per_type = 4,
      audible_distance_modifier = 0.7,
      fade_in_ticks = 4,
      fade_out_ticks = 20
    },
    graphics_set = {
      animation = {
        layers = {
          {
            filename = "__alloy-smelting__/graphics/entity/electric-kiln/electric-kiln.png",
            priority = "high",
            width = 239,
            height = 219,
            frame_count = 1,
            shift = util.by_pixel(0.75, 5.75),
            scale = 0.5
          },
          {
            filename = "__base__/graphics/entity/electric-furnace/electric-furnace-shadow.png",
            priority = "high",
            width = 227,
            height = 171,
            frame_count = 1,
            draw_as_shadow = true,
            shift = util.by_pixel(11.25, 7.75),
            scale = 0.5
          }
        }
      },
      working_visualisations = data.raw.furnace["electric-furnace"].graphics_set.working_visualisations,
      water_reflection = data.raw.furnace["electric-furnace"].graphics_set.water_reflection
    }
  },
})

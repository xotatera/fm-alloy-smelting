if (not settings.startup["alloy-smelting-create-kilns"].value) then return end

data:extend({
  {
    type = "corpse",
    name = "brick-kiln-remnants",
    icon = "__alloy-smelting__/graphics/icons/brick-kiln.png",
    icon_size = 64, icon_mipmaps = 4,
    flags = {"placeable-neutral", "building-direction-8-way", "not-on-map"},
    hidden_in_factoriopedia = true,
    subgroup = "smelting-machine-remnants",
    order = "a-a-a",
    selection_box = {{-1, -1}, {1, 1}},
    tile_width = 2,
    tile_height = 2,
    selectable_in_game = false,
    time_before_removed = 60 * 60 * 15, -- 15 minutes
    expires = false,
    final_render_layer = "remnants",
    remove_on_tile_placement = false,
    animation = make_rotated_animation_variations_from_sheet(1, {
      filename = "__alloy-smelting__/graphics/entity/brick-kiln/remnants/brick-kiln-remnants.png",
      line_length = 1,
      width = 152,
      height = 130,
      frame_count = 1,
      direction_count = 1,
      shift = util.by_pixel(0, 9.5),
      scale = 0.5
    })
  },
  {
    type = "corpse",
    name = "electric-kiln-remnants",
    icon = "__alloy-smelting__/graphics/icons/electric-kiln.png",
    icon_size = 64, icon_mipmaps = 4,
    flags = {"placeable-neutral", "building-direction-8-way", "not-on-map"},
    hidden_in_factoriopedia = true,
    subgroup = "smelting-machine-remnants",
    order = "a-a-a",
    selection_box = {{-1.5, -1.5}, {1.5, 1.5}},
    tile_width = 3,
    tile_height = 3,
    selectable_in_game = false,
    time_before_removed = 60 * 60 * 15, -- 15 minutes
    final_render_layer = "remnants",
    remove_on_tile_placement = false,
    animation = {
      filename = "__alloy-smelting__/graphics/entity/electric-kiln/remnants/electric-kiln-remnants.png",
      line_length = 1,
      width = 454,
      height = 448,
      frame_count = 1,
      direction_count = 1,
      shift = util.by_pixel(-3.25, 7.25),
      scale = 0.5
    }
  }
})

local controls = require "controls"
local utils = require "utils"

local updater = require "selection_menu.updater"
local loader = require "selection_menu.loader"
local draw = require "selection_menu.draw"

local selection_menu = {}
selection_menu.controls = controls.get_selection_menu_controls()
selection_menu.key_down = false

function selection_menu.load(items, on_select_function)
    selection_menu.border_size = 5
    selection_menu.items = {}
    selection_menu.selected_item = nil
    selection_menu.y_coordinates = 400 * ScreenHeightScalingFactor
    selection_menu.on_select_function = on_select_function

    loader.add_items(selection_menu, items)
    selection_menu.item_count = utils.table_size(selection_menu.items)
end

function selection_menu.update(dt)
    updater.check_selected_item(selection_menu)
end

function selection_menu.draw()
    draw.draw_selection_menu(selection_menu)
end

function love.keyreleased()
    selection_menu.key_down = false
end

return selection_menu
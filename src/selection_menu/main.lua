
local updater = require "selection_menu.updater"
local loader = require "selection_menu.loader"
local draw = require "selection_menu.draw"
local panel_ids = require "panel_manager.panel_ids"
local controls = require "controls"
local utils = require "utils"
local selection_menu = {}

selection_menu.panel_id = panel_ids.selection_menu
selection_menu.controls = controls[selection_menu.panel_id]

function selection_menu.load(items)
    selection_menu.border_size = 5
    selection_menu.items = {}
    selection_menu.selected_item = nil
    selection_menu.key_down = false
    selection_menu.y_coordinates = 400 * ScreenHeightScalingFactor

    loader.add_items(selection_menu, items)
    selection_menu.item_count = utils.table_size(selection_menu.items)
end

function selection_menu.update(dt)
    updater.check_for_change_in_selected_item(selection_menu)
end

function selection_menu.draw()
    draw.draw_selection_menu(selection_menu)
end

function love.keyreleased()
    selection_menu.key_down = false
end

return selection_menu
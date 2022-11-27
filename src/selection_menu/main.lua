local controls = require "controls"
local utils = require "utils"
local fonts = require "asset_handlers.fonts.fonts"

local updater = require "selection_menu.updater"
local loader = require "selection_menu.loader"
local draw = require "selection_menu.draw"

local selection_menu_class = {}

function selection_menu_class.construct(items, on_select_function)
    local selection_menu = {}

    selection_menu.controls = controls.get_selection_menu_controls()
    selection_menu.fonts = fonts.construct()
    selection_menu.key_down = true
    selection_menu.border_size = 10
    selection_menu.items = {}
    selection_menu.selected_item = nil
    selection_menu.y_coordinates = 400 * ScreenHeightScalingFactor
    selection_menu.on_select_function = on_select_function
    loader.add_items(selection_menu, items)
    selection_menu.item_count = utils.table_size(selection_menu.items)

    function selection_menu.update()
        updater.check_selected_item(selection_menu)
    end

    function selection_menu.draw()
        draw.draw_selection_menu(selection_menu)
    end

    return selection_menu
end

return selection_menu_class
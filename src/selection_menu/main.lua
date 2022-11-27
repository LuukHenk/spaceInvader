local controls = require "controls"
local utils = require "utils"
local fonts = require "asset_handlers.fonts.fonts"

local item_constructor = require "selection_menu.item_constructor"
local updater = require "selection_menu.updater"
local loader = require "selection_menu.loader"
local draw = require "selection_menu.draw"

local selection_menu_class = {}

function selection_menu_class.construct(items, on_select_function)
    local selection_menu = {}

    function selection_menu.__init__()
        selection_menu.controls = controls.get_selection_menu_controls()
        selection_menu.fonts = fonts.construct()
        selection_menu.item_constructor = item_constructor.construct()
        selection_menu.key_down = true

        selection_menu.y_coordinate = 400 * ScreenHeightScalingFactor
        selection_menu.x_coordinate = love.graphics.getWidth() / 2
        selection_menu.items = selection_menu.__construct_items()
        selection_menu.selected_item = selection_menu.item_constructor.get_default_selection()
        selection_menu.on_select_function = on_select_function
        selection_menu.item_count = utils.table_size(selection_menu.items)
    end

    function selection_menu.update()
        updater.check_selected_item(selection_menu)
    end

    function selection_menu.draw()
        draw.draw_selection_menu(selection_menu)
    end

    function selection_menu.__construct_items()
        return selection_menu.item_constructor.create_centered_selection_menu_items(
            items, selection_menu.x_coordinate, selection_menu.y_coordinate
        )
    end

    selection_menu.__init__()
    return selection_menu
end

return selection_menu_class
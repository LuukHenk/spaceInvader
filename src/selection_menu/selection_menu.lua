
local utils = require "utils"
local fonts = require "asset_handlers.fonts.fonts"

local item_constructor = require "selection_menu.item_constructor"
local item_selection_handler = require "selection_menu.item_selection_handler"
local draw = require "selection_menu.draw"

local selection_menu_class = {}

function selection_menu_class.construct(items, on_select_function)
    local selection_menu = {}

    function selection_menu.__init__()
        selection_menu.fonts = fonts.construct()
        selection_menu.item_constructor = item_constructor.construct()
        selection_menu.y_coordinate = 400 * ScreenHeightScalingFactor
        selection_menu.x_coordinate = love.graphics.getWidth() / 2
        selection_menu.items = selection_menu.__construct_items()
        selection_menu.item_selection_handler = item_selection_handler.construct(
            selection_menu.item_constructor.get_default_selection(),
            on_select_function,
            selection_menu.items
        )
    end

    function selection_menu.update()
        selection_menu.item_selection_handler.update_current_selected_item()
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
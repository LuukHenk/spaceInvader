local controls = require "controls"
local utils = require "utils"
local fonts = require "asset_handlers.fonts.fonts"

local item_constructor = require "selection_menu.item_constructor"
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
        selection_menu.__check_selected_item()
        print(love.mouse.getPosition( ))
    end

    function selection_menu.draw()
        draw.draw_selection_menu(selection_menu)
    end

    function selection_menu.__check_selected_item()
        if (
            selection_menu.item_count < 2
            or not selection_menu.selected_item
        ) then
            return
        end

        if love.keyboard.isDown(unpack(selection_menu.controls.all)) then
            if not selection_menu.key_down then
                selection_menu.__handle_keypress()
            end
            selection_menu.key_down = true
        else
            selection_menu.key_down = false
        end
    end

    function selection_menu.__handle_keypress()
        if love.keyboard.isDown(unpack(selection_menu.controls.select)) then
            selection_menu.__on_select()
        elseif love.keyboard.isDown(unpack(selection_menu.controls.move_down)) then
            selection_menu.__go_to_next_item()
        elseif love.keyboard.isDown(unpack(selection_menu.controls.move_up)) then
            selection_menu.__go_to_previous_item()
        end
    end

    function selection_menu.__go_to_next_item()
        if selection_menu.selected_item == selection_menu.item_count then
            selection_menu.selected_item = 1
        else
            selection_menu.selected_item = selection_menu.selected_item + 1
        end
        selection_menu.__update_selected_item()
    end

    function selection_menu.__go_to_previous_item()
        if selection_menu.selected_item == 1 then
            selection_menu.selected_item = selection_menu.item_count
        else
            selection_menu.selected_item = selection_menu.selected_item - 1
        end
        selection_menu.__update_selected_item()
    end

    function selection_menu.__on_select()
        for item_index, item in pairs(selection_menu.items) do
            if item_index == selection_menu.selected_item then
                selection_menu.__select_first_item()
                selection_menu.on_select_function(item.type)
            end
        end
    end

    function selection_menu.__update_selected_item()
        for item_index, item in pairs(selection_menu.items) do
            if item_index == selection_menu.selected_item then
                item.selected = true
            else
                item.selected = false
            end
        end
    end

    function selection_menu.__select_first_item()
        selection_menu.selected_item = 1
        selection_menu.__update_selected_item()
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
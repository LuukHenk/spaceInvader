local controls = require "controls"
local utils = require "utils"

local item_selection_handler_class = {}

function item_selection_handler_class.construct(default_selection, on_select_function, items)
    local item_selection_handler = {}

    function item_selection_handler.__init__()
        item_selection_handler.controls = controls.get_selection_menu_controls()
        item_selection_handler.selected_item = default_selection
        item_selection_handler.key_clicked = true
        item_selection_handler.mouse_clicked = true
        item_selection_handler.on_select_function = on_select_function
        item_selection_handler.items = items
        item_selection_handler.item_count = utils.table_size(items)
    end

    function item_selection_handler.update_current_selected_item()
        if item_selection_handler.item_count < 2 then return end
        item_selection_handler.__handle_mouse()
        item_selection_handler.__handle_keypress()
    end

    function item_selection_handler.__handle_mouse()
        local selected_item = item_selection_handler.__check_if_mouse_on_item()
        if not selected_item then return end
        item_selection_handler.selected_item = selected_item
        item_selection_handler.__update_selected_item()
        item_selection_handler.__check_for_mouse_click()
    end

    function item_selection_handler.__check_if_mouse_on_item()
        local mouse_x, mouse_y = love.mouse.getPosition()
        for item_index, item in pairs(item_selection_handler.items) do
            if ((
                item.coordinates.x <= mouse_x
                and item.coordinates.y <= mouse_y
                and item.coordinates.x + item.width >= mouse_x
                and item.coordinates.y + item.height >= mouse_y
            ) or (
                item.coordinates.x <= mouse_x
                and item.coordinates.y >= mouse_y
                and item.coordinates.x + item.width >= mouse_x
                and item.coordinates.y <= mouse_y
            ) or (
                item.coordinates.x >= mouse_x
                and item.coordinates.y <= mouse_y
                and item.coordinates.x <= mouse_x
                and item.coordinates.y + item.height >= mouse_y
            ) or (
                item.coordinates.x >= mouse_x
                and item.coordinates.y >= mouse_y
                and item.coordinates.x <= mouse_x
                and item.coordinates.y <= mouse_y
            )) then
                return item_index
            end
        end
        return nil
    end
    function item_selection_handler.__check_for_mouse_click()
        if love.mouse.isDown(controls.LEFT_MOUSE_BUTTON) then
            if not item_selection_handler.mouse_clicked then
                item_selection_handler.__on_select()
            end
            item_selection_handler.mouse_clicked = true
        else
            item_selection_handler.mouse_clicked = false
        end
    end

    function item_selection_handler.__handle_keypress()
        if item_selection_handler.__check_for_keypress() then
            if not item_selection_handler.key_clicked then
                item_selection_handler.__perform_action_on_keypress()
            end
            item_selection_handler.key_clicked = true
        else
            item_selection_handler.key_clicked = false
        end
    end

    function item_selection_handler.__check_for_keypress()
        if love.keyboard.isDown(unpack(item_selection_handler.controls.all)) then
            return true
        end
        return false
    end

    function item_selection_handler.__perform_action_on_keypress()
        if love.keyboard.isDown(unpack(item_selection_handler.controls.select)) then
            item_selection_handler.__on_select()
        elseif love.keyboard.isDown(unpack(item_selection_handler.controls.move_down)) then
            item_selection_handler.__go_to_next_item()
        elseif love.keyboard.isDown(unpack(item_selection_handler.controls.move_up)) then
            item_selection_handler.__go_to_previous_item()
        end
    end

    function item_selection_handler.__go_to_next_item()
        if item_selection_handler.selected_item == item_selection_handler.item_count then
            item_selection_handler.selected_item = 1
        else
            item_selection_handler.selected_item = item_selection_handler.selected_item + 1
        end
        item_selection_handler.__update_selected_item()
    end

    function item_selection_handler.__go_to_previous_item()
        if item_selection_handler.selected_item == 1 then
            item_selection_handler.selected_item = item_selection_handler.item_count
        else
            item_selection_handler.selected_item = item_selection_handler.selected_item - 1
        end
        item_selection_handler.__update_selected_item()
    end

    function item_selection_handler.__on_select()
        for item_index, item in pairs(item_selection_handler.items) do
            if item_index == item_selection_handler.selected_item then
                item_selection_handler.__select_first_item()
                item_selection_handler.on_select_function(item.type)
            end
        end
    end

    function item_selection_handler.__select_first_item()
        item_selection_handler.selected_item = 1
        item_selection_handler.__update_selected_item()
    end

    function item_selection_handler.__update_selected_item()
        for item_index, item in pairs(item_selection_handler.items) do
            if item_index == item_selection_handler.selected_item then
                item.selected = true
            else
                item.selected = false
            end
        end
    end

    item_selection_handler.__init__()
    return item_selection_handler
end

return item_selection_handler_class
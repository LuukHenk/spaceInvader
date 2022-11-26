


local updater = {}

function updater.check_selected_item(selection_menu)
    if (
        selection_menu.item_count < 2
        or not selection_menu.selected_item
    ) then
        return
    end

    if love.keyboard.isDown(selection_menu.controls.all) then
        if not selection_menu.key_down then
            updater.__handle_keypress(selection_menu)
        end
        selection_menu.key_down = true
    else
        selection_menu.key_down = false
    end
end

function updater.__handle_keypress(selection_menu)
    if love.keyboard.isDown(selection_menu.controls.select) then
        updater.on_select(selection_menu)
    elseif love.keyboard.isDown(selection_menu.controls.move_down) then
        updater.go_to_next_item(selection_menu)
    elseif love.keyboard.isDown(selection_menu.controls.move_up) then
        updater.go_to_previous_item(selection_menu)
    end
end

function updater.go_to_next_item(selection_menu)
    if selection_menu.selected_item == selection_menu.item_count then
        selection_menu.selected_item = 1
    else
        selection_menu.selected_item = selection_menu.selected_item + 1
    end
    updater.update_selected_item(selection_menu)
end

function updater.go_to_previous_item(selection_menu)
    if selection_menu.selected_item == 1 then 
        selection_menu.selected_item = selection_menu.item_count
    else
        selection_menu.selected_item = selection_menu.selected_item - 1
    end
    updater.update_selected_item(selection_menu)
end

function updater.on_select(selection_menu)
    for item_index, item in pairs(selection_menu.items) do
        if item_index == selection_menu.selected_item then
            updater.__select_first_item(selection_menu)
            selection_menu.on_select_function(item.type)
        end
    end
end

function updater.update_selected_item(selection_menu)
    for item_index, item in pairs(selection_menu.items) do
        if item_index == selection_menu.selected_item then
            item.selected = true
        else
            item.selected = false
        end
    end
end

function updater.__select_first_item(selection_menu)
    selection_menu.selected_item = 1
    updater.update_selected_item(selection_menu)
end

return updater
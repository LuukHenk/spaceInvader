


local updater = {}

function updater.check_for_change_in_selected_item(selection_menu)
    if (
        selection_menu.item_count < 2 
        or not selection_menu.selected_item
    ) then
        return
    end

    if not selection_menu.key_down then
        if love.keyboard.isDown(selection_menu.controls.move_down) then
            selection_menu.key_down = true
            updater.select_next_item(selection_menu)
        elseif love.keyboard.isDown(selection_menu.controls.move_up) then
            selection_menu.key_down = true
            updater.select_previous_item(selection_menu)
        end
    end
end

function updater.select_next_item(selection_menu)
    if selection_menu.selected_item == selection_menu.item_count then
        selection_menu.selected_item = 1
    else
        selection_menu.selected_item = selection_menu.selected_item + 1
    end
    updater.update_selected_item(selection_menu)
end

function updater.select_previous_item(selection_menu)
    if selection_menu.selected_item == 1 then 
        selection_menu.selected_item = selection_menu.item_count
    else
        selection_menu.selected_item = selection_menu.selected_item - 1
    end
    updater.update_selected_item(selection_menu)
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

return updater
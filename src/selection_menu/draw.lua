
local selection_menu_draw = {}

function selection_menu_draw.draw_selection_menu(selection_menu)
    selection_menu.fonts.set_selection_menu_font()
    for _, item in pairs(selection_menu.items) do
        if DEBUG then
            selection_menu_draw.draw_border(item)
        end
        selection_menu_draw.draw_text(item)
    end
    selection_menu.fonts.reset_font()
end

function selection_menu_draw.draw_border(item)
    love.graphics.setColor(0, 0, 0)
    love.graphics.rectangle(
        item.mode,
        item.coordinates.x,
        item.coordinates.y,
        item.width,
        item.height
    )    
end

function selection_menu_draw.draw_text(item)
    if item.selected then
        love.graphics.setColor(
            item.selected_color.red,
            item.selected_color.green,
            item.selected_color.blue,
            item.selected_color.alpha
        )
    else
        love.graphics.setColor(1, 1, 1)
    end
    love.graphics.print(
        item.type,
        item.coordinates.x + item.border.left,
        item.coordinates.y + item.border.top,
        0
    )
end

return selection_menu_draw

local selection_menu_draw = {}

function selection_menu_draw.draw_selection_menu(selection_menu)
    for _, item in pairs(selection_menu.items) do
        selection_menu_draw.draw_border(item)
        selection_menu_draw.draw_text(item)
    end
end

function selection_menu_draw.draw_border(item)
    if item.selected then
        love.graphics.setColor(
            item.selected_color.red,
            item.selected_color.green,
            item.selected_color.blue,
            item.selected_color.alpha
        )
    else
        love.graphics.setColor(0, 0, 0)
    end
    love.graphics.rectangle(
        item.mode,
        item.coordinates.x,
        item.coordinates.y,
        item.width,
        item.height
    )    
end

function selection_menu_draw.draw_text(item)
    love.graphics.setColor(
        item.color.red,
        item.color.green,
        item.color.blue,
        item.color.alpha
    )
    love.graphics.print(
        item.tag,
        item.coordinates.x + item.border.left,
        item.coordinates.y + item.border.top
    )
end

return selection_menu_draw
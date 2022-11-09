local draw = {}

local font = love.graphics.getFont()

function draw.draw_multiple_rectangles(objects)
    for _, object in pairs(objects) do
        draw.draw_rectangle(object)
    end
end

function draw.draw_rectangle(object)
    love.graphics.setColor(
        object.color.red,
        object.color.green,
        object.color.blue,
        object.color.alpha
    )
    love.graphics.rectangle(
        object.mode,
        object.coordinates.x,
        object.coordinates.y,
        object.width,
        object.height
    )
end

function draw.draw_panel_title(text)
    local scaling_factor = 5
    local x_coord = love.graphics.getWidth() * 0.5 - font:getWidth(text)*scaling_factor / 2
    local y_coord = love.graphics.getHeight() * 0.2 - font:getHeight() / 2
    love.graphics.setColor(1, 1, 1)
    love.graphics.print(text, x_coord, y_coord, 0, scaling_factor, scaling_factor)
end

function draw.draw_selection_menu(selection_menu, selected_item)
    local scaling_factor = 2
    local border = 20
    local y_start = love.graphics.getHeight() * 0.3

    for i, text in pairs(selection_menu) do 
        local text_width = font:getWidth(text) * scaling_factor
        local text_height = font:getHeight() * scaling_factor
        local x_coord = love.graphics.getWidth() * 0.5 - text_width / 2
        local y_coord = y_start + (text_height + border) * i
        if i == selected_item then
            love.graphics.setColor(1, 0, 0)
        else
            love.graphics.setColor(1, 1, 1)
        end
        love.graphics.print(text, x_coord, y_coord, 0, scaling_factor, scaling_factor)
    end
end

return draw

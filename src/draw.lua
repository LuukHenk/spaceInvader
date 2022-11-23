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

function draw.draw_background(image)
    love.graphics.setColor(1, 1, 1, 1)
    love.graphics.draw(image)
end

return draw

local basic_object = {}

-- Abstract class
function basic_object.construct(tag, x_coord, y_coord)
    local object = {}

    object.tag = tag
    object.mode = "fill"

    object.width = 0
    object.height = 0
    object.color = {}
    object.color.red = 0
    object.color.green = 0
    object.color.blue = 0
    object.color.alpha = 1

    object.coordinates = {}
    object.coordinates.x = x_coord
    object.coordinates.y = y_coord

    function object.resize(width, height)
        object.width = width * ScreenWidhtScalingFactor
        object.height = height * ScreenHeightScalingFactor
    end

    function object.set_color(red, green, blue, alpha)
        object.color.red = red
        object.color.green = green
        object.color.blue = blue
        object.color.alpha = alpha
    end

    return object
end

return basic_object
local base_object = {}

function base_object.construct(tag, x_coord, y_coord)
    local object = {}

    object.tag = tag
    object.mode = "fill"

    object.width = 0
    object.height = 0

    object.speed = 0

    object.color = {}
    object.color.red = 0
    object.color.green = 0
    object.color.blue = 0
    object.color.alpha = 1

    object.coordinates = {}
    object.coordinates.x = x_coord
    object.coordinates.y = y_coord

    object.bullet_speed = 0
    object.bullet_timeout = 0

    return object
end

return base_object
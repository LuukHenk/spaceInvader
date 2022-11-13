local bullet_object = require "game_objects.bullet"
local object_names = require "object_names"
local player_bullet_class = {}

function player_bullet_class.construct(object_type, x_coord, y_coord)
    local bullet = bullet_object.construct(
        object_names.player_bullet, object_type, x_coord, y_coord
    )

    bullet.set_color(1, 0, 0, 1)
    bullet.resize(2, 30)
    bullet.speed = 400

    function bullet.update(dt)
        bullet.move_up(dt)
    end

    return bullet
end

return player_bullet_class
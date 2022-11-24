local bullet_object = require "game_objects.bullet"
local game_object_names = require "game_objects.game_object_names"
local player_bullet_class = {}

function player_bullet_class.construct(object_type, x_coord, y_coord)
    local bullet = bullet_object.construct(
        game_object_names.player_bullet, object_type, x_coord, y_coord
    )

    bullet.set_color(1, 1, 1, 1)
    bullet.resize(8, 40)
    bullet.speed = 400

    function bullet.update(dt)
        bullet.move_up(dt)
    end

    return bullet
end

return player_bullet_class
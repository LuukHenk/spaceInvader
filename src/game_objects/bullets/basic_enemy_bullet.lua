local bullet_object = require "game_objects.bullet"
local object_names = require "object_names"
local basic_enemy_bullet_class = {}

function basic_enemy_bullet_class.construct(object_type, x_coord, y_coord)
    local bullet = bullet_object.construct(
        object_names.basic_enemy_bullet, object_type, x_coord, y_coord
    )

    bullet.set_color(0, 0.92, 1, 1)
    bullet.resize(2, 30)
    bullet.speed = 300

    function bullet.update(dt)
        bullet.move_down(dt)
    end

    return bullet
end

return basic_enemy_bullet_class
local bullet_object = require "game_objects.bullet"
local basic_enemy_bullet_class = {}

function basic_enemy_bullet_class.construct(object_type, x_coord, y_coord)
    local bullet = bullet_object.construct(object_type, x_coord, y_coord)

    bullet.set_color(0, 0.92, 1, 1)
    bullet.resize(10, 30)
    bullet.speed = 100

    function bullet.update(dt)
        bullet.move_down(dt)
    end

    return bullet
end

return basic_enemy_bullet_class
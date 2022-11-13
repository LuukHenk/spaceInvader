local game_object = require "game_objects.game_object"
local basic_enemy_bullet_class = {}

function basic_enemy_bullet_class.construct(tag, x_coord, y_coord)
    local bullet = game_object.construct(tag, x_coord, y_coord)

    bullet.set_color(0, 0.92, 1, 1)
    bullet.resize(10, 30)
    bullet.speed = 100

    function bullet.update(dt)
        bullet.move_down(dt)
    end

    return bullet
end

return basic_enemy_bullet_class
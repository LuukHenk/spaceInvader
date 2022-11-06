
local base_object = require "config.base_object"
local base_enemy = {}
local ENEMY_TAG = "enemy"


function base_enemy.construct(x_coord, y_coord)
    local enemy = base_object.construct(ENEMY_TAG, x_coord, y_coord)
    enemy.color.green = 1
    enemy.width = 10 * ScreenWidhtScalingFactor
    enemy.height = 10 * ScreenWidhtScalingFactor
    enemy.speed = 40

    function enemy.move(dt)
        local traveled_distance = enemy.speed * dt * ScreenHeightScalingFactor
        enemy.coordinates.y = enemy.coordinates.y + traveled_distance
    end

    return enemy
end


return base_enemy

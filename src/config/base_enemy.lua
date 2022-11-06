local base_object = require "config.base_shooting_object"
local base_enemy_bullet = require "config.bullets.base_enemy_bullet"
local base_enemy = {}
base_enemy.TAG = "enemy"
base_enemy.WIDTH = 20 * ScreenWidhtScalingFactor

function base_enemy.construct(x_coord, y_coord)
    local enemy = base_object.construct(base_enemy.TAG, x_coord, y_coord)
    enemy.color.green = 1
    enemy.width = base_enemy.WIDTH
    enemy.height = 20 * ScreenWidhtScalingFactor
    enemy.speed = 25 * ScreenHeightScalingFactor

    enemy.bullet = base_enemy_bullet
    enemy.bullet_timeout = 10
    enemy.bullet_cooldown = love.math.random(0, enemy.bullet_timeout)

    function enemy.update(dt)
        -- Returns the generated bullet, if generated
        enemy.move(dt)

        enemy.bullet_cooldown = enemy.bullet_cooldown - 1 * dt
        local bullet = enemy.shoot()
        return bullet
    end

    function enemy.move(dt)
        enemy.coordinates.y = enemy.coordinates.y + enemy.speed * dt
    end

    return enemy
end

return base_enemy

local base_object = require "config.base_object"
local base_bullet = require "config.base_bullet"
local base_enemy = {}
local ENEMY_TAG = "enemy"


function base_enemy.construct(x_coord, y_coord)
    local enemy = base_object.construct(ENEMY_TAG, x_coord, y_coord)
    enemy.color.green = 1
    enemy.width = 20 * ScreenWidhtScalingFactor
    enemy.height = 20 * ScreenWidhtScalingFactor
    enemy.speed = 25 * ScreenHeightScalingFactor

    enemy.bullet = base_bullet
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

    function enemy.shoot()
        if enemy.bullet_cooldown > 0 then
            return nil
        end

        enemy.bullet_cooldown = enemy.bullet_timeout
        x_coord = enemy.coordinates.x + enemy.width / 2 - enemy.bullet.BASE_BULLET_WIDTH / 2
        return enemy.bullet.construct(enemy.tag, x_coord, enemy.coordinates.y)
    end

    return enemy
end

return base_enemy

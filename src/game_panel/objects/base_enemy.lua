local base_object = require "game_panel.objects.base_shooting_object"
local base_enemy_bullet = require "game_panel.objects.bullets.base_enemy_bullet"
local object_tags       = require "game_panel.objects.object_tags"
local base_enemy = {}

base_enemy.WIDTH = 20 * ScreenWidhtScalingFactor

function base_enemy.construct(x_coord, y_coord)
    local enemy = base_object.construct(object_tags.enemy, x_coord, y_coord)
    enemy.color.green = 1
    enemy.width = base_enemy.WIDTH
    enemy.height = 20 * ScreenWidhtScalingFactor
    enemy.speed = 25 * ScreenHeightScalingFactor

    enemy.bullet = base_enemy_bullet
    enemy.bullet_timeout = 10
    enemy.bullet_cooldown = love.math.random(0, enemy.bullet_timeout)

    function enemy.move(dt)
        enemy.coordinates.y = enemy.coordinates.y + enemy.speed * dt
    end

    function enemy.shoot(dt)
        enemy.bullet_cooldown = enemy.bullet_cooldown - 1 * dt
        return enemy.parent_functions.shoot()
    end

    return enemy
end

return base_enemy

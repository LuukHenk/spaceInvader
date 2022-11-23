local shooting_object = require "game_objects.shooting_object"
local object_types = require "game_objects.object_types"
local object_names = require "object_names"
local basic_enemy_bullet = require "game_objects.bullets.basic_enemy_bullet"
local basic_enemy_class = {}

basic_enemy_class.BASIC_ENEMY_WIDTH = 40
basic_enemy_class.BASIC_ENEMY_HEIGHT = 40
function basic_enemy_class.construct(x_coord, y_coord)
    local enemy = shooting_object.construct(
        object_names.basic_enemy, object_types.enemy, x_coord, y_coord
    )

    enemy.resize(
        basic_enemy_class.BASIC_ENEMY_WIDTH,
        basic_enemy_class.BASIC_ENEMY_HEIGHT
    )
    enemy.set_color(0, 1, 0, 1)
    enemy.speed = 25
    enemy.bullet = basic_enemy_bullet
    enemy.shooting_cooldown_time = 10
    enemy.shooting_cooldown = love.math.random(0, enemy.shooting_cooldown_time)

    function enemy.update(dt)
        enemy.move_down(dt)
        enemy.shoot(dt)
    end

    return enemy
end

return basic_enemy_class
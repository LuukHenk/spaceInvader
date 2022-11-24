local shooting_object = require "game_objects.shooting_object"
local object_types = require "game_objects.object_types"
local game_object_names = require "game_objects.game_object_names"
local basic_enemy_bullet = require "game_objects.bullets.basic_enemy_bullet"
local basic_enemy_class = {}

basic_enemy_class.BASIC_ENEMY_WIDTH = 50
basic_enemy_class.BASIC_ENEMY_HEIGHT = 50
function basic_enemy_class.construct(x_coord, y_coord)
    local enemy = shooting_object.construct(
        game_object_names.basic_enemy, object_types.enemy, x_coord, y_coord
    )

    enemy.resize(
        basic_enemy_class.BASIC_ENEMY_WIDTH,
        basic_enemy_class.BASIC_ENEMY_HEIGHT
    )
    enemy.set_color(1, 1, 1 , 1)
    enemy.speed = 30
    enemy.bullet = basic_enemy_bullet
    enemy.shooting_cooldown_time = 3
    enemy.shooting_cooldown = love.math.random(0, enemy.shooting_cooldown_time)

    function enemy.update(dt)
        enemy.__move(dt)
        enemy.shoot(dt)
    end

    function enemy.__move(dt)
        enemy.__update_horizontal_direction()
        if enemy.horizontal_movement == 0 then
            enemy.move_left(dt)
        elseif enemy.horizontal_movement == 1 then
            enemy.move_right(dt)
        end
        enemy.move_down(dt)
    end

    function enemy.__update_horizontal_direction()
        if love.math.random(0, 50) == 0 then
            enemy.horizontal_movement = love.math.random(0, 2)
        end
    end

    return enemy
end

return basic_enemy_class
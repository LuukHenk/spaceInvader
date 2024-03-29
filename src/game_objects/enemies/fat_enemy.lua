local shooting_object = require "game_objects.shooting_object"
local object_types = require "game_objects.object_types"
local game_object_names = require "game_objects.game_object_names"
local basic_enemy_bullet = require "game_objects.bullets.basic_enemy_bullet"
local fat_enemy_class = {}

fat_enemy_class.SHOOTING_COOLDOWN_TIME = 1
fat_enemy_class.LIVES = 10
fat_enemy_class.FAT_ENEMY_HEIGHT = 83
fat_enemy_class.FAT_ENEMY_WIDTH = 50

function fat_enemy_class.construct(x_coord, y_coord)
    local enemy = shooting_object.construct(
        game_object_names.fat_enemy, object_types.enemy, x_coord, y_coord
    )

    enemy.resize(fat_enemy_class.FAT_ENEMY_WIDTH, fat_enemy_class.FAT_ENEMY_HEIGHT)
    enemy.set_color(1, 1, 1, 1)
    enemy.lives = fat_enemy_class.LIVES
    enemy.speed = 80
    enemy.bullet = basic_enemy_bullet
    enemy.shooting_cooldown_time = fat_enemy_class.SHOOTING_COOLDOWN_TIME
    enemy.shooting_cooldown = love.math.random(0, enemy.shooting_cooldown_time)
    enemy.horizontal_movement = 0

    function enemy.update(dt)
        enemy.__move(dt)
        enemy.shoot(dt)
        enemy.__update_shooting_cooldown_time()
    end

    function enemy.__update_shooting_cooldown_time()
        enemy.shooting_cooldown_time = (
            fat_enemy_class.SHOOTING_COOLDOWN_TIME + (enemy.lives / fat_enemy_class.LIVES)
        )
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
        if love.math.random(0, 10) == 0 then
            enemy.horizontal_movement = love.math.random(0, 2)
        end
    end

    return enemy
end

return fat_enemy_class
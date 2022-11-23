local shooting_object = require "game_objects.shooting_object"
local object_types = require "game_objects.object_types"
local object_names = require "object_names"
local basic_enemy_bullet = require "game_objects.bullets.basic_enemy_bullet"
local fat_enemy_class = {}

fat_enemy_class.FAT_ENEMY_HEIGHT = 80
fat_enemy_class.FAT_ENEMY_WIDTH = 80

function fat_enemy_class.construct(x_coord, y_coord)
    local enemy = shooting_object.construct(
        object_names.fat_enemy, object_types.enemy, x_coord, y_coord
    )

    enemy.resize(fat_enemy_class.FAT_ENEMY_WIDTH, fat_enemy_class.FAT_ENEMY_HEIGHT)
    enemy.set_color(0, 0.1, 0.4, 1)
    enemy.lives = 10
    enemy.speed = 80
    enemy.bullet = basic_enemy_bullet
    enemy.shooting_cooldown_time = 7
    enemy.shooting_cooldown = love.math.random(0, enemy.shooting_cooldown_time)

    function enemy.update(dt)
        enemy.move_down(dt)
        enemy.shoot(dt)
    end

    return enemy
end

return fat_enemy_class
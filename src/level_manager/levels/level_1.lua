local base_level = require "level_manager.levels.level"
local basic_enemy = require "game_objects.enemies.basic_enemy"
local fat_enemy = require "game_objects.enemies.fat_enemy"
local level_object_spawner = require "level_manager.level_object_spawner"
local wave = require "level_manager.wave"
local level_1_class = {}




function level_1_class.construct(assets)
    local level_1 = base_level.construct(assets)
    level_1.waves = {}

    -- local enemies = {
    --     level_object_spawner.construct(basic_enemy, 480, -basic_enemy.BASIC_ENEMY_HEIGHT),
    --     level_object_spawner.construct(basic_enemy, 1440, -basic_enemy.BASIC_ENEMY_HEIGHT)
    -- }
    -- table.insert(level_1.waves, wave.construct(0, enemies))

    -- enemies = {
    --     level_object_spawner.construct(basic_enemy, 400, -basic_enemy.BASIC_ENEMY_HEIGHT),
    --     level_object_spawner.construct(basic_enemy, 120, -basic_enemy.BASIC_ENEMY_HEIGHT),
    --     level_object_spawner.construct(basic_enemy, 600, -basic_enemy.BASIC_ENEMY_HEIGHT),
    --     level_object_spawner.construct(basic_enemy, 1800, -basic_enemy.BASIC_ENEMY_HEIGHT)
    -- }
    -- table.insert(level_1.waves, wave.construct(0.1, enemies))

    -- enemies = {
    --     level_object_spawner.construct(basic_enemy, 300, -basic_enemy.BASIC_ENEMY_HEIGHT),
    --     level_object_spawner.construct(basic_enemy, 80, -basic_enemy.BASIC_ENEMY_HEIGHT),
    --     level_object_spawner.construct(basic_enemy, 670, -basic_enemy.BASIC_ENEMY_HEIGHT),
    --     level_object_spawner.construct(basic_enemy, 900, -basic_enemy.BASIC_ENEMY_HEIGHT),
    --     level_object_spawner.construct(basic_enemy, 1600, -basic_enemy.BASIC_ENEMY_HEIGHT)
    -- }
    -- table.insert(level_1.waves, wave.construct(0.199, enemies))

    -- enemies = {
    --     level_object_spawner.construct(fat_enemy, 960, -fat_enemy.FAT_ENEMY_HEIGHT),
    -- }
    -- table.insert(level_1.waves, wave.construct(0.3939, enemies))

    local enemies = {
        level_object_spawner.construct(basic_enemy, 960, -fat_enemy.FAT_ENEMY_HEIGHT),
    
    }
    table.insert(level_1.waves, wave.construct(0, enemies))
    return level_1
end

return level_1_class
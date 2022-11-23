local base_level = require "level_manager.levels.level"
local basic_enemy = require "game_objects.enemies.basic_enemy"
local level_object_spawner = require "level_manager.levels.level_object_spawner"
local wave = require "level_manager.wave"
local level_1_class = {}




function level_1_class.construct(assets)
    local level_1 = base_level.construct(assets)
    level_1.waves = {}

    local enemies = level_object_spawner.construct_many_at_top_of_screen(basic_enemy, 2)
    table.insert(level_1.waves, wave.construct(0, enemies))

    enemies = level_object_spawner.construct_many_at_top_of_screen(basic_enemy, 3)
    table.insert(level_1.waves, wave.construct(0.1, enemies))

    enemies = level_object_spawner.construct_many_at_top_of_screen(basic_enemy, 5)
    table.insert(level_1.waves, wave.construct(0.199, enemies))

    return level_1
end

return level_1_class
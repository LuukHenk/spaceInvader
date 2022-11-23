local base_wave_class = require "level_manager.levels.wave"
local basic_enemy = require "game_objects.enemies.basic_enemy"
local level_object_spawner = require "level_manager.levels.level_object_spawner"

local wave_1_class = {}

function wave_1_class.construct()
    local wave_1 = base_wave_class.construct()
    wave_1.enemies_to_spawn = {
        level_object_spawner.construct(basic_enemy, 0.4, 0),
        level_object_spawner.construct(basic_enemy, 0.2, 0),
        level_object_spawner.construct(basic_enemy, 0.6, 0),
    }

    return wave_1
end

return wave_1_class
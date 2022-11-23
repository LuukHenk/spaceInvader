local base_wave_class = require "level_manager.levels.wave"
local basic_enemy = require "game_objects.enemies.basic_enemy"
local level_object_spawner = require "level_manager.levels.level_object_spawner"

local wave_2_class = {}

function wave_2_class.construct()
    local wave_2 = base_wave_class.construct()
    wave_2.start_time = 0.8
    wave_2.enemies_to_spawn = {
        level_object_spawner.construct(basic_enemy, 0.2, 0),
        level_object_spawner.construct(basic_enemy, 0.5, 0),
        level_object_spawner.construct(basic_enemy, 0.715, 0),
    }

    return wave_2
end

return wave_2_class
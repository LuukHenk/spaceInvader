local level_object_spawner = require "level_manager.levels.level_object_spawner"
local basic_enemy = require "game_objects.enemies.basic_enemy"
local base_level = require "level_manager.levels.level"

local level_2_class = {}

function level_2_class.construct(assets)
    local level_2 = base_level.construct(assets)

    local objects_to_spawn = {
        level_object_spawner.construct(basic_enemy, 0.5, 0),
    }
    for _, object_to_spawn in pairs(objects_to_spawn) do
        table.insert(level_2.objects, object_to_spawn.spawn())
    end

    return level_2
end

return level_2_class
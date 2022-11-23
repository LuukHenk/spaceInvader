local level_object_spawner = require "level_manager.levels.level_object_spawner"
local basic_enemy = require "game_objects.enemies.basic_enemy"

local base_level = require "level_manager.levels.level"
local level_1_class = base_level.construct()



level_1_class.objects_to_spawn = {
    level_object_spawner.construct(basic_enemy, 0.1, 0),
    -- level_object_spawner.construct(basic_enemy, 0.2, 0),
    -- level_object_spawner.construct(basic_enemy, 0.3, 0),
    -- level_object_spawner.construct(basic_enemy, 0.4, 0),
    -- level_object_spawner.construct(basic_enemy, 0.5, 0),
    -- level_object_spawner.construct(basic_enemy, 0.6, 0),
    -- level_object_spawner.construct(basic_enemy, 0.7, 0),
    -- level_object_spawner.construct(basic_enemy, 0.8, 0),
    -- level_object_spawner.construct(basic_enemy, 0.9, 0)
}

function level_1_class.construct(assets)
    local level_1 = {}
    level_1.assets = assets
    level_1.objects = {}
    for _, object_to_spawn in pairs(level_1_class.objects_to_spawn) do
        table.insert(level_1.objects, object_to_spawn.spawn())
    end
    return level_1
end

return level_1_class
local level_object_spawner = require "level_manager.levels.level_object_spawner"
local basic_enemy = require "game_objects.enemies.basic_enemy"
local base_level = require "level_manager.levels.level"
local level_2 = base_level.construct()



level_2.objects_to_spawn = {
    level_object_spawner.construct(basic_enemy, 0.1, 0),
    level_object_spawner.construct(basic_enemy, 0.2, 0),
    level_object_spawner.construct(basic_enemy, 0.3, 0),
    level_object_spawner.construct(basic_enemy, 0.4, 0),
    level_object_spawner.construct(basic_enemy, 0.5, 0),
    level_object_spawner.construct(basic_enemy, 0.6, 0),
    level_object_spawner.construct(basic_enemy, 0.7, 0),
    level_object_spawner.construct(basic_enemy, 0.8, 0),
    level_object_spawner.construct(basic_enemy, 0.9, 0),
    level_object_spawner.construct(basic_enemy, 0.05, 0),
    level_object_spawner.construct(basic_enemy, 0.15, 0),
    level_object_spawner.construct(basic_enemy, 0.25, 0),
    level_object_spawner.construct(basic_enemy, 0.35, 0),
    level_object_spawner.construct(basic_enemy, 0.45, 0),
    level_object_spawner.construct(basic_enemy, 0.55, 0),
    level_object_spawner.construct(basic_enemy, 0.65, 0),
    level_object_spawner.construct(basic_enemy, 0.75, 0),
    level_object_spawner.construct(basic_enemy, 0.85, 0),
    level_object_spawner.construct(basic_enemy, 0.95, 0)
}

function level_2.construct(assets)
    level_2.assets = assets
    local objects = {}
    for _, object_to_spawn in pairs(level_2.objects_to_spawn) do
        table.insert(objects, object_to_spawn.spawn())
    end

    return objects
end

return level_2
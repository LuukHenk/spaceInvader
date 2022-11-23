local base_level = require "level_manager.levels.level"
local level_object_spawner = require "level_manager.levels.level_object_spawner"
local basic_enemy = require "game_objects.enemies.basic_enemy"
local level_1_class = {}




function level_1_class.construct(assets)
    local level_1 = base_level.construct(assets)
    
    local objects_to_spawn = {
        level_object_spawner.construct(basic_enemy, 0.5, 0),
    }
    function level_1.update(dt)
        level_1.in_level_time = os.clock() - level_1.start_time
    end

    function level_1.__spawn_level_objects(objects_to_spawn)
        for _, object_to_spawn in pairs(objects_to_spawn) do
            table.insert(level_1.objects, object_to_spawn.spawn())
        end
    end

    level_1.__spawn_level_objects(objects_to_spawn)
    return level_1
end

return level_1_class
local level_object_spawner = {}

function level_object_spawner.construct(object, relative_x_coord, releative_y_coord)
    -- The relative coordinates should be between 0 and 1
    local object_to_spawn = {}
    object_to_spawn.x_coord = relative_x_coord * ScreenWidhtScalingFactor * EXPECTED_SCREEN_WIDTH
    object_to_spawn.y_coord = releative_y_coord * ScreenHeightScalingFactor * EXPECTED_SCREEN_HEIGHT 
    object_to_spawn.construct = object.construct

    function object_to_spawn.spawn()
        return object_to_spawn.construct(
            object_to_spawn.x_coord,
            object_to_spawn.y_coord
        )
    end
    return object_to_spawn
end

return level_object_spawner
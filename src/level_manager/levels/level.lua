local level_base_class = {}

function level_base_class.construct()
    local level = {}
    -- abstract
    level.objects_to_spawn = {}

    -- abstract
    function level.construct()
    end
    return level
end


return level_base_class


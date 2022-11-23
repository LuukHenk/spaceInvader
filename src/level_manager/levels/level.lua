local level_base_class = {}

function level_base_class.construct()
    local level = {}
    -- abstract
    level.objects_to_spawn = {}
    level.assets = nil

    -- abstract
    function level.construct(assets)
    end
    return level
end


return level_base_class


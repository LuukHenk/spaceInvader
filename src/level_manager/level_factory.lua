local levels = require "level_manager.levels"
local level_factory_class = {}

function level_factory_class.construct()
    local level_factory = {}

    function level_factory.construct_level(level_id)
        local level = levels[level_id]
        if not level then return nil end
        return level.construct()
    end

    return level_factory
end

return level_factory_class
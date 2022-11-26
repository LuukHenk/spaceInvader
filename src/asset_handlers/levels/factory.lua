local panel_assets_handler = require "asset_handlers.panel_assets_handler"
local factory_class = {}

local LEVEL_OBJECT_NAME = "level_"
function factory_class.construct(total_levels)
    local factory = {}

    function factory.__init__(total_levels_)
        factory.levels = factory.__get_assets_for_all_levels(total_levels_)
    end

    function factory.get_level_assets(level_id)
        return factory.levels[level_id]
    end

    function factory.__get_assets_for_all_levels(total_levels_)
        local levels = {}
        for level_id=1, total_levels_ do
            local level_object_name = LEVEL_OBJECT_NAME .. level_id
            levels[level_id] = panel_assets_handler.construct(level_object_name)
        end
        return levels
    end

    factory.__init__(total_levels)
    return factory
end

return factory_class

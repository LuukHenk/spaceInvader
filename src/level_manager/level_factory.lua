local levels = require "level_manager.levels"
local level_assets_factory = require "asset_handlers.levels.factory"
local utils = require "utils"
local level_factory_class = {}

function level_factory_class.construct()
    local level_factory = {}

    function level_factory.__init__()
        level_factory.assets_factory = level_assets_factory.construct(
            utils.table_size(levels)
        )
    end
    function level_factory.construct_level(level_id)
        local level = levels[level_id]
        local level_assets = level_factory.assets_factory.get_level_assets(level_id)
        if not level then return nil end
        return level.construct(level_assets)
    end

    level_factory.__init__()
    return level_factory
end

return level_factory_class
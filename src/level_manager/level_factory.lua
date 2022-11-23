local levels = require "level_manager.levels"
local level_assets_factory = require "assets.level_assets_handler.level_assets_factory"
local utils = require "utils"
local level_factory_class = {}

function level_factory_class.construct()
    local level_factory = {}
    local assets = level_assets_factory.get_level_assets(utils.table_size(levels))

    function level_factory.construct_level(level_id)
        local level = levels[level_id]
        local level_assets = assets.get_level_assets(level_id)
        if not level then return nil end
        return level.construct(level_assets)
    end

    return level_factory
end

return level_factory_class
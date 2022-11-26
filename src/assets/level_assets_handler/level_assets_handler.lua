local assets_loader_class = require "assets.assets_loader"
local level_assets_class = require "assets.panel_assets"

local level_assets_handler_class = {}

local LEVEL_OBJECT_NAME = "level_"
function level_assets_handler_class.construct()
    local level_assets_handler = {}
    local assets_handler = assets_loader_class.construct()
    level_assets_handler.assets = {}

    function level_assets_handler.load_level_assets(level_id)
        local level_object_name = LEVEL_OBJECT_NAME .. level_id
        local level_assets = level_assets_class.construct(level_object_name, assets_handler)
        level_assets_handler.assets[level_id] = level_assets
    end

    function level_assets_handler.get_level_assets(level_id)
        return level_assets_handler.assets[level_id]
    end

    return level_assets_handler
end

return level_assets_handler_class

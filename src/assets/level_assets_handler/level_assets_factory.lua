local level_assets_handler_class = require "assets.level_assets_handler.level_assets_handler"
local level_assets_factory = {}

function level_assets_factory.get_level_assets(total_levels)
    local level_assets_handler = level_assets_handler_class.construct()
    for i=1, total_levels do
        level_assets_handler.load_level_assets(i)
    end
    return level_assets_handler
end

return level_assets_factory

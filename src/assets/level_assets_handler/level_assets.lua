local asset_types = require "assets.asset_types"

local level_assets_class = {}


function level_assets_class.construct(level_object_name, assets_handler)
    local level_assets = {}
    level_assets[asset_types.BACKGROUND] = assets_handler.get_object(
        level_object_name, asset_types.BACKGROUND
    )

    function level_assets.get_background()
        return level_assets[asset_types.BACKGROUND]
    end
    return level_assets
end

return level_assets_class
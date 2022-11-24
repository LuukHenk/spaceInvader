local asset_types = require "assets.asset_types"

local game_object_assets_class = {}


function game_object_assets_class.construct(level_object_name, assets_handler)
    local game_object_assets = {}
    game_object_assets[asset_types.SPRITE] = assets_handler.get_object(
        level_object_name, asset_types.SPRITE
    )

    function game_object_assets.get_sprite()
        return game_object_assets[asset_types.SPRITE]
    end

    return game_object_assets
end

return game_object_assets_class
local asset_types = require "assets.asset_types"

local level_assets_class = {}


function level_assets_class.construct(level_object_name, assets_handler)
    local level_assets = {}
    level_assets[asset_types.BACKGROUND] = assets_handler.get_object(
        level_object_name, asset_types.BACKGROUND
    )
    level_assets[asset_types.MUSIC] = assets_handler.get_object(
        level_object_name, asset_types.MUSIC
    )

    function level_assets.get_background()
        return level_assets[asset_types.BACKGROUND]
    end

    function level_assets.play_music()
        if level_assets[asset_types.MUSIC] then
            level_assets[asset_types.MUSIC]:play()
        end
    end

    function level_assets.stop_music()
        if level_assets[asset_types.MUSIC] then
            level_assets[asset_types.MUSIC]:stop()
        end
    end

    return level_assets
end

return level_assets_class
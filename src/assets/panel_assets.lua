local asset_types = require "assets.asset_types"

local panel_assets_class = {}


function panel_assets_class.construct(level_object_name, assets_handler)
    local panel_assets = {}
    panel_assets[asset_types.BACKGROUND] = assets_handler.get_object(
        level_object_name, asset_types.BACKGROUND
    )
    panel_assets[asset_types.MUSIC] = assets_handler.get_object(
        level_object_name, asset_types.MUSIC
    )

    function panel_assets.get_background()
        return panel_assets[asset_types.BACKGROUND]
    end

    function panel_assets.play_music()
        if panel_assets[asset_types.MUSIC] then
            panel_assets[asset_types.MUSIC]:play()
        end
    end

    function panel_assets.stop_music()
        if panel_assets[asset_types.MUSIC] then
            panel_assets[asset_types.MUSIC]:stop()
        end
    end

    function panel_assets.pause_music()
        if panel_assets[asset_types.MUSIC] then
            panel_assets[asset_types.MUSIC]:pause()
        end
    end

    return panel_assets
end

return panel_assets_class
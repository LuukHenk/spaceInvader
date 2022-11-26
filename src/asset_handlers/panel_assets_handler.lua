local asset_types = require "assets.asset_types"
local assets_loader = require "assets.assets_loader"
local draw = require "draw"

local panel_assets_handler_class = {}


function panel_assets_handler_class.construct(level_object_name)
    local panel_assets_handler = {}

    function panel_assets_handler.__init__()
        panel_assets_handler.assets_loader = assets_loader.construct()
        panel_assets_handler.background_image = panel_assets_handler.assets_loader.get_object(
            level_object_name, asset_types.BACKGROUND
        )
        panel_assets_handler.music = panel_assets_handler.assets_loader.get_object(
            level_object_name, asset_types.MUSIC
        )
    end

    function panel_assets_handler.draw_background()
        if panel_assets_handler.background_image then
            draw.draw_background(panel_assets_handler.background_image)
        end
    end

    function panel_assets_handler.play_music()
        if panel_assets_handler.music then
            panel_assets_handler.music:play()
        end
    end

    function panel_assets_handler.stop_music()
        if panel_assets_handler.music then
            panel_assets_handler.music:stop()
        end
    end

    function panel_assets_handler.pause_music()
        if panel_assets_handler.music then
            panel_assets_handler.music:pause()
        end
    end

    panel_assets_handler.__init__()
    return panel_assets_handler
end

return panel_assets_handler_class
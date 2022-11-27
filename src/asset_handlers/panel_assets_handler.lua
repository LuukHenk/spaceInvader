local asset_types = require "asset_handlers.assets_loader.asset_types"
local assets_loader = require "asset_handlers.assets_loader.assets_loader"
local visualizer = require "visualizer"

local panel_assets_handler_class = {}


function panel_assets_handler_class.construct(level_object_name)
    local panel_assets_handler = {}

    function panel_assets_handler.__init__()
        panel_assets_handler.assets_loader = assets_loader.construct()
        panel_assets_handler.visualizer = visualizer.construct()
        panel_assets_handler.background_image = panel_assets_handler.assets_loader.get_asset(
            asset_types.BACKGROUND, level_object_name
        )
        panel_assets_handler.music = panel_assets_handler.assets_loader.get_asset(
            asset_types.MUSIC, level_object_name
        )
    end

    function panel_assets_handler.draw_background()
        if panel_assets_handler.background_image then
            panel_assets_handler.visualizer.draw_background(panel_assets_handler.background_image)
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

    function panel_assets_handler.__load_background_image()

    end
    
    panel_assets_handler.__init__()
    return panel_assets_handler
end

return panel_assets_handler_class
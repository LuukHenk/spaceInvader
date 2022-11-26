local assets_loader_class = require "assets.assets_loader"
local game_object_assets_class = require "assets.game_object_assets_handler.game_object_assets"

local game_object_assets_handler_class = {}

function game_object_assets_handler_class.construct()
    local game_object_assets_handler = {}
    local assets_handler = assets_loader_class.construct()
    game_object_assets_handler.assets = {}

    function game_object_assets_handler.load_game_object_assets(game_object_name)
        local level_assets = game_object_assets_class.construct(game_object_name, assets_handler)
        game_object_assets_handler.assets[game_object_name] = level_assets
    end

    function game_object_assets_handler.get_game_object_assets(game_object_name)
        return game_object_assets_handler.assets[game_object_name]
    end

    return game_object_assets_handler
end

return game_object_assets_handler_class

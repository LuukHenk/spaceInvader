local game_object_assets_handler_class = require "assets.game_object_assets_handler.game_object_assets_handler"
local game_object_names = require "game_objects.game_object_names"

local game_object_assets_factory = {}

function game_object_assets_factory.get_all_game_object_assets()
    local game_object_assets_handler = game_object_assets_handler_class.construct()
    for _, name in pairs(game_object_names) do
        game_object_assets_handler.load_game_object_assets(name)
    end
    return game_object_assets_handler
end

return game_object_assets_factory

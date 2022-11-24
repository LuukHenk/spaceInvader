local asset_types = require "assets.asset_types"
local sound_effect_names = require "assets.game_object_assets_handler.sound_effect_names"

local game_object_assets_class = {}


function game_object_assets_class.construct(level_object_name, assets_handler)
    local game_object_assets = {}

    function game_object_assets.__init__()
        game_object_assets[asset_types.SOUND_EFFECTS] = game_object_assets.__get_sound_effects(
            level_object_name
        )

        game_object_assets[asset_types.SPRITE] = assets_handler.get_object(
            level_object_name, asset_types.SPRITE
        )
    end

    function game_object_assets.get_sprite()
        return game_object_assets[asset_types.SPRITE]
    end

    function game_object_assets.play_die_sound()
        game_object_assets.__play_sound_effect(sound_effect_names.DIE)
    end

    function game_object_assets.__play_sound_effect(sound_effect_name)
        local sound = game_object_assets[asset_types.SOUND_EFFECTS][sound_effect_name]
        if sound then
            sound:stop()
            sound:play()
        end
    end

    function game_object_assets.__get_sound_effects(object_name)
        local sound_effects = {}
        for _, sound_effect_name in pairs(sound_effect_names) do
            local path_name = object_name .. "/" .. sound_effect_name
            sound_effects[sound_effect_name] = assets_handler.get_object(
                path_name, asset_types.SOUND_EFFECTS
            )
        end
        return sound_effects
    end

    game_object_assets.__init__()
    return game_object_assets
end

return game_object_assets_class
local asset_types = require "asset_handlers.assets_loader.asset_types"
local assets_loader = require "asset_handlers.assets_loader.assets_loader"
local sound_effect_names = require "asset_handlers.game_objects.sound_effect_names"

local handler_class = {}


function handler_class.construct(level_object_name)
    local handler = {}

    function handler.__init__()
        handler.assets_loader = assets_loader.construct()
        handler[asset_types.SOUND_EFFECTS] = handler.__get_sound_effects(
            level_object_name
        )

        handler[asset_types.SPRITE] = handler.assets_loader.get_asset(
            asset_types.SPRITE, level_object_name
        )
    end

    function handler.get_sprite()
        return handler[asset_types.SPRITE]
    end

    function handler.play_shoot_sound()
        handler.__play_sound_effect(sound_effect_names.SHOOT)
    end

    function handler.play_die_sound()
        handler.__play_sound_effect(sound_effect_names.DIE)
    end

    function handler.__play_sound_effect(sound_effect_name)
        local sound = handler[asset_types.SOUND_EFFECTS][sound_effect_name]
        if sound then
            sound:stop()
            sound:play()
        end
    end

    function handler.__get_sound_effects(object_name)
        local sound_effects = {}
        for _, sound_effect_name in pairs(sound_effect_names) do
            local path_name = object_name .. "/" .. sound_effect_name
            sound_effects[sound_effect_name] = handler.assets_loader.get_asset(
                asset_types.SOUND_EFFECTS, path_name
            )
        end
        return sound_effects
    end

    handler.__init__()
    return handler
end

return handler_class
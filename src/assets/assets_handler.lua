local asset_types = require "assets.asset_types"

local assets_handler_class = {}

local SOUND_EFFECTS_EXTENSION_TYPE = ".wav"
local MUSIC_EXTENSION_TYPE = ".mp3"
local IMAGE_EXTENSION_TYPE = ".png"
local SPRITE_FOLDER = "assets/sprites/"
local BACKGROUND_FOLDER = "assets/backgrounds/"
local MUSIC_FOLDER = "assets/music/"
local SOUND_EFFECTS_FOLDER = "assets/sound_effects/"

function assets_handler_class.construct()
    local assets_handler = {}

    function assets_handler.get_object(object_name, asset_type)
        local folder, extension = assets_handler.__folder_selection(asset_type) 
        local path = folder .. object_name .. extension
        if not assets_handler.__check_if_file_exists(path) then
            print(
                "Warning: Unable to find " .. asset_type .. " for " .. object_name .. " at " .. path
            )
            return nil
        end

        return assets_handler.__load_asset(asset_type, path)
    end

    function assets_handler.__load_asset(asset_type, path)
        if asset_type == asset_types.MUSIC then
            return assets_handler.__load_music(path)
        elseif asset_type == asset_types.SOUND_EFFECTS then
            return assets_handler.__load_sound_effect(path)
        elseif asset_type == asset_types.BACKGROUND or asset_type == asset_types.SPRITE then
            return assets_handler.__load_image(path)
        else
            print("Unable to load the asset type " .. asset_type)
        end
    end
    function assets_handler.__load_music(path)
        return love.audio.newSource(path, "stream")
    end

    function assets_handler.__load_sound_effect(path)
        return love.audio.newSource(path, "static")
    end

    function assets_handler.__load_image(path)
        return love.graphics.newImage(path)
    end

    function assets_handler.__check_if_file_exists(file_path)
        local file_data = io.open(file_path,"r")
        if not file_data then return false end
        io.close(file_data)
        return true
    end

    function assets_handler.__folder_selection(asset_type)
        if asset_type == asset_types.BACKGROUND then
            return BACKGROUND_FOLDER, IMAGE_EXTENSION_TYPE
        elseif asset_type == asset_types.SOUND_EFFECTS then
            return SOUND_EFFECTS_FOLDER, SOUND_EFFECTS_EXTENSION_TYPE
        elseif asset_type == asset_types.SPRITE then
            return SPRITE_FOLDER, IMAGE_EXTENSION_TYPE
        elseif asset_type == asset_types.MUSIC then
            return MUSIC_FOLDER, MUSIC_EXTENSION_TYPE
        else
            print("Error: Unknown asset type: " .. asset_type)
            return "", ""
        end
    end

    return assets_handler
end

return assets_handler_class
local assets_handler_class = {}

local IMAGE_EXTENSION_TYPE = ".png"
function assets_handler_class.construct()
    local assets_handler = {}
    local sprite_folder = "assets/sprites/"

    function assets_handler.get_sprite(object_name)
        local path = sprite_folder .. object_name .. IMAGE_EXTENSION_TYPE
        if not assets_handler.__check_if_file_exists(path) then return nil end
        return assets_handler.__load_image(path)
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

    return assets_handler
end

return assets_handler_class
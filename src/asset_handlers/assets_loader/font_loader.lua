
local basic_loader = require "asset_handlers.assets_loader.basic_loader" 

local FOLDER = "fonts/"
local EXTENSION_TYPE = ".ttf"

local fonts_loader_class = {}

function fonts_loader_class.construct()
    local loader = basic_loader.construct(
        FOLDER,
        EXTENSION_TYPE,
        fonts_loader_class.__load_font_path
    )
    return loader
end

function fonts_loader_class.__load_font_path(path)
    return path
end

return fonts_loader_class
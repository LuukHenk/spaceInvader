local asset_types = require "asset_handlers.assets_loader.asset_types"
local assets_loader = require "assets.assets_loader"
local font_names = require "asset_handlers.fonts.font_names"

local fonts_class = {}

function fonts_class.construct()
    local fonts = {}

    function fonts.__init__()
        fonts.assets_loader = assets_loader.construct()
        fonts.title_font = fonts.assets_loader.get_object(font_names.TITLE, asset_types.FONT)
        fonts.header_font = fonts.assets_loader.get_object(font_names.TITLE, asset_types.FONT)
    end

    fonts.__init__()
    return fonts
end
return fonts_class
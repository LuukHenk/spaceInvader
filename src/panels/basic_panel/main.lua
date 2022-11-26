local panel_ids = require "panel_manager.panel_ids"
local panel = require "panel_manager.panel"
local draw = require "draw"

local basic_panel_class = {}
function basic_panel_class.construct(panel_id)
    local basic_panel = panel.construct(panel_id)

    function basic_panel.__init__()
    end

    function basic_panel.draw()
        draw.draw_panel_title("Wait, what? How did I end up here")
    end

    basic_panel.__init__()
    return basic_panel
end

return basic_panel_class
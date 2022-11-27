local panel = require "panel_manager.panel"
local visualizer = require "visualizer"

local basic_panel_class = {}
function basic_panel_class.construct(panel_id)
    local basic_panel = panel.construct(panel_id)

    function basic_panel.__init__()
        basic_panel.visualizer = visualizer.construct()
    end

    function basic_panel.draw()
        basic_panel.visualizer.draw_panel_title("Wait, what? How did I end up here")
    end

    basic_panel.__init__()
    return basic_panel
end

return basic_panel_class
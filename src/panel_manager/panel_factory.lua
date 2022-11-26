local panel_ids = require "panel_manager.panel_ids"
local basic_panel = require "panels.basic_panel.main"
local game_panel = require "panels.game_panel.main"
local game_over_panel = require "panels.game_over_panel.main"
local main_menu_panel = require "panels.main_menu_panel.main"
local pause_panel = require "panels.pause_panel.main"

local panel_factory_class = {}

function panel_factory_class.construct()
    local panel_factory = {}

    function panel_factory.__init__()
        panel_factory.panels = panel_factory.construct_all_panels()
    end

    function panel_factory.construct_all_panels()
        local panels = {}
        panels[panel_ids.main_menu_panel] = main_menu_panel.construct(panel_ids.main_menu_panel)
        panels[panel_ids.basic_panel] = basic_panel.construct(panel_ids.basic_panel)
        panels[panel_ids.game_panel] = game_panel.construct(panel_ids.game_panel)
        panels[panel_ids.game_over_panel] = game_over_panel.construct(panel_ids.game_over_panel)
        panels[panel_ids.pause_panel] = pause_panel.construct(panel_ids.pause_panel)
        return panels
    end

    function panel_factory.get_panel(panel_id)
        return panel_factory.panels[panel_id]
    end

    panel_factory.__init__()
    return panel_factory
end
return panel_factory_class
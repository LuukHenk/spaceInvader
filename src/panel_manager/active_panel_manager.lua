-- Manages the current active panel

local panel_ids = require "panel_manager.panel_ids"
local panel_factory = require "panel_manager.panel_factory"

local active_panel_manager = {}
local default_active_panel =  panel_ids.main_menu_panel

function active_panel_manager.load()
    local start_time = love.timer.getTime()
    active_panel_manager.panel_factory = panel_factory.construct()
    active_panel_manager.active_panel = active_panel_manager.panel_factory.get_panel(
        default_active_panel
    )
    local loading_time = love.timer.getTime() - start_time
    if DEBUG then
        local dbg_text = "Loaded all panels (" .. loading_time .. "s)"
        print(dbg_text)
    end
end

function active_panel_manager.update(dt)
    active_panel_manager.select_next_active_panel()
    active_panel_manager.active_panel.update(dt)
end

function active_panel_manager.draw()
    active_panel_manager.active_panel.draw()
end

function active_panel_manager.select_next_active_panel()
    -- Selects the next panel, and loads the panel if there is a new panel
    local panel = active_panel_manager.active_panel
    if panel.next_active_panel ~= panel.panel_id then
        local new_panel = active_panel_manager.panel_factory.get_panel(
            panel.next_active_panel
        )
        new_panel.next_active_panel = new_panel.panel_id
        active_panel_manager.active_panel = new_panel
        new_panel.on_activation(panel.panel_id, panel.notification)
    end
end

return active_panel_manager
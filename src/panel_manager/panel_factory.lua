local panel_factory = {}

function panel_factory.construct_panel(panel_id)
    local panel = {}
    panel.panel_id = panel_id
    panel.next_active_panel = panel.panel_id

    --abstract
    function panel.load()
    end

    --abstract
    function panel.update(dt)
    end
    
    --abstract
    function panel.draw()
    end
    
    return panel
end

return panel_factory
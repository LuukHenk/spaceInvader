local panel_factory = {}

function panel_factory.construct_panel(panel_id)
    local panel = {}
    panel.panel_id = panel_id
    panel.next_active_panel = panel.panel_id
    panel.notification = nil

    --abstract
    function panel.load()
    end

    --abstract
    function panel.update(dt)
    end

    --abstract
    function panel.draw()
    end

    --abstract
    function panel.on_activation(previous_panel_id, notification)
    end

    return panel
end

return panel_factory

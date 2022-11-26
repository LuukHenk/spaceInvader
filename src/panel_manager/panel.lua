-- abstract class

local panel_class =  {}

function panel_class.construct(panel_id)
    local panel = {}

    function panel.__init__(panel_id)
        panel.panel_id = panel_id
        panel.next_active_panel = panel.panel_id
        panel.notification = nil
    end

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

    panel.__init__(panel_id)
    return panel
end

return panel_class
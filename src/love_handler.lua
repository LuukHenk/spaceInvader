local active_panel_manager = require "panel_manager.active_panel_manager"

local love_handler_class = {}

function love_handler_class.construct()
    local love_handler = {}
    love_handler.lag = 0.0
    love_handler.TICK_RATE = 1/100
    love_handler.MAX_FRAME_SKIP = 25

    active_panel_manager.load()
    if love.timer then love.timer.step() end

    function love_handler.main_loop()
        local early_return_event = love_handler.handle_love_events()
        if early_return_event then return 0 end
        love_handler.handle_updating()
        love_handler.handle_graphics()
    end

    function love_handler.handle_updating()
        if love.timer then
            love_handler.lag = math.min(
                love_handler.lag + love.timer.step(),
                love_handler.TICK_RATE * love_handler.MAX_FRAME_SKIP
            )
        end
        while love_handler.lag >= love_handler.TICK_RATE do
            active_panel_manager.update(love_handler.TICK_RATE)
            love_handler.lag = love_handler.lag - love_handler.TICK_RATE
        end
        if love.timer then love.timer.sleep(1 / 60) end
    end

    function love_handler.handle_graphics()
        if love.graphics and love.graphics.isActive() then
            love.graphics.origin()
            love.graphics.clear(love.graphics.getBackgroundColor())
            active_panel_manager.draw()
            love.graphics.present()
        end
    end

    function love_handler.handle_love_events()
        if love.event then
            love.event.pump()
            for name, a , b, c, d, e, f in love.event.poll() do
                if name == "quit" then
                    return 0
                end
                love.handlers[name](a, b, c, d, e, f)
            end
        end
    end

    return love_handler.main_loop
end

return love_handler_class
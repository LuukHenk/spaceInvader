love.window.setFullscreen(true, 'desktop')


local EXPECTED_SCREEN_HEIGHT = 1080
local EXPECTED_SCREEN_WIDTH = 1920

ScreenWidhtScalingFactor = love.graphics.getWidth() / EXPECTED_SCREEN_WIDTH
ScreenHeightScalingFactor = love.graphics.getHeight() / EXPECTED_SCREEN_HEIGHT

local IN_GAME_STATE = "in game"
local MENU_STATE = "menu"
local MAIN_STATES = { IN_GAME_STATE, MENU_STATE }

local TICK_RATE = 1 / 100
local MAX_FRAME_SKIP = 25

local main = {}

local game = require "game"




function love.run()
    if love.load then love.load() end
    if love.timer then love.timer.step() end

    local lag = 0.0

    return function()

        if love.event then
            love.event.pump()
            for name, a, b, c, d, e, f in love.event.poll() do
                if name == "quit" then
                    if not love.quit or not love.quit() then
                        return a or 0
                    end
                end
                love.handlers[name](a, b, c, d, e, f)
            end
        end
        if love.timer then
            lag = math.min(lag + love.timer.step(), TICK_RATE * MAX_FRAME_SKIP)
        end
        while lag >= TICK_RATE do
            if love.update then love.update(TICK_RATE) end
            lag = lag - TICK_RATE
        end
        if love.graphics and love.graphics.isActive() then
            love.graphics.origin()
            love.graphics.clear(love.graphics.getBackgroundColor())

            if love.draw then love.draw() end
            love.graphics.present()
        end
        if love.timer then love.timer.sleep(1 / 60) end
    end
end

function love.load()
    main.state = IN_GAME_STATE
    game.load()
end

function love.update(dt)
    if main.state == IN_GAME_STATE then
        game.update(dt)
    elseif main.state == MENU_STATE then
        return
    end
end

function love.draw()
    if main.state == IN_GAME_STATE then
        game.draw()
    elseif main.state == MENU_STATE then
        return
    end
end

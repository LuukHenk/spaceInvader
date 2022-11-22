


-- love.window.setFullscreen(true, 'desktop')

EXPECTED_SCREEN_HEIGHT = 1080
EXPECTED_SCREEN_WIDTH = 1920

ScreenWidhtScalingFactor = love.graphics.getWidth() / EXPECTED_SCREEN_WIDTH
ScreenHeightScalingFactor = love.graphics.getHeight() / EXPECTED_SCREEN_HEIGHT

function love.run()
    local love_handler = require "love_handler"
    return love_handler.construct()
end
-- setFullscreen is placed here for debuggin purposes
-- love.window.setFullscreen(true, 'desktop') 

local love_handler = require "love_handler"

function love.run()
    return love_handler.construct()
end
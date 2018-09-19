
love.window.setFullscreen(true, 'desktop')

love.graphics.setDefaultFilter('nearest', 'nearest')
local graph = require 'loader'
local game	= require 'game'
local draw  = require 'draw'
local logic = require 'lib/logic'

local screenWidth	 = love.graphics.getWidth()
local screenHeight = love.graphics.getHeight()

local status = 0
local pauseStatus = 'resume'


------------------------------------------------------------------------
--    Original Author run function: https://github.com/Leandros
--		Updated Author run function: https://github.com/jakebesworth
--    MIT License
--    Copyright (c) 2018 Jake Besworth
-- No configurable framerate cap currently, either max frames CPU can handle (up to 1000), or vsync'd if conf.lua
-- 1 / Ticks Per Second
local TICK_RATE = 1 / 100
-- How many Frames are allowed to be skipped at once due to lag (no "spiral of death")
local MAX_FRAME_SKIP = 25

function love.run()
	if love.load then love.load() end
--if love.load then love.load(love.arg.parseGameArguments(arg), arg) end

	-- We don't want the first frame's dt to include time taken by love.load.
	if love.timer then love.timer.step() end

	local lag = 0.0

	-- Main loop time.
	return function()
			-- Process events.
			if love.event then
					love.event.pump()
					for name, a,b,c,d,e,f in love.event.poll() do
							if name == "quit" then
									if not love.quit or not love.quit() then
											return a or 0
									end
							end
							love.handlers[name](a,b,c,d,e,f)
					end
			end

			-- Cap number of Frames that can be skipped so lag doesn't accumulate
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

			-- Even though we limit tick rate and not frame rate, we might want to cap framerate at 1000 frame rate as mentioned https://love2d.org/forums/viewtopic.php?f=4&t=76998&p=198629&hilit=love.timer.sleep#p160881
			if love.timer then love.timer.sleep(1/60) end
	end
end
----------------------------------------------------------

function love.load()
	status = 1
	if status == 1 then
		game.load(screenWidth, screenHeight, graph.sounds.gameMusic)
	end
end

function love.update(dt)
	if status > 0 then
		status = game.play(dt, graph, status, screenWidth, screenHeight)
	end
	if love.keyboard.isDown(graph.keybinds.escape) then love.event.quit() end
end

function love.draw()
	if status > 0 then
		draw.game(graph, game.levels[tostring(status)], game.players, game.bullets)
	elseif status == 'pause' then

	end






	--developer mode
	love.graphics.setColor(1, 1, 1)
	--love.graphics.print("Current FPS: "..tostring(love.timer.getFPS( )), 10, 10)

	--love.graphics.rectangle('fill', screenWidth/2, 0, 1, screenHeight)
end

function showTable(table)
	for index, data in ipairs(table) do
		print(index)

		for key, value in pairs(data) do
			print('\t', key, value)
		end
	end
end

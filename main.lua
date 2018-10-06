--to do
-- verder werken aan main menu (eerst menu text toevoegen aan loader en vervolgens de draw makemn)
--
love.window.setFullscreen(true, 'desktop')

love.graphics.setDefaultFilter('nearest', 'nearest')
local graph = require 'loader'
local game	= require 'game'
local draw  = require 'draw'
local logic = require 'lib/logic'
local menus = require 'menus'

local screenWidth	 = love.graphics.getWidth()
local screenHeight = love.graphics.getHeight()

local previousScreenStatus = nil
local screenStatus = 'mainScreen'
--main menu
--pause menu
--game menu

local pauseStatus = 'resume'
local menuStatus  = 'play'

local currentKey = nil
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
	if screenStatus == 'gameScreen' then
		game.load(screenWidth, screenHeight, graph.sounds.gameMusic)
	end
end

function love.keypressed(key)
	if key ~= currentKey then
		currentKey = key
	end
end

function love.keyreleased(key)
	currentKey = nil
end

function love.update(dt)
	if previousScreenStatus == 'mainScreen' and screenStatus == 'gameScreen' then love.load() end
	previousScreenStatus = screenStatus

	if screenStatus == 'gameScreen' then
		screenStatus = game.play(dt, graph, screenWidth, screenHeight)
		if currentKey == graph.keybinds.escape then screenStatus = 'pauseScreen' end

	elseif screenStatus == 'pauseScreen' then
		pauseStatus  = menus.pauseStatus(currentKey, graph.keybinds, pauseStatus)
		screenStatus = menus.pauseAction(currentKey, graph.keybinds, pauseStatus)

	elseif screenStatus == 'mainScreen' then
		menuStatus   = menus.mainStatus(currentKey, graph.keybinds, menuStatus)
		screenStatus = menus.mainAction(currentKey, graph.keybinds, menuStatus)

	elseif screenStatus == 'quitGame' then love.event.quit() end

end

function love.draw()
	if screenStatus == 'gameScreen' then
		draw.game(graph, game.levels[game.currentLevel], game.players, game.bullets)

	elseif screenStatus == 'pauseScreen' then
		draw.pause(graph.background, graph.text.pause, pauseStatus)

	elseif screenStatus == 'mainScreen' then
		draw.main(graph.background, graph.text.main, menuStatus)
	end






	--developer mode
--	love.graphics.setColor(1, 1, 1)
--	love.graphics.print("Current FPS: "..tostring(love.timer.getFPS( )), 10, 10)

--	love.graphics.rectangle('fill', screenWidth/2, 0, 1, screenHeight)
end

function showTable(table)
	for index, data in ipairs(table) do
		print(index)

		for key, value in pairs(data) do
			print('\t', key, value)
		end
	end
end

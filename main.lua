--BUGS-----
--
	--overal moet previousscreenstatus voor de screenstatus geladen worden. hierdoor crasht hij soms ook:
-- Error: game.lua:32: bad argument #1 to 'pairs' (table expected, got nil)
-- stack traceback:
-- 	[string "boot.lua"]:637: in function <[string "boot.lua"]:633>
-- 	[C]: in function 'pairs'
-- 	game.lua:32: in function 'play'
-- 	main.lua:123: in function 'update'
-- 	main.lua:73: in function <main.lua:53>
-- 	[C]: in function 'xpcall'
--
--TO DO------
--
-- image scaling aanpassen
-- settings video toevoegen
-- background en evt images zelf tekenen in lua
	-- plaatje voor main menu en settings menu maken
	-- knipperende sterren maken en een draaiende maan
-- settings keybinds maken
--
-- hoe werkt de run
--
--
--
--SETTINGS-----
--
love.window.setFullscreen(true, 'desktop')					 --set gamescreen full screen
love.graphics.setDefaultFilter('nearest', 'nearest') --default image filter

local graph    = require 'loader'      --get graphics and sounds
local game     = require 'game'				--load game functions
local draw     = require 'draw'				--load draw function
local menus    = require 'menus'				--load menu functions
local settings = require 'settings' --load settings functions

local screenWidth	 = love.graphics.getWidth()  --total pixels in width
local screenHeight = love.graphics.getHeight() --total pixels in height

local currentKey = nil --current keypress

--previous screens
local preSS = nil
local previousScreenStatus = nil

--current screen
local screenStatus = 'mainScreen' --mainScreen, pauseScreen, settingsScreen, gameScreen

--current statussus in screens
local mainStatus     = 'play'   --play, settings, quit
local settingsStatus = 'audio'  --audio, video, keybinds
local pauseStatus    = 'resume' --quit, resume, settings

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
	settings.setVolume(graph) --set volume
	-- curve = love.math.newBezierCurve({25, 25, 75, 50, 125, 25})
end

function love.keypressed(key) --check key press
	if key ~= currentKey then
		currentKey = key
	end
end

function love.keyreleased(key) --check key release
	currentKey = nil
end


function love.update(dt)
	----
	if screenStatus == 'mainScreen' then
		graph.gameMusic:stop()

		--update selected in main menu
		mainStatus   = menus.mainStatus(currentKey, graph.keybinds, mainStatus)

		--update screenStatus
		previousScreenStatus = 'mainScreen'
		screenStatus = menus.mainAction(currentKey, graph.keybinds, mainStatus)

	-----
	elseif screenStatus == 'pauseScreen' then
		--update selected in pause menu
		pauseStatus  = menus.pauseStatus(currentKey, graph.keybinds, pauseStatus)

		--update screenStatus
		previousScreenStatus = screenStatus
		screenStatus = menus.pauseAction(currentKey, graph.keybinds, pauseStatus)

	-----
	elseif screenStatus == 'gameScreen' then
		--play music if previous game
		if previousScreenStatus == 'mainScreen' then
			graph.gameMusic:play()
			game.load(screenWidth, screenHeight) end

		previousScreenStatus = screenStatus
		screenStatus = game.play(dt, graph, screenWidth, screenHeight)

		if currentKey == graph.keybinds.escape then screenStatus = 'pauseScreen' end


	elseif screenStatus == 'settingsScreen' then
		settingsStatus = menus.settingsStatus(currentKey, graph.keybinds, settingsStatus)
		settingsText   = settings.settingsAction(currentKey, graph, settingsStatus)

		if screenStatus ~= previousScreenStatus then
			preSS = previousScreenStatus
			if preSS == 'pauseScreen' then pauseStatus = 'resume'	end
		end
		previousScreenStatus = screenStatus
		screenStatus = menus.settingsAction(currentKey, graph.keybinds, preSS, settingsStatus)

	elseif screenStatus == 'quitGame' then love.event.quit()

	else screenStatus = 'mainScreen' end

end

function love.draw()
	if screenStatus == 'gameScreen' then
		draw.game(graph, game.levels[game.currentLevel], game.players, game.bullets)

	elseif screenStatus == 'pauseScreen' then
		draw.screen(graph.background, graph.fontImage, graph.text[screenStatus], pauseStatus,
								screenWidth)

	elseif screenStatus == 'mainScreen' then
		draw.screen(graph.background, graph.fontImage, graph.text[screenStatus], mainStatus,
								screenWidth)

	elseif screenStatus == 'settingsScreen' then
		draw.screen(graph.background, graph.fontImage, graph.text[screenStatus], settingsStatus,
								screenWidth)
		draw.text(settings.text['volume'], graph.fontImage, settingsStatus, screenWidth)
		--draw.settings(graph.background, graph.text.settings, settingsStatus)
	end

	--developer mode


	-- love.graphics.line(curve:render())
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

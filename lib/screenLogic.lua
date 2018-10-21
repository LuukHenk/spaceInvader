local positions = {}
local fontTitleSize = 70
local fontTextSize = 40

function positions.generateMain(text, fontImage, screenWidth)
	local play     = {}
	local settings = {}
	local quit		 = {}

	local mainPositions = {}
	for _, t in pairs(text) do

		if t.mode == 'space' then

			mainPositions[t.mode] = setPositions(t.str, screenWidth, fontImage, fontTitleSize,																					  'center', 100)

		elseif t.mode == 'play' then
			mainPositions[t.mode] = setPositions(t.str, screenWidth, fontImage, fontTextSize,																					    'center', 300)

		elseif t.mode == 'settings' then
			mainPositions[t.mode] = setPositions(t.str, screenWidth, fontImage, fontTextSize,																					    'center', 360)

		elseif t.mode == 'quit' then
			mainPositions[t.mode] = setPositions(t.str, screenWidth, fontImage, fontTextSize,																					    'center', 420)
		end
	end

	return mainPositions
end

function setPositions(text, screenWidth, fontImage, fontSize, x, y)
	local font = love.graphics.setNewFont(fontImage, fontSize)

	local object = {}

	if x == 'center' then object.x = screenWidth / 2 - font:getWidth(text) / 2
	else object.x = x end
	object.y = y

	return object
end

function positions.generatePause(text, font, screenWidth)
	local resume = {}
	local settings = {}
	local pause = {}
	local quit = {}
	for _, t in pairs(text) do
		if t.mode == 'pause' then
			pause.scaleX = 0
			pause.scaleY = 6
			pause.x			 = screenWidth / 2 - t.len * pause.scaleY / 2
			pause.y			 = 100

		elseif t.mode == 'resume' then
			resume.scaleX = 0
			resume.scaleY = 3
			resume.x			= screenWidth / 2 - t.len * resume.scaleY / 2
			resume.y			= 300

		elseif t.mode == 'settings' then
			settings.scaleX = 0
			settings.scaleY = 3
			settings.x		  = screenWidth / 2 - t.len * settings.scaleY / 2
			settings.y      = 360

		elseif t.mode == 'quit' then
			quit.scaleX = 0
			quit.scaleY = 3
			quit.x			= screenWidth / 2 - t.len * quit.scaleY / 2
			quit.y			= 420
		end
	end

	local pausePositions = {}
	pausePositions['pause']  = pause
	pausePositions['quit']   = quit
	pausePositions['settings'] = settings
	pausePositions['resume'] = resume
	return pausePositions
end

function positions.generateSettings(text, font, screenWidth)
	local settings = {}
	local audio    = {}
	local volume   = {}
	local video    = {}
	local keybinds = {}
	local quit     = {}

	for _, t in pairs(text) do
		if t.mode == 'settings' then
			settings.scaleX = 0
			settings.scaleY = 6
			settings.x      = screenWidth / 2 - t.len * settings.scaleY / 2
			settings.y      = 100

		elseif t.mode == 'audio' then
			audio.scaleX = 0
			audio.scaleY = 3
			audio.x      = screenWidth / 2 - t.len * audio.scaleY / 2
			audio.y      = 300

		elseif t.mode == 'volume' then
			volume.scaleX = 0
			volume.scaleY = 3
			volume.x      = screenWidth / 2 - t.len * volume.scaleY / 2
			volume.y      = 360

		elseif t.mode == 'video' then
			video.scaleX = 0
			video.scaleY = 3
			video.x      = screenWidth / 2 - t.len * video.scaleY / 2
			video.y      = 420

		elseif t.mode == 'keybinds' then
			keybinds.scaleX = 0
			keybinds.scaleY = 3
			keybinds.x      = screenWidth / 2 - t.len * keybinds.scaleY / 2
			keybinds.y      = 480

		elseif t.mode == 'quit' then
			quit.scaleX = 0
			quit.scaleY = 3
			quit.x			= screenWidth / 2 - t.len * quit.scaleY / 2
			quit.y			= 540
		end
	end

	local settingsPositions = {}
	settingsPositions['settings'] = settings
	settingsPositions['audio']    = audio
	settingsPositions['volume']   = volume
	settingsPositions['video']    = video
	settingsPositions['keybinds'] = keybinds
	settingsPositions['quit']     = quit
	return settingsPositions
end
return positions

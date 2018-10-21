local setup = {}
local scaleMultiply = 6

function generateText()
	local screenWidth = love.graphics.getWidth()
	local text = {}

	text['mainScreen']     = {}
	text['pauseScreen']    = {}
	text['settingsScreen'] = {}

	local	mainScreen = {}

	mainScreen.spaceText      = {}
	mainScreen.spaceText.mode = 'space'
	mainScreen.spaceText.str	= 'Space Invaders'
	mainScreen.spaceText.size = 100
	mainScreen.spaceText.x    = 'center'
	mainScreen.spaceText.y    = 100

	mainScreen.playText      = {}
	mainScreen.playText.mode = 'play'
	mainScreen.playText.str  = 'Play game'
	mainScreen.playText.size = 40
	mainScreen.playText.x    = 'center'
	mainScreen.playText.y    = 300

	mainScreen.settingsText      = {}
	mainScreen.settingsText.mode = 'settings'
	mainScreen.settingsText.str  = 'Settings'
	mainScreen.settingsText.size = 40
	mainScreen.settingsText.x    = 'center'
	mainScreen.settingsText.y    = 360

	mainScreen.quitText      = {}
	mainScreen.quitText.mode = 'quit'
	mainScreen.quitText.str  = 'Quit game'
	mainScreen.quitText.size = 40
	mainScreen.quitText.x    = 'center'
	mainScreen.quitText.y    = 420

	text['mainScreen'] = mainScreen

	--------------------------------

	local pauseScreen = {}

	pauseScreen.pauseText      = {}
	pauseScreen.pauseText.mode = 'pause'
	pauseScreen.pauseText.str  = 'Pause'
	pauseScreen.pauseText.size = 70
	pauseScreen.pauseText.x    = 'center'
	pauseScreen.pauseText.y    = 100

	pauseScreen.quitText      = {}
	pauseScreen.quitText.mode = 'quit'
	pauseScreen.quitText.str  = 'Quit game'
	pauseScreen.quitText.size = 40
	pauseScreen.quitText.x    = 'center'
	pauseScreen.quitText.y    = 300

	pauseScreen.resumeText      = {}
	pauseScreen.resumeText.mode = 'resume'
	pauseScreen.resumeText.str  = 'Resume'
	pauseScreen.resumeText.size = 40
	pauseScreen.resumeText.x    = 'center'
	pauseScreen.resumeText.y    = 360

	pauseScreen.settingsText      = {}
	pauseScreen.settingsText.mode = 'settings'
	pauseScreen.settingsText.str  = 'Settings'
	pauseScreen.settingsText.size = 40
	pauseScreen.settingsText.x    = 'center'
	pauseScreen.settingsText.y    = 420

	text['pauseScreen'] = pauseScreen

	--------------------------------

	local settingsScreen = {}

	settingsScreen.settingsText      = {}
	settingsScreen.settingsText.mode = 'settings'
	settingsScreen.settingsText.str  = 'Settings'
	settingsScreen.settingsText.size = 70
	settingsScreen.settingsText.x    = 'center'
	settingsScreen.settingsText.y    = 100

	settingsScreen.audioText      = {}
	settingsScreen.audioText.mode = 'audio'
	settingsScreen.audioText.str  = 'Volume'
	settingsScreen.audioText.size = 40
	settingsScreen.audioText.x    = 'center'
	settingsScreen.audioText.y    = 300

	--volumeText is made in settings menu at position.x 360

	settingsScreen.videoText      = {}
	settingsScreen.videoText.mode = 'video'
	settingsScreen.videoText.str  = 'Video'
	settingsScreen.videoText.size = 40
	settingsScreen.videoText.x    = 'center'
	settingsScreen.videoText.y    = 420

	settingsScreen.keybindsText      = {}
	settingsScreen.keybindsText.mode = 'keybinds'
	settingsScreen.keybindsText.str  = 'Keybinds'
	settingsScreen.keybindsText.size = 40
	settingsScreen.keybindsText.x    = 'center'
	settingsScreen.keybindsText.y    = 480

	settingsScreen.quitText      = {}
	settingsScreen.quitText.mode = 'quit'
	settingsScreen.quitText.str  = 'Return'
	settingsScreen.quitText.size = 40
	settingsScreen.quitText.x    = 'center'
	settingsScreen.quitText.y    = 540

	text['settingsScreen'] = settingsScreen

	return text
end

function createBackground(backgroundImage)
	local	background = {}
	background.image = love.graphics.newImage(backgroundImage)
	background.imageScaleX, background.imageScaleY = getScaling(background.image)
	return background
end

function getScaling(drawable, canvas)
	local canvas = canvas or nil
	local drawW = drawable:getWidth()
	local drawH = drawable:getHeight()
	local canvasW = 0
	local canvasH = 0

if canvas then
		canvasW = canvas:getWidth()
		canvasH = canvas:getHeight()
	else
		canvasW = love.graphics.getWidth()
		canvasH = love.graphics.getHeight()
	end

	local scaleX = canvasW / drawW
	local scaleY = canvasH / drawH
	return scaleX, scaleY
end

setup.objects = {}
local player = {}
player.mode = 'player'
player.bulletMode = 'fill'
player.bulletR = 1
player.bulletG = 1
player.bulletB = 1

player.imageScaleX = 0
player.imageScaleY = 8
player.image       = love.graphics.newImage('images/player.png')
player.fireSound   = love.audio.newSource('sounds/Laser2.wav', 'static')
player.fireSoundVol = 0.2
player.dieSound    = love.audio.newSource('sounds/Explosion.wav', 'static')
player.dieSoundVol = 1

setup.objects['player'] = player

local normal = {}
normal.mode = 'normal'
normal.bulletMode = 'fill'
normal.bulletR = 1
normal.bulletG = 0
normal.bulletB = 1

normal.imageScaleX = 0
normal.imageScaleY = 8
normal.image       = love.graphics.newImage('images/enemy.png')
normal.fireSound   = love.audio.newSource('sounds/Randomize4.wav', 'static')
normal.fireSoundVol = 0.2
normal.dieSound    = love.audio.newSource('sounds/Randomize.wav', 'static')
normal.dieSoundVol = 0.8

setup.objects['normal'] = normal

local fast = {}

fast.mode = 'fast'
fast.bulletMode = 'fill'
fast.bulletR = 1
fast.bulletG = 0
fast.bulletB = 1

fast.imageScaleX = 0
fast.imageScaleY = 8
fast.image       = love.graphics.newImage('images/fast.png')
fast.fireSound   = love.audio.newSource('sounds/Randomize4.wav', 'static')
fast.fireSoundVol = 0.1
fast.dieSound    = love.audio.newSource('sounds/Randomize.wav', 'static')
fast.dieSoundVol = 0.4

setup.keybinds = {}
setup.keybinds.escape = 'escape'
setup.keybinds.shoot  = 'space'
setup.keybinds.enter  = 'return'
setup.keybinds.pause  = 'p'
setup.keybinds.right  = 'right'
setup.keybinds.left   = 'left'
setup.keybinds.up     = 'up'
setup.keybinds.down   = 'down'

setup.gameMusic = love.audio.newSource('sounds/background.mp3', 'stream')
setup.gameMusicVol = 1
setup.background = createBackground('images/background.png')

setup.text = generateText()
setup.fontImage = 'fonts/press-start/prstart.ttf'

return setup

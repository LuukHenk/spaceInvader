local setup = {}
local scaleMultiply = 6

function generateText(font)
	local screenWidth = love.graphics.getWidth()
	local text = {}

	--Winning text
	local winningText				 = {}
	winningText.str    = 'You have won the game!\nPress Esc to exit the game.'
	winningText.len    = font:getWidth(winningText.str)
	winningText.x      = screenWidth / 2 - winningText.len / 6 - 300
	winningText.y      = 100
	winningText.scaleX = 0
	winningText.scaleY = 3

	text.win         = {}
	table.insert(text.win, winningText)

	--gameOver text
	local	gameOverText	= {}
	gameOverText.str		= 'Game Over!\nPress the Esc to exit the game.'
	gameOverText.len		= font:getWidth(gameOverText.str)
	gameOverText.x      = screenWidth / 2 - gameOverText.len / 6 - 300
	gameOverText.y      = 100
	gameOverText.scaleX = 0
	gameOverText.scaleY = 3

	text.lost		  		 = {}
	table.insert(text.lost, gameOverText)
	--pause text

	local	resumeText  = {}
	resumeText.mode   = 'resume'
	resumeText.str		= 'Resume game'
	resumeText.len		= font:getWidth(resumeText.str)
	resumeText.scaleX = 0
	resumeText.scaleY = 3
	resumeText.x			= screenWidth / 2 - resumeText.len * resumeText.scaleY / 2
	resumeText.y			=	540

	local quitText  = {}
	quitText.mode   = 'quit'
	quitText.str		= 'Quit game'
	quitText.len		= font:getWidth(quitText.str)
	quitText.scaleX = 0
	quitText.scaleY = 3
	quitText.x			= screenWidth / 2 - quitText.len * quitText.scaleY / 2
	quitText.y			=	480

	text.pause				   = {}
	table.insert(text.pause, resumeText)
	table.insert(text.pause, quitText)

	--menu text
	local titleText  = {}
	titleText.mode   = 'title'
	titleText.str		 = 'Space Invaders'
	titleText.len		 = font:getWidth(titleText.str)
	titleText.scaleX = 0
	titleText.scaleY = 10
	titleText.x			 = screenWidth / 2 - titleText.len * titleText.scaleY / 2
	titleText.y			 =	100

	local playText  = {}
	playText.mode   = 'play'
	playText.str 	  = 'Play game'
	playText.len	  = font:getWidth(playText.str)
	playText.scaleX = 0
	playText.scaleY = 3
	playText.x			= screenWidth / 2 - playText.len * playText.scaleY / 2
	playText.y			=	300

	local settingsText  = {}
	settingsText.mode   = 'settings'
	settingsText.str		= 'Settings'
	settingsText.len	  = font:getWidth(settingsText.str)
	settingsText.scaleX = 0
	settingsText.scaleY = 3
	settingsText.x			= screenWidth / 2 - settingsText.len * settingsText.scaleY / 2
	settingsText.y			=	360

	local exitText  = {}
	exitText.mode   = 'exit'
	exitText.str		= 'Quit'
	exitText.len	  = font:getWidth(exitText.str)
	exitText.scaleX = 0
	exitText.scaleY = 3
	exitText.x			= screenWidth / 2 - exitText.len * exitText.scaleY / 2
	exitText.y			=	420

	text.main = {}
	table.insert(text.main, titleText)
	table.insert(text.main, playText)
	table.insert(text.main, settingsText)
	table.insert(text.main, exitText)

	return text
end

function getSounds()
	local	sounds = {}
	sounds.gameMusic = love.audio.newSource('sounds/background.mp3', 'stream')
	return sounds
end

function createBackground(backgroundImage)
	local	background = {}
	background.image = love.graphics.newImage(backgroundImage)
	background.imageScaleX, background.imageScaleY = getScaling(background.image)
	return background
end

function setFont(image)
	local font = love.graphics.newImageFont(image,
	    " abcdefghijklmnopqrstuvwxyz" ..
	    "ABCDEFGHIJKLMNOPQRSTUVWXYZ0" ..
	    "123456789.,!?-+/():;%&`'*#=[]\"")
	love.graphics.setFont(font)
	return font
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
player.bulletMode = 'fill'
player.bulletR = 1
player.bulletG = 1
player.bulletB = 1

player.imageScaleX = 0
player.imageScaleY = 8
player.image       = love.graphics.newImage('images/player.png')
player.fireSound   = love.audio.newSource('sounds/Laser2.wav', 'static')
player.dieSound    = love.audio.newSource('sounds/Explosion.wav', 'static')

setup.objects['player'] = player

local normal = {}
normal.bulletMode = 'fill'
normal.bulletR = 1
normal.bulletG = 0
normal.bulletB = 1

normal.imageScaleX = 0
normal.imageScaleY = 8
normal.image       = love.graphics.newImage('images/enemy.png')
normal.fireSound   = love.audio.newSource('sounds/Randomize4.wav', 'static')
normal.dieSound    = love.audio.newSource('sounds/Randomize.wav', 'static')

setup.objects['normal'] = normal

setup.keybinds = {}
setup.keybinds.escape = 'escape'
setup.keybinds.shoot  = 'space'
setup.keybinds.enter  = 'return'
setup.keybinds.pause  = 'p'
setup.keybinds.right  = 'right'
setup.keybinds.left   = 'left'
setup.keybinds.up     = 'up'
setup.keybinds.down   = 'down'

setup.background = createBackground('images/background.png')
setup.text			 = generateText(setFont('images/fontText.png'))
setup.sounds		 = getSounds()
return setup

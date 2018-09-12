local setup = {}

function generateText(font)
	local screenWidth = love.graphics.getWidth()
	local text = {}

	--Game text
	text.win        = {}
	text.win.str    = 'You have won the game!\nPress Esc to exit the game.'
	text.win.len    = font:getWidth(text.win.str)
	text.win.x      = screenWidth / 2 - text.win.len / 6 - 300
	text.win.y      = 100
	text.win.scaleX = 0
	text.win.scaleY = 3

	text.lost        = {}
	text.lost.str    = 'Game Over!\nPress the Esc to exit the game.'
	text.lost.len    = font:getWidth(text.lost.str)
	text.lost.x      = screenWidth / 2 - text.lost.len / 6 - 300
	text.lost.y      = 100
	text.lost.scaleX = 0
	text.lost.scaleY = 3

	--pause text
	text.resumeButton    = 'Resume game'
	text.lenResumeButton = font:getWidth(text.resumeButton)
	text.quitButton      = 'Quit game'
	text.lenQuitButton   = font:getWidth(text.quitButton)
	text.line	     = '---------'

	--menu text
	text.title             = 'Space Invaders'
	text.lenTitle 	       = font:getWidth(text.title)
	text.playGameButton    = 'Play game'
	text.lenPlayGameButton = font:getWidth(text.playGameButton)
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

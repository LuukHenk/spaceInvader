love.window.setFullscreen(true, 'desktop')
screenWidth  = love.graphics.getWidth()
screenHeight = love.graphics.getHeight()

function love.load()
	gameOver = false
	gameWin  = false

	graph  = generateGraphics()
	player = createPlayer()
	enemyC = createEnemies(10)
	keys   = setKeybinds()
end

--------------------------------------------graphics and audio functions
--
function generateGraphics(fullscreen)
	graph = {}
	love.audio.play(love.audio.newSource('sounds/background.mp3', 'stream'))
	love.graphics.setDefaultFilter('nearest', 'nearest')
	graph.background = createBackground('images/background.png')	
	graph.text = generateText(setFont('images/fontText.png')) 
	return graph
end

function generateText(font)
	text = {}
	text.winning   	 = '  You have won the game!\nPress Esc to exit the game.'
	text.lenWinning  = font:getWidth(text.winning)
	text.gameOver    = '\t\t Game Over!\nPress the Esc to exit the game.'
	text.lenGameOver = font:getWidth(text.gameOver)
	return text
end

function createBackground(backgroundImage)
	background = {}
	background.image = love.graphics.newImage(backgroundImage)
	background.imageScaleX, background.imageScaleY = getScaling(background.image)
	return background
end

function setFont(image)
	font = love.graphics.newImageFont(image,
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

--------------------------------------------player functions
--
function createPlayer()
	player = {}
	player.width     = 130
	player.height    = 60
	player.y = screenHeight - player.height
	player.x = screenWidth / 2 - player.width / 2

	player.outlines  = {}
	player.outlines['up']    = 24
	player.outlines['down']  = 50
	player.outlines['left']  = 7
	player.outlines['right'] = 112

	player.speed = 1

	player.controller = {}

	player.controller.image = love.graphics.newImage('images/player.png')

	player.controller.bullets      = {}
	player.controller.bulletX      = player.width / 2 - 6
	player.controller.bulletY      = 0
	player.controller.bulletSpeed  = -1
	player.controller.cooldown     = 0
	player.controller.cooldownTime = 250

	player.controller.fireSound = love.audio.newSource('sounds/Laser2.wav', 'static')
	player.controller.fireSound:setVolume(0.1)
	player.controller.dieSound  = love.audio.newSource('sounds/Explosion.wav', 'static')
	player.controller.dieSound:setVolume(0.9)
	return player
end

function createEnemies(totalEnemies)
	enemiesController           = {}
	enemiesController.enemies   = {}
	
	enemiesController.width    = 56
	enemiesController.height   = 72

	for i = 1, totalEnemies do
		enemiesController.enemies = createEnemy(
		screenWidth / totalEnemies * i - 1500 / totalEnemies, 0, 
		enemiesController.enemies
		)
	end
	
	enemiesController.bullets      = {}
	enemiesController.bulletX      = enemiesController.width / 2 + 22
	enemiesController.bulletY      = 50
	enemiesController.bulletSpeed  = 0.2
	enemiesController.cooldown     = 0
	enemiesController.cooldownTime = 800

	enemiesController.image     = love.graphics.newImage('images/enemy.png')
	enemiesController.fireSound = love.audio.newSource('sounds/Randomize4.wav', 'static')
	enemiesController.fireSound:setVolume(0.1)
	enemiesController.dieSound  = love.audio.newSource('sounds/Randomize.wav', 'static')
	enemiesController.dieSound:setVolume(0.4)	
	return enemiesController
end

function createEnemy(x, y, enemies)
	enemy          = {}
	enemy.x	       = x
	enemy.y        = y
	
	enemy.outlines  = {}
	enemy.outlines['up']    = 15
	enemy.outlines['down']  = 88
	enemy.outlines['left']  = 22
	enemy.outlines['right'] = 88
	

	enemy.speed    = 0.05
	table.insert(enemies, enemy)
	return enemies
end

function setKeybinds()
	keybinds = {}
	keybinds.escape = 'escape'
	keybinds.right  = 'right'
	keybinds.left   = 'left'
	keybinds.shoot  = 'space'
	return keybinds
end

--------------------------------------------game functions
--
function checkCollisions(target, bullets)
	for _,b in pairs(bullets) do
		if  b.y >= target.y + target.outlines['up']   
		and b.y <= target.y + target.outlines['down'] 
		and b.x >= target.x + target.outlines['left'] 
		and b.x <= target.x + target.outlines['right'] then
			return true
		end
	end
end

function fire(shooter, controller)
	controller.fireSound:stop()
	controller.fireSound:play()
	controller.cooldown = controller.cooldownTime
	bullet = {}
	bullet.x = shooter.x + controller.bulletX
	bullet.y = shooter.y + controller.bulletY
	table.insert(controller.bullets, bullet)
	return controller 
end

function bulletMovement(bullets, controller)
	for i, b in pairs(bullets) do
		b.y = b.y + controller.bulletSpeed
		if b.y > screenHeight - 10 or b.y < -10 then
			table.remove(controller.bullets, i)
		end
	end
	return controller.bullets
end

function checkEnemyCollisions()
	if #enemyC.enemies > 0 then
		for i,e in ipairs(enemyC.enemies) do
			if checkCollisions(e, player.controller.bullets) then
				enemyC.dieSound:stop()
				enemyC.dieSound:play()
				table.remove(enemyC.enemies, i)

			elseif e.y >= screenHeight - 90 then
				player.controller.dieSound:play()
				gameOver = true
			end
		end
	else
		gameWin = true
	end
end

function checkPlayerCollisions()
	if checkCollisions(player, enemyC.bullets) then
		player.controller.dieSound:play()
		gameOver = true
		table.remove(player)
	end
end

function enemyShooting()
	if enemyC.cooldown <= 0 and #enemyC.enemies > 0 then
		shooter = enemyC.enemies[math.random(#enemyC.enemies)]
		fire(shooter, enemyC)
	end
end

function enemyMovement()
	for _,e in pairs(enemyC.enemies) do
		e.y = e.y + e.speed
	end
end

function checkKeypressInGame()
	if love.keyboard.isDown(keys.escape) then
		love.event.quit()
	end

	if love.keyboard.isDown(keys.right) 
	and player.x <= screenWidth - player.width + 20 then
		player.x = player.x + player.speed
	end

	if love.keyboard.isDown(keys.left) and player.x >= -20 then
		player.x = player.x - player.speed
	end

	if love.keyboard.isDown(keys.shoot) and player.controller.cooldown <= 0 then
		fire(player, player.controller)
	end
end

function love.update(dt)
	checkEnemyCollisions()
	checkPlayerCollisions()	

	checkKeypressInGame()
	
	enemyShooting()
	enemyMovement()

	player.controller.bullets = bulletMovement(player.controller.bullets, player.controller)
	enemyC.bullets            = bulletMovement(enemyC.bullets, enemyC)

	player.controller.cooldown = player.controller.cooldown - 1
	enemyC.cooldown		   = enemyC.cooldown -1
end

function love.draw()
	love.graphics.setColor(1, 1, 1)
	love.graphics.draw(graph.background.image, 
	0, 0, 0, graph.background.imageScaleX, graph.background.imageScaleY)

	if gameOver then
		love.graphics.setColor(1, 1, 1)
		love.graphics.print(graph.text.gameOver,
		screenWidth / 2 - graph.text.lenGameOver / 6 - 300, 100, 0, 3)
		return

	elseif gameWin then
		love.graphics.setColor(1, 1, 1)
		love.graphics.print(graph.text.winning,
		screenWidth / 2 - graph.text.lenWinning / 6 - 300, 100, 0, 3)
		return
	else
		love.graphics.setColor(1, 1, 1)
		for _,b in pairs(player.controller.bullets) do
			love.graphics.rectangle('fill', b.x, b.y, 10, 10)
		end

		love.graphics.setColor(1, 0, 1)
		for _,b in pairs(enemyC.bullets) do
			love.graphics.rectangle('fill', b.x, b.y, 10, 10)
		end
	
		love.graphics.setColor(1, 1, 1)
		love.graphics.draw(player.controller.image, player.x, player.y, 0, 8)

		love.graphics.setColor(1, 1, 1)
		for _,e in pairs(enemyC.enemies) do
			love.graphics.draw(enemyC.image, e.x, e.y, 0, 8)
		end
	end
end

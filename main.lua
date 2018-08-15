
--Screen setup
love.window.setFullscreen(true, "desktop")
love.graphics.setDefaultFilter('nearest', 'nearest')
screenWidth  = love.graphics.getWidth()
screenHeight = love.graphics.getHeight()


--enemy setup
--standerd = 10
totalEnemies = 20
enemy        = {}


enemiesController           = {}
enemiesController.enemies   = {}
enemiesController.image     = love.graphics.newImage('images/enemy.png')
enemiesController.fireSound = love.audio.newSource('sounds/Randomize4.wav', 'static')
enemiesController.fireSound:setVolume(0.1)
enemiesController.dieSound  = love.audio.newSource('sounds/Randomize.wav', 'static')
enemiesController.dieSound:setVolume(0.4)

function love.load()
	gameOver = false
	gameWin  = false
	
	--background and audio setup
	love.audio.play(love.audio.newSource('sounds/background.mp3', 'stream'))
	
	background = love.graphics.newImage('images/background.png')
	imageScaleX, imageScaleY = getScaling(background)
		
	--font setup
	font = love.graphics.newImageFont('images/fontText.png',
	    " abcdefghijklmnopqrstuvwxyz" ..
	    "ABCDEFGHIJKLMNOPQRSTUVWXYZ0" ..
	    "123456789.,!?-+/():;%&`'*#=[]\"")
	love.graphics.setFont(font)
	winningText  = '  You have won the game!\nPress Esc to exit the game.'
	gameOverText = '\t\t Game Over!\nPress the Esc to exit the game.'
	
	winningTextLen  = font:getWidth(winningText)
	gameOverTextLen = font:getWidth(gameOverText)

	--player setup
	player           = {}
	player.width     = 130
	player.height    = 60
	player.y         = screenHeight - 60
	player.x         = screenWidth / 2 - player.width / 2
	player.speed     = 1
	player.image 	 = love.graphics.newImage('images/player.png')
	player.fireSound = love.audio.newSource('sounds/Laser2.wav', 'static')
	player.fireSound:setVolume(0.1)
	player.dieSound  = love.audio.newSource('sounds/Explosion.wav', 'static')
	player.dieSound:setVolume(0.9)
	player.cooldown  = 250
	player.bullets   = {}
	player.fire = function()
		if player.cooldown <= 0 then
			player.fireSound:play()
			player.cooldown = 250
			bullet = {}
			bullet.x = player.x + player.width / 2 - 6
			bullet.y = player.y 
			table.insert(player.bullets, bullet)
		end
	end

	--spawn enemies
	for i = 1, totalEnemies do
		enemiesController:spawnEnemy(screenWidth / totalEnemies * i - 1500 / totalEnemies, 0)
	end
end


------------------------------------------
--enemy spawner
function enemiesController:spawnEnemy(x, y)
	enemy          = {}
	enemy.width    = 56
	enemy.height   = 72	
	enemy.x	       = x
	enemy.y        = y
	enemy.bullets  = {}
	enemy.cooldown = 1000
	enemy.speed    = 0.05	
	enemies        = {}
	table.insert(self.enemies, enemy)
end

--enemy shooter
function fire(enemies)
	enemy.cooldown = 10000 / #enemies
	shootingE = enemies[math.random(#enemies)]
	bullet = {}
	bullet.x = shootingE.x + shootingE.width -6
	bullet.y = shootingE.y + 40
	table.insert(enemy.bullets, bullet)
end

--collision with enemies
function checkCollisions(enemies, bullets)
	for i,e in ipairs(enemies) do
		for _,b in pairs(bullets) do
			if b.y <= (e.y + 16) + 72 and b.x > (e.x + 20) and b.x < (e.x + 32) + 56 then
				enemiesController.dieSound:play()	
				table.remove(enemies, i)
			end
		end
	end
end

--collision with player
function checkCollisionsPlayer(player, enemy)
	for _,b in pairs(enemy.bullets) do
		if b.y >= player.y + 25 and b.x > player.x -7 and b.x < player.x + player.width then
			player.dieSound:play()
			gameOver = true
		end
	end
end

--background scaling
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


-----------------------------------------------------------------------------
function love.update(dt)
	player.cooldown = player.cooldown - 1
	enemy.cooldown = enemy.cooldown - 1
	
	checkCollisions(enemiesController.enemies, player.bullets)
	checkCollisionsPlayer(player, enemy)

	if love.keyboard.isDown("escape") then
		love.event.quit()
	end

	if love.keyboard.isDown("right") then 
		player.x = player.x + player.speed                                                   
	end
        if love.keyboard.isDown("left") then                                                         
                player.x = player.x - player.speed                                                  
	end

	--bullet shooting
        if love.keyboard.isDown("space") then                                                        
                player.fire()                                                                        
        end
	
	for i, b in ipairs(player.bullets) do
		b.y = b.y - 1

		if b.y < -10 then
			table.remove(player.bullets, i)
		end
	end

	--enemy movement
	for _,e in pairs(enemiesController.enemies) do
		if e.y >= screenHeight - 90 then
			player.dieSound:play()
			gameOver = true
		end

		e.y = e.y + e.speed
	end

	--enemy shooting
	if (enemy.cooldown <= 0 and #enemiesController.enemies > 0) then
		enemiesController.fireSound:play()
		fire(enemiesController.enemies)
	end
	
	for i, b in ipairs(enemy.bullets) do 
		b.y = b.y + 0.1	
		if b.y > screenHeight - 10 then
			table.remove(enemy.bullets, i)
		end
	end

	--win game
	if #enemiesController.enemies == 0 then
		gameWin = true
	end
end


-------------------------------------------------------------------
function love.draw()
	--draw background
	love.graphics.draw(background, 0, 0, 0, imageScaleX, imageScaleY)

	--game win/loss
	if gameOver then
		love.graphics.print(gameOverText, screenWidth / 2 - gameOverTextLen / 6 - 300, 100, 0, 3)
		return
	elseif gameWin then 
		love.graphics.print(winningText, screenWidth / 2 - winningTextLen / 6 - 300, 100, 0, 3)
		return
	end

	--Draw player
	love.graphics.setColor(1, 1, 1)
--	love.graphics.rectangle('fill', player.x, player.y + 25, player.width, player.height)
	love.graphics.draw(player.image, player.x, player.y, 0, 8)
	
	--Draw bullets
	love.graphics.setColor(1, 1, 1)
	for _,b in pairs(player.bullets) do
		love.graphics.rectangle('fill', b.x, b.y, 10, 10)
	end
	love.graphics.setColor(1, 0, 1)
	for _,b in pairs(enemy.bullets) do 
		love.graphics.rectangle('fill', b.x, b.y, 10, 10)
	end
	
	--Draw enemy
	love.graphics.setColor(1, 1, 1)
	for _,e in pairs(enemiesController.enemies) do
--		love.graphics.rectangle('fill', e.x + 32, e.y + 16, 56, 72)
		love.graphics.draw(enemiesController.image, e.x, e.y, 0, 8)
	end

--------------------------------------------------K
	--developer mode
	love.graphics.print(player.x, 10, 15)
	love.graphics.print(enemy.cooldown, 10, 45)
	love.graphics.print(#enemiesController.enemies, 10, 60)
end

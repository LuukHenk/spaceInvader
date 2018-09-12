local controllers = {}

function controllers.createEnemyController()
	local enemiesController = {}

	enemiesController.width  = 56
	enemiesController.height = 72

	enemiesController.speed = 40

	enemiesController.bullets      = {}
	enemiesController.bulletSpeed  = 200
	enemiesController.bulletX      = enemiesController.width / 2 + 22
	enemiesController.bulletY      = 50
	enemiesController.bulletMode   = 'fill'
	enemiesController.bulletWidth  = 10
	enemiesController.bulletHeight = 10

	enemiesController.bulletR	= 1
	enemiesController.bulletG = 0
	enemiesController.bulletB = 1

	enemiesController.cooldown     = 0
	enemiesController.cooldownTime = 0.8

	enemiesController.imageScaleX = 0
	enemiesController.imageScaleY = 8
	enemiesController.image       = love.graphics.newImage('images/enemy.png')

	enemiesController.fireSound = love.audio.newSource('sounds/Randomize4.wav', 'static')
	enemiesController.fireSound:setVolume(0.1)
	enemiesController.dieSound  = love.audio.newSource('sounds/Randomize.wav', 'static')
	enemiesController.dieSound:setVolume(0.4)
	return enemiesController
end

function controllers.createPlayerController()
	local	playerController = {}

	playerController.width  = 130
	playerController.height = 60

	playerController.bullets      = {}
	playerController.bulletSpeed  = -350
	playerController.bulletX      = playerController.width / 2 - 6
	playerController.bulletY      = 0
	playerController.bulletMode   = 'fill'
	playerController.bulletWidth  = 10
	playerController.bulletHeight = 10

	playerController.bulletR = 1
	playerController.bulletG = 1
	playerController.bulletB = 1

	playerController.cooldown     = 0
	playerController.cooldownTime = 0.5

	playerController.imageScaleX = 0
	playerController.imageScaleY = 8
	playerController.image       = love.graphics.newImage('images/player.png')
	playerController.fireSound = love.audio.newSource('sounds/Laser2.wav', 'static')
	playerController.fireSound:setVolume(0.1)
	playerController.dieSound  = love.audio.newSource('sounds/Explosion.wav', 'static')
	playerController.dieSound:setVolume(0.9)
	return playerController
end

function controllers.createPlayers(c, screenWidth, screenHeight)
	local	players = {}
	table.insert(players, createPlayer(screenWidth, screenHeight, c.width, c.height))
	return players
end

function createPlayer(screenWidth, screenHeight, playerHeight, playerWidth)
	local	player = {}
	player.y = screenHeight - playerHeight / 2
	player.x = screenWidth / 2 - playerWidth / 2

	player.outlines  = {}
	player.outlines['up']    = 24
	player.outlines['down']  = 50
	player.outlines['left']  = 7
	player.outlines['right'] = 112

	player.speed = 600

	return player
end

function controllers.createEnemies(totalEnemies, screenWidth, screenHeight)
	local	enemies   = {}

	for i = 1, totalEnemies do
		enemies = createEnemy(screenWidth / totalEnemies * i - 1500 / totalEnemies, 0, enemies)
	end

	return enemies
end


function createEnemy(x, y, enemies)
	local	enemy = {}

	enemy.x	= x
	enemy.y = y

	enemy.outlines          = {}
	enemy.outlines['up']    = 15
	enemy.outlines['down']  = 88
	enemy.outlines['left']  = 22
	enemy.outlines['right'] = 88

	enemy.speed = 40
	table.insert(enemies, enemy)
	return enemies
end

return controllers

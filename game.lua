local game = {}

function game.load(screenWidth, screenHeight)
	--load controllers
	local controllers = require 'controllers'

	game.pC = controllers.createPlayerController()
	game.players = controllers.createPlayers(game.pC, screenWidth, screenHeight)

	game.eC = controllers.createEnemyController()
	game.enemies = controllers.createEnemies(20, screenWidth, screenHeight)
end

function game.play(dt, graph, screenWidth, screenHeight)
	--enemy shooting
	if game.eC.cooldown <= 0 then
		fire(game.enemies[math.random(#game.enemies)], game.eC)
	end

	for _, enemy in pairs(game.enemies) do
		enemy.y = enemy.y + enemy.speed * dt
	end

	for _,player in pairs(game.players) do
		checkKeybinds(dt, graph.keybinds, screenWidth, game.pC, player)
	end

	game.pC.bullets = bulletMovement(dt, screenHeight, game.pC)
	game.eC.bullets = bulletMovement(dt, screenHeight, game.eC)

	game.pC.cooldown = game.pC.cooldown - 1 * dt
	game.eC.cooldown = game.eC.cooldown - 1 * dt

	game.players = checkCollision(game.players, game.pC, game.eC.bullets)
	game.enemies = checkCollision(game.enemies, game.eC, game.pC.bullets)

	return gameStatus(graph.keybinds, screenHeight, game.pC, game.players, game.enemies)
end

function game.pauseStatus(keys, status)
	if	   love.keyboard.isDown(keys.up)   and status == 'resume' then return 'quit'
	elseif love.keyboard.isDown(keys.up)   and status == 'quit'   then return 'resume'
	elseif love.keyboard.isDown(keys.down) and status == 'resume' then return 'quit'
	elseif love.keyboard.isDown(keys.down) and status	== 'quit'   then return 'resume'
	end
end

function game.pauseAction(keys, status)
		if     love.keyboard.isDown(keys.enter) and status == 'quit'   then return 'mainMenu'
		elseif love.keyboard.isDown(keys.enter) and status == 'resume' then return 'game'
		end
end
function gameStatus(keys, screenHeight, playerController, players, enemies)
	if #enemies == 0 then
		return 'won'

	elseif #players == 0 then
		playerController.dieSound:play()
		return 'lost'

	else
		for _,enemy in pairs(enemies) do
			if enemy.y >= screenHeight - 90 then
				playerController.dieSound:play()
				return 'lost'
			elseif love.keyboard.isDown(keys.pause) then
				return 'pause'
			else
				return 'game'
			end
		end
	end
end

function checkKeybinds(dt, keybinds, screenWidth, pC, player)
	--player movement
	if love.keyboard.isDown(keybinds.right) and player.x <= screenWidth - pC.width + 20 then
		player.x = player.x + player.speed * dt
	end

	if love.keyboard.isDown(keybinds.left) and player.x >= - 20 then
		player.x = player.x - player.speed * dt
	end
	--player shooting
	if love.keyboard.isDown(keybinds.shoot) and pC.cooldown <= 0 then
		fire(player, pC)
	end
end

function checkCollision(targets, targetController, bullets)
	for i, target in ipairs(targets) do
		for _,b in pairs(bullets) do
			if  b.y >= target.y + target.outlines['up']
			and b.y <= target.y + target.outlines['down']
			and b.x >= target.x + target.outlines['left']
			and b.x <= target.x + target.outlines['right'] then
				targetController.dieSound:stop()
				targetController.dieSound:play()
				table.remove(targets, i)
			end
		end
	end
	return targets
end

function fire(shooter, controller)
	controller.fireSound:stop()
	controller.fireSound:play()
	controller.cooldown = controller.cooldownTime
	local bullet = {}
	bullet.x = shooter.x + controller.bulletX
	bullet.y = shooter.y + controller.bulletY
	table.insert(controller.bullets, bullet)
	return controller
end

function bulletMovement(dt, screenHeight, controller)
	for i, b in pairs(controller.bullets) do
		b.y = b.y + controller.bulletSpeed * dt
		if b.y > screenHeight - 10 or b.y < -10 then
			table.remove(controller.bullets, i)
		end
	end
	return controller.bullets
end

return game

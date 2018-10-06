local game = {}
game.levels = {}
game.bullets = {}
game.currentLevel = tostring(0)
game.maxLevel = 0

function game.load(screenWidth, screenHeight, gameMusic)
	game.bullets = {}
	--load controllers
	local controller = require 'controller'
	game.players = controller.createPlayers(1, screenWidth, screenHeight)

	game.levels['1'] = {}
	game.levels['1'] = controller.addEnemies('normal', 10, game.levels['1'], screenWidth)

	game.levels['2'] = {}
	game.levels['2'] = controller.addEnemies('normal', 15, game.levels['2'], screenWidth)

	game.levels['3'] = {}
	game.levels['3'] = controller.addEnemies('normal', 20, game.levels['3'], screenWidth)
	for _, level in pairs(game.levels) do
		game.maxLevel = game.maxLevel + 1
	end
	game.currentLevel = tostring(1)
	gameMusic:play()
end

function game.play(dt, graph, screenWidth, screenHeight)
	enemies = game.levels[game.currentLevel]
	--enemy functions
	for i, enemy in pairs(enemies) do

		--enemy shooting
		if enemy.cooldown <= 0 then
			fire(enemy, graph.objects[enemy.mode].fireSound)
		end

		--enemy movement
		enemy.y = enemy.y + enemy.speed * dt

		--enemy cooldown
		enemy.cooldown = enemy.cooldown - 1 * dt

		--enemy collision
		if collision(enemy, graph.objects[enemy.mode].dieSound) then
			table.remove(enemies, i)
		end
	end
	game.levels[game.currentLevel] = enemies

	--player functions
	for i, player in pairs(game.players) do
		--movement to right
		if love.keyboard.isDown(graph.keybinds.right)
		and player.x + player.width / 2 + 20 <= screenWidth then
			player.x = player.x + player.speed * dt
		end

		--movement to left
		if love.keyboard.isDown(graph.keybinds.left) and player.x + player.width / 2 >= 0 then
			player.x = player.x - player.speed * dt
		end

		--shooting
		if love.keyboard.isDown(graph.keybinds.shoot) and player.cooldown <= 0 then
			fire(player, graph.objects['player'].fireSound)
		end

		--player cooldown
		player.cooldown = player.cooldown - 1 * dt

		--player collision
		if collision(player, graph.objects[player.mode].dieSound) then
			table.remove(game.players, i)
		end
	end
	--other game functions
	bulletMovement(dt, screenHeight)

	return currentScreenStatus(graph.keybinds, screenHeight, #game.players,
										graph.objects['player'].dieSound, game.levels[game.currentLevel])
end

function currentScreenStatus(keybinds, screenHeight, totalPlayers, dieSound, enemies)
	if #enemies == 0 then
		game.bullets = {}
		if tonumber(game.currentLevel) == game.maxLevel then
			return 'winningScreen'
		else
			game.currentLevel = tostring(tonumber(game.currentLevel) + 1)
			return 'gameScreen'
		end

	elseif totalPlayers == 0 then
		dieSound:play()
		return 'losingScreen'

	else
		for _,enemy in pairs(enemies) do
			if enemy.y >= screenHeight - 90 then
				dieSound:play()
				return 'losingScreen'

			elseif love.keyboard.isDown(keybinds.pause) then return 'pauseScreen'
			else return 'gameScreen' end
		end
	end
end


--------------------------------------
function fire(shooter, fireSound)
	fireSound:stop()
	fireSound:play()

	shooter.cooldown = shooter.cooldownTime

	local bullet  = {}
	bullet.x			= shooter.x + shooter.width / 2 + shooter.bulletDevX
	bullet.y			= shooter.y + shooter.bulletDevY
	bullet.speed  = shooter.bulletSpeed
	bullet.width  = shooter.bulletOutlines['right'] - shooter.bulletOutlines['left']
	bullet.height = shooter.bulletOutlines['down']  - shooter.bulletOutlines['up']
	bullet.mode		= shooter.mode

	table.insert(game.bullets, bullet)
end

function collision(target, dieSound)
	if target.mode == 'player' then
		for i, bullet in pairs(game.bullets) do
			if bullet.mode ~= 'player' then
				if checkHitbox(bullet, target, dieSound) then
					table.remove(game.bullets, i)
					return true
				end
			end
		end
		return false

	else
		for i, bullet in pairs(game.bullets) do
			if bullet.mode == 'player' then
				if checkHitbox(bullet, target, dieSound) then
					table.remove(game.bullets, i)
					return true
				end
			end
		end
		return false
	end
end

function checkHitbox(b, t, dieSound)
	if  b.y >= t.y + t.outlines['up']
	and b.y <= t.y + t.outlines['down']
	and b.x >= t.x + t.outlines['left']
	and b.x <= t.x + t.outlines['right'] then
		dieSound:stop()
		dieSound:play()
		return true
	else return false end
end

function bulletMovement(dt, screenHeight)
	for i, bullet in pairs(game.bullets) do
		bullet.y = bullet.y + bullet.speed * dt
		if bullet.y > screenHeight or bullet.y < -10 then table.remove(game.bullets, i) end
	end
end

function showTable(table)
	for key, value in pairs(table) do
		print('\t', key, value)
	end
end

return game

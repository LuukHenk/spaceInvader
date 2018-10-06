local logic = require 'lib/logic'
local controller = {}

function controller.addEnemies(mode, enemiesToAdd, enemies, screenWidth)
	for enemy = 1, enemiesToAdd do table.insert(enemies, logic.createObject(mode)) end

	for i, enemy in ipairs(enemies) do
		enemies[i]['x'] = screenWidth / (#enemies + 1) * i - enemy.width / 2 - 25
		enemies[i]['y'] = 0
	end

	return enemies
end

function controller.createPlayers(playerCount, screenWidth, screenHeight)
	local players = {}

	for player = 1, playerCount do table.insert(players, logic.createObject('player')) end

	for i, player in pairs(players) do
			players[i]['x'] = screenWidth / (#players + 1) * i - player.width / 2 - 11
			players[i]['y'] = screenHeight - player.height - 30
	end

	return players
end

return controller

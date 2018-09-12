local draw = {}

function draw.game(background, playerController, players, enemiesController, enemies)
	drawBackground(background)

	drawBullets(playerController)
	drawBullets(enemiesController)

	drawObjects(enemies, enemiesController)
	drawObjects(players, playerController)
end

function drawBackground(background)
	love.graphics.setColor(1, 1, 1)
	love.graphics.draw(background.image, 0, 0, 0, background.imageScaleX, background.imageScaleY)
end

function drawBullets(c)
	love.graphics.setColor(c.bulletR, c.bulletG, c.bulletB)
	for _, bullet in pairs(c.bullets) do
		love.graphics.rectangle(c.bulletMode, bullet.x, bullet.y, c.bulletWidth, c.bulletHeight)
	end
end

function drawObjects(objects, c)
	love.graphics.setColor(1, 1, 1)
	for _, object in pairs(objects) do
		love.graphics.draw(c.image, object.x, object.y, c.imageScaleX, c.imageScaleY)
	end
end

function draw.screen(background, text)
	drawBackground(background)

	love.graphics.setColor(1, 1, 1)
	love.graphics.print(text.str, text.x, y, text.ScaleX, text.scaleY)
end
return draw

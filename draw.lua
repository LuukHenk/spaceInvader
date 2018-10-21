local draw = {}

function draw.game(graph, enemies, players, bullets)
	drawBackground(graph.background)
	drawBullets(graph, bullets)
	drawObjects(graph, enemies)
	drawObjects(graph, players)
end

function draw.screen(background, fontImage, text, selected, screenWidth)
	drawBackground(background)
	for _, t in pairs(text) do
		draw.text(t, fontImage, selected, screenWidth) end
end

function draw.text(t, fontImage, selected, screenWidth)
	if t.mode == selected then love.graphics.setColor(1, 0, 1)
	else love.graphics.setColor(1, 1, 1) end

	local font = love.graphics.setNewFont(fontImage, t.size)

	if t.x == 'center' then love.graphics.print(t.str, setX(font, t.str, screenWidth), t.y)
	else love.graphics.print(t.str, t.x, t.y)end
end

function setX(font, text, screenWidth)
	return(screenWidth / 2 - font:getWidth(text) / 2)
end

function drawBackground(background)
	love.graphics.setColor(1, 1, 1)
	love.graphics.draw(background.image, 0, 0, 0, background.imageScaleX, background.imageScaleY)
end

function drawBullets(graph, bullets)
	for _, bullet in pairs(bullets) do
		c = graph.objects[bullet.mode]

		love.graphics.setColor(c.bulletR, c.bulletG, c.bulletB)
		love.graphics.rectangle(c.bulletMode, bullet.x, bullet.y, bullet.width, bullet.height)
	end
end

function drawObjects(graph, objects)
	love.graphics.setColor(1, 1, 1)
	for _, object in pairs(objects) do
		c = graph.objects[object.mode]
		love.graphics.draw(c.image, object.x, object.y, c.imageScaleX, c.imageScaleY)
	end
end


function showTable(table)
	for index, data in ipairs(table) do
		print(index)

		for key, value in pairs(data) do
			print('\t', key, value)
		end
	end
end

return draw

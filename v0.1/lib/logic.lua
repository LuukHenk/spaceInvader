local logic = {}
local objects = {}

function logic.createObject(mode)
	if     mode == 'player' then object = createPlayer()
	elseif mode == 'normal' then object = createNormal() end
	return object

end
------------------------------------------------------------------------player
function createPlayer()
	local player = {}
	player.mode = 'player'
	player.x = 0
	player.y = 0

	player.speed = 600

	player.outlines          = {}
	player.outlines['up']    = 24
	player.outlines['down']  = 50
	player.outlines['left']  = 7
	player.outlines['right'] = 112

	player.width  = player.outlines['right'] - player.outlines['left']
	player.height = player.outlines['down']  - player.outlines['up']

	player.bulletSpeed = -300
	player.bulletDevX  = 6
	player.bulletDevY  = 0

	player.bulletOutlines          = {}
	player.bulletOutlines['up']    = 0
	player.bulletOutlines['down']  = 10
	player.bulletOutlines['left']  = 0
	player.bulletOutlines['right'] = 10

	player.cooldown     = 0
	player.cooldownTime = 0.5

	return player
end
------------------------------------------------------------------------normal enemy
function createNormal()
	local normal = {}
	normal.mode = 'normal'
	normal.x = 0
	normal.y = 0

	normal.speed = 40

	normal.outlines          = {}
	normal.outlines['up']    = 15
	normal.outlines['down']  = 88
	normal.outlines['left']  = 22
	normal.outlines['right'] = 88

	normal.width  = normal.outlines['right'] - normal.outlines['left']
	normal.height = normal.outlines['down']  - normal.outlines['up']

	normal.bulletSpeed = 200
	normal.bulletDevX  = 20
	normal.bulletDevY  = 50

	normal.bulletOutlines          = {}
	normal.bulletOutlines['up']    = 0
	normal.bulletOutlines['down']  = 10
	normal.bulletOutlines['left']  = 0
	normal.bulletOutlines['right'] = 10

	normal.cooldownTime = 8
	normal.cooldown     = love.math.random(0, normal.cooldownTime)

	objects['normal'] = normal
	return normal
end

function createFast()
	local fast = {}
	fast.mode = 'fast'
	fast.x = 0
	fast.y = 0

	fast.speed = 60

	fast.outlines          = {}
	fast.outlines['up']    = 15
	fast.outlines['down']  = 88
	fast.outlines['left']  = 22
	fast.outlines['right'] = 88

	fast.width  = fast.outlines['right'] - fast.outlines['left']
	fast.height = fast.outlines['down']  - fast.outlines['up']

	fast.bulletSpeed = 210
	fast.bulletDevX  = 20
	fast.bulletDevY  = 50

	fast.bulletOutlines          = {}
	fast.bulletOutlines['up']    = 0
	fast.bulletOutlines['down']  = 10
	fast.bulletOutlines['left']  = 0
	fast.bulletOutlines['right'] = 10

	fast.cooldownTime = 8
	fast.cooldown     = love.math.random(0, fast.cooldownTime)

	objects['fast'] = fast
	return fast
end
return logic

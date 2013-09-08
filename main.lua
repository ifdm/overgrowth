Camera = require 'lib/hump/camera'
Class = require 'lib/hump/class'
Gamestate = require 'lib/hump/gamestate'
Signals = require 'lib/hump/signal'
Timer = require 'lib/hump/timer'
vector = require 'lib/hump/vector'

require 'lib/util'

require 'class/player'
require 'class/wall'
require 'class/mushroom'
require 'class/seed'

objects = {}
history = {}

function love.load()
	fixtureMap = {}

	love.physics.setMeter(64)
	world = love.physics.newWorld(0, 10 * 64, true)
	world:setCallbacks(beginCollision, endCollision, preFrameResolve, postFrameResolve)
	player = Player(96, 400)
	
	ground = Wall(0, 536, {0, 0, 800, 0, 800, 64, 0, 64})
	leftWall = Wall(0, 0, {0, 0, 64, 0, 64, 600, 0, 600})
	cliffWall = Wall(700, 300, {0, 0, 64, 0, 64, 300, 0, 300})
	cliffGround = Wall(700, 300, {0, 0, 200, 0, 200, 64, 0, 64})
	rightWall = Wall(900, 0, {0, 0, 64, 0, 64, 600, 0, 600})
	wall = Wall(100, 300, {0, 0, 32, 0, 32, 32, 0, 32})
	seed = Seed(200, 400, Mushroom)
	camera = Camera()
end

function love.update()
	world:update(tickRate)
	
	for _, obj in pairs(objects) do
		f.exe(obj.update, obj)
	end
	
	history[tick] = {}
	table.copy(player)
	for _, obj in pairs(objects) do
		history[tick][obj] = table.copy(obj)
	end

	local px, py = player.body:getX(), player.body:getY()
	local cx, cy = camera:pos()
	local mx, my = camera:mousepos()
	camera.prevx = cx
	camera.prevy = cy
	cx = math.lerp(cx, (px + mx) / 2, .25)
	cy = math.lerp(cy, (py + my) / 2, .25)
	
	cx, cy = cx - 400, cy - 300
	if px - cx > (love.graphics.getWidth() * .80) then cx = px - (love.graphics.getWidth() * .80) end
	if py - cy > (love.graphics.getHeight() * .80) then cy = py - (love.graphics.getHeight() * .80) end
	if (cx + love.graphics.getWidth()) - px > (love.graphics.getWidth() * .80) then cx = px + (love.graphics.getWidth() * .80) - love.graphics.getWidth() end
	if (cy + love.graphics.getHeight()) - py > (love.graphics.getHeight() * .80) then cy = py + (love.graphics.getHeight() * .80) - love.graphics.getHeight() end
	cx, cy = cx + 400, cy + 300
	
	camera:lookAt(cx, cy)
end

function love.draw()
	if not history[tick - 1] then return end
	
	local z = tickDelta / tickRate
	local cx, cy = camera:pos()
	camera.x = math.lerp(camera.prevx, cx, z)
	camera.y = math.lerp(camera.prevy, cy, z)
	camera:draw(function()
		for _, obj in pairs(objects) do
			if history[tick - 1][obj] and history[tick][obj] then
				table.interpolate(history[tick - 1][obj], history[tick][obj], z):draw()
			end
		end
	end)
	camera.x = cx
	camera.y = cy
end

function love.mousepressed(x, y, button)
	--
end

function love.keypressed(key)
	--
end

function love.keyreleased(key)
	player:keyreleased(key)
end

function beginCollision(a, b, collide)
	nX, nY = collide:getNormal()
	a = a:getUserData()
	b = b:getUserData()
	f.exe(a.handleCollision, a, b, nX, nY)
	f.exe(b.handleCollision, b, a, nX, nY)
end

function endCollision(a, b, collide)
    
end

function preFrameResolve(a, b, collide)
    
end

function postFrameResolve(a, b, collide)
    
end

function love.run()
	math.randomseed(os.time())
	math.random()

	tick = 0
	tickRate = .02
	tickDelta = 0

	if love.load then love.load(arg) end

	local dt = 0
	while true do
		love.timer.step()
		local delta = love.timer.getDelta()

		love.event.pump()
		for e, a, b, c, d in love.event.poll() do
			if e == 'quit' then if love.quit then love.quit() end love.audio.stop() return
			else love.handlers[e](a, b, c, d) end
		end

		tickDelta = tickDelta + delta
		while tickDelta >= tickRate do
			tickDelta = tickDelta - tickRate
			tick = tick + 1
			love.update()
		end

		love.graphics.clear()
		love.draw()
		love.graphics.present()

		love.timer.sleep(.001)
	end
end

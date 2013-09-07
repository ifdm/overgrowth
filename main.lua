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

function love.load()
	fixtureMap = {}

	love.physics.setMeter(64)
	world = love.physics.newWorld(0, 10 * 64, true)
	world:setCallbacks(beginCollision, endCollision, preFrameResolve, postFrameResolve)
	player = Player(0, 0)
	
	ground = Wall(0, 575, {0, 0, 800, 0, 800, 50, 0, 50})
	wall = Wall(400, 300, {0, 0, 32, 0, 32, 32, 0, 32})
	
	camera = Camera()
	mushroom = Mushroom(400, 511)
end

function love.update()
	world:update(tickRate)
	player:update()
	
	local px, py = player.body:getX(), player.body:getY()
	local cx, cy = camera:pos()
	local mx, my = camera:mousepos()
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
	camera:draw(function()
		player:draw()
		ground:draw()
		wall:draw()
		mushroom:draw()
	end)
end

function love.mousepressed(x, y, button)
	--
end

function love.keypressed(key)
	--
end

function love.keyreleased(key)
	--
	player:keyreleased(key)
end

function beginCollision(a, b, collide)
	a = a:getUserData()
	b = b:getUserData()
	if b == player then
		a, b = b, a
	end
	if a.handleCollision ~= nil then
		a:handleCollision(b, collide)
	end
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
			love.update()
		end

		love.graphics.clear()
		love.draw()
		love.graphics.present()

		love.timer.sleep(.001)
	end
end

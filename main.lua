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

	local mx, my = camera:mousepos()
	camera.x = math.lerp(camera.x, ((player.body:getX() + mx) / 2) - (love.graphics.getWidth() / 2), .25)
	camera.y = math.lerp(camera.y, ((player.body:getY() + my) / 2) - (love.graphics.getHeight() / 2), .25)
	if player.body:getX() - camera.x > (love.graphics.getWidth() * .80) then camera.x = player.body:getX() - (love.graphics.getWidth() * .80) end
	if player.body:getY() - camera.y > (love.graphics.getHeight() * .80) then camera.y = player.body:getY() - (love.graphics.getHeight() * .80) end
	if (camera.x + love.graphics.getWidth()) - player.body:getX() > (love.graphics.getWidth() * .80) then camera.x = player.body:getX() + (love.graphics.getWidth() * .80) - love.graphics.getWidth() end
	if (camera.y + love.graphics.getHeight()) - player.body:getY() > (love.graphics.getHeight() * .80) then camera.y = player.body:getY() + (love.graphics.getHeight() * .80) - love.graphics.getHeight() end
	
	if camera.x < 0 then camera.x = 0 end
	if camera.y < 0 then camera.y = 0 end
	if camera.x + love.graphics.getWidth() > 2000 then camera.x = 2000 - love.graphics.getWidth() end
	if camera.y + love.graphics.getHeight() > 600 then camera.y = 600 - love.graphics.getHeight() end
end

function love.draw()
	player:draw()
	ground:draw()
	wall:draw()
	mushroom:draw()
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

function beginCollision(afixture, bfixture, collide)
	local aobj = fixtureMap[afixture]
	local bobj = fixtureMap[bfixture]
	if bobj == player then
		aobj, bobj = bobj, aobj
	end
	if aobj.handleCollision ~= nil then
		aobj:handleCollision(bobj, collide)
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

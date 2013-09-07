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
	
	ground = {}
	ground.body = love.physics.newBody(world, 800/2, 600) --remember, the shape (the rectangle we create next) anchors to the body from its center, so we have to move it to (650/2, 650-50/2)
	ground.shape = love.physics.newRectangleShape(800, 50) --make a rectangle with a width of 650 and a height of 50
	ground.fixture = love.physics.newFixture(ground.body, ground.shape) --attach shape to body
	
	wall = Wall(100, 500, {0, 0, 32, 0, 32, 32, 0, 32})
	mushroom = Mushroom(400, 511)
end

function love.update()
	world:update(tickRate)
	player:update()
end

function love.draw()
	player:draw()
	love.graphics.rectangle('fill', 0, 600 - 25, 800, 50)
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

function beginCollision(a, b, collide)
	nX, nY = collide:getNormal()
	print(nX)
	print(nY)
	print(a)
	a = fixtureMap[a]
	print(a)
	b = fixtureMap[b]
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

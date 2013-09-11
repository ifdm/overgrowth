Camera = require 'lib/hump/camera'
Class = require 'lib/hump/class'
Gamestate = require 'lib/hump/gamestate'
Signals = require 'lib/hump/signal'
Timer = require 'lib/hump/timer'
vector = require 'lib/hump/vector'

require 'lib/util'

require 'class/player'
require 'class/wall'
require 'class/plants/mushroom'
require 'class/plants/bridge'
require 'class/seed'
require 'class/view'

require 'class/level'

objects = {}
history = {}
fixtureMap = {}

--Since planting happens during physics updates, need to queue events for later (feel free to remove if there's a better way)
plantQueue = {}

function love.load()
	

	love.physics.setMeter(64)
	world = love.physics.newWorld(0, 10 * 64, true)
	world:setCallbacks(beginCollision, endCollision, preFrameResolve, postFrameResolve)



	--New way to make levels. Make as many as you want, and swap between them freely!
	local level = Level("default")

	level:addWall(0, 536, {0, 0, 764, 0, 764, 64, 0, 64})
	level:addWall(0, 0, {0, 0, 64, 0, 64, 600, 0, 600})
	level:addWall(700, 300, {0, 0, 64, 0, 64, 300, 0, 300})
	level:addWall(700, 300, {0, 0, 200, 0, 200, 64, 0, 64})
	level:addWall(900, 0, {0, 0, 64, 0, 64, 364, 0, 364})
	level:addWall(100, 300, {0, 0, 32, 0, 32, 32, 0, 32})
	level:setPlayer(96, 400)
	level:addSeed(200, 400, Mushroom)
	level:addSeed(300, 400, Bridge)

	loadLevel("default")

	
end

function loadLevel(levelName)
	--Clear everything (SHOULD BE ABSTRACTED OUT)
	fixtureMap = {}
	objects = {}
	history = {}
	plantQueue = {}


	level = levelIndex[levelName]
	level:enter()

end

function love.update()
	world:update(tickRate)
	
for i,seed in pairs(plantQueue) do
    	seed.type.plant(seed.body:getX(), seed.body:getY(), seed.angle)
    	seed:collect()
    	table.remove(plantQueue, i)
    end

	
	for i, obj in pairs(objects) do
		if obj.remove then
			table.remove(objects, i)
		else
			f.exe(obj.update, obj)
		end
	end


	view:update()
	
	history[tick] = {}
	for _, obj in pairs(objects) do
		history[tick][obj] = {
			x = obj.body:getX(),
			y = obj.body:getY()
		}
	end
	history[tick - 1 / tickRate] = nil
end

function love.draw()
	if not history[tick - 1] then return end
	
	local z = tickDelta / tickRate
	view:draw(function()
		for _, obj in pairs(objects) do
			local previous, current = history[tick - 1][obj], history[tick][obj]
			if previous and current then
				
				local interpolated = table.interpolate(previous, current, z)
				local obj = table.copy(obj)
				obj.body:setX(interpolated.x)
				obj.body:setY(interpolated.y)
				obj:draw()
			end
		end
	end)
end

function love.mousepressed(x, y, button)
	--
end

function love.mousereleased(x, y, button)
	player:mousereleased(x, y, button)
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

function plantLater(seed)

	plantQueue[#plantQueue + 1] = seed

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

		love.graphics.setBackgroundColor(20, 40, 20)
		love.graphics.clear()
		love.draw()
		love.graphics.present()

		love.timer.sleep(.001)
	end
end

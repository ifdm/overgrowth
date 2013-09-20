Camera = require 'lib/hump/camera'
Class = require 'lib/hump/class'
Gamestate = require 'lib/hump/gamestate'
Signals = require 'lib/hump/signal'
Timer = require 'lib/hump/timer'
vector = require 'lib/hump/vector'

require 'lib/util'
require 'lib/heap'

require 'class/player'
require 'class/simSeed'
require 'class/wall'
require 'class/plants/mushroom'
require 'class/plants/bridge'
require 'class/plants/dropper'
require 'class/plants/checkpoint'
require 'class/obstacles/laser'
require 'class/obstacles/fan'
require 'class/seed'
require 'class/view'
require 'class/level'


function love.load()
	objects = {}
	history = {}
	fixtureMap = {}



	love.physics.setMeter(64)
	world = love.physics.newWorld(0, 10 * 64, true)
	world:setCallbacks(beginCollision, endCollision, preFrameResolve, postFrameResolve)
	SimSeed.setupSim()
	-- New way to make levels. Make as many as you want, and swap between them freely!
	level = Level('data/level/default.lua'):enter()
end

function love.update()
	world:update(tickRate)
	Seed.grow()
	
	history[tick] = {}


	for i, obj in pairs(objects) do
		if obj.remove then
			table.remove(objects, i)
			f.exe(obj.destroy, obj)
		else
			f.exe(obj.update, obj)
			history[tick][obj] = {
			x = obj.body:getX(),
			y = obj.body:getY()
		}
		end
		
	end
	view:update()
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
	local nX, nY = collide:getNormal()
	local x , y  = collide:getPositions()
	local a = a:getUserData()
	local b = b:getUserData()
	f.exe(a.handleCollision, a, b, nX, nY, x, y)
	f.exe(b.handleCollision, b, a, nX, nY, x, y)
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

		love.graphics.setBackgroundColor(20, 40, 20)
		love.graphics.clear()
		love.draw()
		love.graphics.present()

		love.timer.sleep(.001)
	end
end

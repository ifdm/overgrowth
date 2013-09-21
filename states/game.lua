Game = {}

function Game:enter()
	objects = {}
	history = {}
	fixtureMap = {}

	love.physics.setMeter(64)
	world = love.physics.newWorld(0, 10 * 64, true)
	world:setCallbacks(Game.beginCollision, f.empty, f.empty, f.empty)
	SimSeed.setupSim()

	level = Level('levels/default'):enter()
end

function Game:update()
	world:update(tickRate)
	
	history[tick] = {}

	for i, obj in pairs(objects) do
		if obj.remove then
			table.remove(objects, i)
			print("Object removed.")
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

function Game:draw()
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

function Game:mousereleased(x, y, button)
	player:mousereleased(x, y, button)
end

function Game:keyreleased(key)
	player:keyreleased(key)
end

function Game.beginCollision(a, b, collide)
	local nX, nY = collide:getNormal()
	local x, y = collide:getPositions()
	local a = a:getUserData()
	local b = b:getUserData()
	f.exe(a.handleCollision, a, b, nX, nY, x, y)
	f.exe(b.handleCollision, b, a, nX, nY, x, y)
end

function plantLater(seed)
	plantQueue[#plantQueue + 1] = seed
end
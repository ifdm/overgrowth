Level = Class {
	name = 'Level'
}

function Level:init(filename)
	local data = love.filesystem.load(filename)()
	table.merge(data, self)

	self.world = love.physics.newWorld(0.0, 1000.0, true)
	self.world:setCallbacks(function(a, b, contact)
		local dx, dy = contact:getNormal()
		a, b = a:getUserData(), b:getUserData()

		if a.collideWith then
			f.exe(a.collideWith[b.name], a, b, dx, dy)
			f.exe(a.collideWith['*'], a, b, dx, dy)
		end

		if b.collideWith then
			f.exe(b.collideWith[a.name], b, a, dx, dy)
			f.exe(b.collideWith['*'], b, a, dx, dy)
		end
	end)
end

function Level:update()
	self.world:update(tickRate)
end

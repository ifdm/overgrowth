Dropper = Class {
	name = 'Dropper',
	width = 150,
	height = 64,
	rgb = {200, 50, 35},
	timer = 3
}

function Dropper:init(x, y)
	self.body = love.physics.newBody(world, x, y, 'static')
	self.shape = love.physics.newPolygonShape(0, 0, self.width, 0, self.width, self.height, 0, self.height)
	self.fixture = love.physics.newFixture(self.body, self.shape, 1)
	self.fixture:setUserData(self)

	self.body:setFixedRotation(true)
	self.body:setLinearDamping(0)
	self.fixture:setRestitution(0)

	objects[#objects + 1] = self
end

function Dropper:update()
	self.timer = math.max(self.timer - tickRate, 0)
	if self.timer == 0 and self.spawned == nil then
		self.spawned = Drop(self.body:getX() + (self.width / 2) - (64 / 2), self.body:getY() - self.height)
		self.spawned.body:applyLinearImpulse(0, 30)
	end
end

function Dropper:draw()
	love.graphics.reset()

	love.graphics.setColor(self.rgb)
	love.graphics.polygon('fill', self.body:getWorldPoints(self.shape:getPoints()))
end

Drop = Class {
	name = 'Drop'
}

function Drop:init(x, y)
	self.body = love.physics.newBody(world, x, y, 'dynamic')
	self.shape = love.physics.newPolygonShape(0, 0, 64, 0, 64, 64, 0, 64)
	self.fixture = love.physics.newFixture(self.body, self.shape, 1)
	self.fixture:setUserData(self)

	self.body:setFixedRotation(true)
	self.body:setLinearDamping(0)
	self.fixture:setRestitution(0)

	objects[#objects + 1] = self
end

function Drop:draw()
	love.graphics.reset()

	love.graphics.setColor(255, 255, 255)
	love.graphics.polygon('fill', self.body:getWorldPoints(self.shape:getPoints()))
end

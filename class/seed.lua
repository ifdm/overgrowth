Seed = Class {
	collected = false
}

function Seed:init(x, y, type)
	self.body = love.physics.newBody(world, x, y, 'dynamic')
	self.body:setMass(2)
	self.shape = love.physics.newCircleShape(16)
	self.fixture = love.physics.newFixture(self.body, self.shape, 1)

	self.body:setFixedRotation(false)
	self.body:setLinearDamping(0)
	self.fixture:setRestitution(0.25)
	self.fixture:setFriction(.95)
	self.fixture:setUserData(self)

	self.type = type
	self.grace = 0
	
	objects[#objects + 1] = self
end

function Seed:update()
	self.grace = math.max(self.grace - tickRate, 0)
end

function Seed:handleCollision(other, nX, nY)
	if self.grace == 0 and other.inventory then
		other.inventory[#other.inventory + 1] = self.type
		self:collect()
	end
end

function Seed:collect()
	
	-- Oh god O(n) pls make it stop.
	for k, obj in pairs(objects) do
		if obj == self then table.remove(objects, k) break end
	end
end

function Seed:throw()
	-- throw shit
	local v = vector(camera:mousepos()) - vector(self.body:getPosition())
	self.body:setLinearVelocity(v:normalized():permul(vector(700, 700)):unpack())
end

function Seed:draw()
	love.graphics.reset()
	love.graphics.circle('fill', self.body:getX(), self.body:getY(), self.shape:getRadius())
end

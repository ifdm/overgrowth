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
	self.fixture:setRestitution(0)
	self.fixture:setFriction(.95)
	self.fixture:setUserData(self)

	self.type = type
	
	objects[#objects + 1] = self
end

function Seed:update()
	
end

function Seed:handleCollision(other, nX, nY)
	if other.inventory then
		other.inventory[self.type] = other.inventory[self.type] + 1
	end
end

function Seed:collect()
	self.collected = true
end

function Seed:throw()
	self.collected = false
	-- throw shit
	local v = vector(self.body:getX(), self.body:getY())
	self.body:setLinearVelocity(v:angleTo(vector(camera:mousepos())):unpack())
end

function Seed:draw()
	if not self.collected then
		love.graphics.reset()
		love.graphics.circle('fill', self.body:getX(), self.body:getY(), self.shape:getRadius())
	end
end

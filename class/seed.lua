Seed = Class {
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
end

function Seed:update()
	
end

function Seed:handleCollision(other, collide)
	nX, nY = colide:getNormal()

end

Seed.collect = f.empty

function Seed:draw()
	love.graphics.reset()
	love.graphics.circle('fill', self.body:getX(), self.body:getY(), self.shape:getRadius())
end
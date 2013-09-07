Mushroom = Class {
	jumpSpeed = -2000
}

function Mushroom:init(x, y)
	self.body = love.physics.newBody(world, x, y, 'static')
	self.body:setMass(15)
	self.shape = love.physics.newPolygonShape(0, 0, 150, 0, 150, 64, 0, 64)
	self.fixture = love.physics.newFixture(self.body, self.shape, 1)
	fixtureMap[self.fixture] = self

	self.body:setFixedRotation(true)
	self.body:setLinearDamping(0)
	self.fixture:setRestitution(0)
end

function Mushroom:draw()
	love.graphics.reset()
	love.graphics.polygon('fill', self.body:getWorldPoints(self.shape:getPoints()))
end
Wall = Class {}

function Wall:init(x, y, points)
	self.body = love.physics.newBody(world, x, y, 'static')
	self.shape = love.physics.newPolygonShape(unpack(points))
	self.fixture = love.physics.newFixture(self.body, self.shape, 1)
	self.fixture:setUserData(self)
end

function Wall:draw()
	love.graphics.reset()
	love.graphics.polygon('fill', self.body:getWorldPoints(self.shape:getPoints()))
end
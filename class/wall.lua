Wall = Class {}

function Wall:init(x, y, points)
	self.body = love.physics.newBody(world, x, y, 'static')
	self.shape = love.physics.newPolygonShape(unpack(points))
	self.fixture = love.physics.newFixture(self.body, self.shape, 1)
	self.fixture:setUserData(self)

	objects[#objects + 1] = self
end

function Wall:draw()
	love.graphics.reset()
	love.graphics.setColor(90, 75, 50)
	love.graphics.polygon('fill', self.body:getWorldPoints(self.shape:getPoints()))
end

Wall = Class {}

function Wall:init(points)
	self.type = Wall
	self.body = love.physics.newBody(world, 0, 0, 'static')
	self.shape = love.physics.newChainShape(true, unpack(points))
	self.fixture = love.physics.newFixture(self.body, self.shape, 1)
	self.fixture:setUserData(self)

	objects[#objects + 1] = self
end

function Wall:draw()
	love.graphics.reset()
	love.graphics.setColor(90, 75, 50)
	love.graphics.polygon('line', self.body:getWorldPoints(self.shape:getPoints()))
end

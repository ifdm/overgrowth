Wall = Class {}

function Wall:init(x, y, points)
	self.body = love.physics.newBody(world, x, y, 'static')
	self.shape = love.physics.newPolygonShape(unpack(points))
	self.fixture = love.physics.newFixture(self.body, self.shape, 1)
	fixtureMap[self.fixture] = self
	
	self.points = points
	for i = 1, #points, 2 do
		self.points[i] = self.points[i] + x
		self.points[i + 1] = self.points[i + 1] + y
	end
end

function Wall:draw()
	love.graphics.reset()
	
	
	love.graphics.polygon('fill', self.points)
end
Vine = Class {}

function Vine:init(x, y)
	self.grown = false
	self.x, self.y = x, y
	
	objects[#objects + 1] = self
end

function Vine:update()
	if not self.grown then self:grow() end
	self.mouseJoint:setTarget(view.camera:mousepos())
end

function Vine:draw()
	love.graphics.reset()
	
	love.graphics.setColor(200, 200, 200)
	for i = 1, #self.bodies do
		love.graphics.polygon('line', self.bodies[i]:getWorldPoints(self.shape:getPoints()))
	end
end

function Vine:grow()
	self.bodies = {}
	self.fixtures = {}
	self.joints = {}
	self.shape = love.physics.newRectangleShape(8, 32)
	
	for y = 0, 300, 30 do
		self.bodies[#self.bodies + 1] = love.physics.newBody(world, self.x, self.y + y, 'dynamic')
		
		local fixture = love.physics.newFixture(self.bodies[#self.bodies], self.shape, 1)
		fixture:setCategory(3)
		fixture:setMask(3)
		fixture:setUserData(self)
		self.fixtures[#self.fixtures + 1] = fixture
	end
	
	self.mouseJoint = love.physics.newMouseJoint(self.bodies[1], 100, 230)
	for i = 1, #self.bodies - 1 do
		self.joints[i] = love.physics.newRevoluteJoint(self.bodies[i], self.bodies[i + 1], self.bodies[i]:getX(), self.bodies[i]:getY(), false)
		self.joints[i]:enableLimit()
		self.joints[i]:setUpperLimit(.2)
	end
	
	self.body = self.bodies[1]
	self.fixture = self.fixtures[1]
	
	self.grown = true
end

function Vine:handleCollision()
	--
end
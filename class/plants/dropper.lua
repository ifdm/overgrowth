Dropper = Class {
	width = 150,
	height = 64,
	rgb = {200, 50, 35},
	timer = 3
}

--Lazy, didn't integrate with rest of Dropper class.
function Dropper:getAngleShapeAndPosition(x, y, angle)
	local xC = math.cos(angle)
	local yC = math.sin(angle)

	local xPos = x - (xC * self.width/2)
	local yPos = y - (yC * self.height/2)

	--WTF. Please, fix this if you have any ideas
	if yC == -1 then
		yPos = y + self.width/2
	end
	if yC == 1 then
		yPos = y - self.width/2
	end

	local shape = {}
	shape = love.physics.newPolygonShape(0, 0, self.width, 0, self.width, self.height, 0, self.height)
	
	return angle, shape, xPos, yPos
end

function Dropper:init(x, y, angle)
	self.grown = false
	self.x, self.y, self.angle = x, y, angle

	objects[#objects + 1] = self
end

function Dropper:update()
	if not self.grown then self:grow() end
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

function Dropper:grow()
	local a, _shape, xPos, yPos = self:getAngleShapeAndPosition(self.x, self.y, self.angle)
	self.xPos = xPos
	self.yPos = yPos

	self.body = love.physics.newBody(world, xPos, yPos, 'static')
	self.shape = _shape

	self.body:setAngle(self.angle)
	self.body:setMass(15)
	
	self.fixture = love.physics.newFixture(self.body, self.shape, 1)
	self.fixture:setUserData(self)

	self.body:setFixedRotation(true)
	self.body:setLinearDamping(0)
	self.fixture:setRestitution(0)
	
	self.grown = true
end

function Dropper:destroy()
	self.body:destroy()
end

Drop = Class {}

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

Bridge = Class {
	name = "Bridge",
	width = 64,
	height = 200,
	minLedgeDepth = 128,	
	minLedgeWidth = 200, 
	ledgeLookahead = 64 --one meter lookahead to ledges

}

function Bridge:getAngleShapeAndPosition(x, y, angle)
	local xC = math.cos(angle)
	local yC = math.sin(angle)

	local xPos = x - (xC * self.width/2)
	local yPos = y - (yC * self.height/2)

	--WTF. Please, fix this if you have any ideas
	if yC == -1 then
		yPos = yPos - self.width
	end
	if yC == 1 then
		yPos = yPos + self.width
	end
	local shape = love.physics.newPolygonShape(0, 0, self.width, 0, self.width, self.height, 0, self.height)
	return angle, shape, xPos, yPos
end

function Bridge:init(x, y, angle)

	local a, _shape, xPos, yPos = self:getAngleShapeAndPosition(x, y, angle)
	self.xPos = xPos
	self.yPos = yPos
	local _body = love.physics.newBody(world, xPos, yPos, "static")
	self.body = _body
	self.shape = _shape

	self.body:setAngle(angle)
	self.fixture = love.physics.newFixture(self.body, self.shape, 1)
	self.fixture:setUserData(self)

	self.body:setFixedRotation(true)
	self.body:setLinearDamping(0)
	self.body:setMass(15)
	

	self.fixture:setRestitution(0)

	self.simBody = love.physics.newBody(simWorld, xPos, yPos, 'static')
	self.simBody:setAngle(angle)
	self.simBody:setMass(15)
	self.simBody:setFixedRotation(true)
	self.simBody:setLinearDamping(0)
	self.simFixture = love.physics.newFixture(self.simBody, self.shape, 1)
	self.simFixture:setUserData(self)

 
	objects[#objects + 1] = self
end

function Bridge:draw()
	love.graphics.reset()
	love.graphics.setColor(30, 150, 30)
	love.graphics.polygon('fill', self.body:getWorldPoints(self.shape:getPoints()))
	--love.graphics.setColor(0, 0, 255)
	--local x = self.body:getX()
	--local y = self.body:getY()
	--love.graphics.polygon('fill',x -  self.ledgeLookahead, y,x - self.ledgeLookahead, y + self.minLedgeDepth, x - self.ledgeLookahead - self.minLedgeWidth, y + self.minLedgeDepth )
end

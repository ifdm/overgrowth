Bridge = Class {
	name = "Bridge",
	width = 64,
	height = 150,
	minLedgeDepth = 256,	--ledges must be at least 4 meters deep
	minLedgeWidth = 256, --ledges must be at least 4 meters wide	height = 128,
	ledgeLookahead = 128 --one meter lookahead to ledges

}

function Bridge:init(x, y, angle)
	
	--angle = angle + math.pi/2
	local xC = math.cos(angle)
	local yC = math.sin(angle)
	local _body = love.physics.newBody(world, x - (xC * self.width/2), y - (yC * self.height/2), "static")
	self.body = _body
	self.shape = love.physics.newPolygonShape(0, 0, self.width, 0, self.width, self.height, 0, self.height)

	self.body:setAngle(angle)
	self.fixture = love.physics.newFixture(self.body, self.shape, 1)
	self.fixture:setUserData(self)

	self.body:setFixedRotation(true)
	self.body:setLinearDamping(0)
	self.body:isSleepingAllowed(false)
	self.body:setMass(15)
	

	self.fixture:setRestitution(0)

	
	
	print(self.offsetVector)
	print(" vs ".. x .." "..y .. " " .. angle)




	objects[#objects + 1] = self
end

function Bridge:draw()
	love.graphics.reset()
	love.graphics.setColor(30, 150, 30)
	love.graphics.polygon('fill', self.body:getWorldPoints(self.shape:getPoints()))
	love.graphics.setColor(0, 0, 255)
	local x = self.body:getX()
	local y = self.body:getY()
	love.graphics.polygon('fill',x -  self.ledgeLookahead, y,x - self.ledgeLookahead, y + self.minLedgeDepth, x - self.ledgeLookahead - self.minLedgeWidth, y + self.minLedgeDepth )
end

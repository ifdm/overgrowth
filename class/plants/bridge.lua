Bridge = Class {
	name = "Bridge",
	width = 150,
	height = 64,
	ledgeLookahead = 128, --one meter lookahead to ledges
	minLedgeDepth = 256,	--ledges must be at least 4 meters deep
	minLedgeWidth = 256 --ledges must be at least 4 meters wide
}

function Bridge:init(x, y, angle)

	angle = angle + math.pi/2
	local _body = love.physics.newBody(world, 
		x - (self.width * math.cos(angle)), y - (self.height * math.sin(angle)), "static")
	self.body = _body

	self.body:setAngle(angle)
	self.body:setMass(15)
	self.shape = love.physics.newPolygonShape(0, 0, self.width, 0, self.width, self.height, 0, self.height)

	self.fixture = love.physics.newFixture(self.body, self.shape, 1)
	self.fixture:setUserData(self)

	self.body:setFixedRotation(true)
	self.body:setLinearDamping(0)
	self.fixture:setRestitution(0)

--[[
	self.ledgeLeft = {
		p1 = vector(x  - self.ledgeLookahead, y),
		p2 = vector(x - ledgeLookahead, y + minLedgeDepth),
		p3 = vector(x - ledgeLookahead - minLedgeWidth, y + minLedgeDepth)

	}
]]



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

Mushroom = Class {
	bounceSpeed = -4.5,
	maxBounceVelocity = -3500,
	width = 150,
	height = 64,
	name = "Mushroom",
	curvedMushrooms = false
}

function Mushroom:init(x, y, angle)
	local xC = math.cos(angle)
	local yC = math.sin(angle)
	local _body = love.physics.newBody(world, x - (xC * self.width/2), y - (yC * self.height/2), 'static')
	self.body = _body
	self.body:setAngle(angle)
	self.body:setMass(15)
	if self.curvedMushrooms == true then
		self.shape = love.physics.newCircleShape(60)
	else
		self.shape = love.physics.newPolygonShape(0, 0, self.width, 0, self.width, self.height, 0, self.height)
	end
	self.fixture = love.physics.newFixture(self.body, self.shape, 1)
	self.fixture:setUserData(self)

	self.body:setFixedRotation(true)
	self.body:setLinearDamping(0)
	self.fixture:setRestitution(0)


	self.simBody = love.physics.newBody(simWorld, x, y, 'static')
	self.simFixture = love.physics.newFixture(self.simBody, self.shape, 1)
	self.simFixture:setUserData(self)

	objects[#objects + 1] = self
end

function Mushroom:handleCollision(other, nX, nY)
	vX, vY = other.body:getLinearVelocity()
	velV = vector(vX, vY)
	normV = vector(nX, nY)
	velV:mirrorOn(normV)
	nX, nY = velV:unpack()


	if(other.name == "Seed") or (other.name == "SimSeed") then
		other.body:applyLinearImpulse(nX* 0.035, math.max(nY * self.bounceSpeed * 0.075, self.maxBounceVelocity))
		return
	end
--other.body:applyLinearImpulse(nX, nY * self.bounceSpeed)
	other.body:applyLinearImpulse(math.max(nX * self.bounceSpeed, self.maxBounceVelocity) , math.max(nY * self.bounceSpeed, self.maxBounceVelocity))
end

function Mushroom:draw()
	love.graphics.reset()
	if self.curvedMushrooms == true then
		love.graphics.circle('fill', self.body:getX(), self.body:getY(), self.shape:getRadius())
	else
		love.graphics.polygon('fill', self.body:getWorldPoints(self.shape:getPoints()))
	end
	
	
end

Mushroom = Class {
	bounceSpeed = 0.068,
	bounceSpeedSeed = 0.005,
	maxBounceVelocity = 3500,
	width = 150,
	height = 64,
	curvedMushrooms = false
}

--Lazy, didn't integrate with rest of Mushroom class.
function Mushroom:getAngleShapeAndPosition(x, y, angle)
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
	if self.curvedMushrooms == true then
		shape = love.physics.newCircleShape(60)
	else
		shape = love.physics.newPolygonShape(0, 0, self.width, 0, self.width, self.height, 0, self.height)
	end
	
	return angle, shape, xPos, yPos
end

function Mushroom:destroy()
	self.body:destroy()
end

function Mushroom:init(x, y, angle)
	self.grown = false
	self.x, self.y, self.angle = x, y, angle

	objects[#objects + 1] = self
end

function Mushroom:update()
	if not self.grown then self:grow() end
end

function Mushroom:handleCollision(other, nX, nY, x, y)
	if self.curvedMushrooms then nY = -nY end
	
	vX, vY = other.body:getLinearVelocity()
	velV = vector(vX, vY)
	normV = vector(nX, nY)
	velV:mirrorOn(normV)
	newX, newY = velV:unpack()

	if other.__index == Seed then
		other.body:applyLinearImpulse(newX * self.bounceSpeedSeed * nX, newY *self.bounceSpeedSeed * nY)
		return
	end
	
	local bX = newX * self.bounceSpeed * nX
	local bY = newY * self.bounceSpeed * nY
	
	if bX < self.maxBounceVelocity * -1 then bX = self.maxBounceVelocity * -1 end
	if bX > self.maxBounceVelocity      then bX = self.maxBounceVelocity      end
	if bY < self.maxBounceVelocity * -1 then bY = self.maxBounceVelocity * -1 end
	if bY > self.maxBounceVelocity      then bY = self.maxBounceVelocity      end

	other.body:applyLinearImpulse(bX, bY)
end

function Mushroom:draw()
	love.graphics.reset()
	if self.curvedMushrooms then
		love.graphics.circle('fill', self.body:getX(), self.body:getY(), self.shape:getRadius())
	else
		love.graphics.polygon('fill', self.body:getWorldPoints(self.shape:getPoints()))
	end
end

function Mushroom:grow()
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

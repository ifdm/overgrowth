Mushroom = Class {
	bounceSpeed = -5,
	maxBounceVelocity = -3500,
	name = "Mushroom",
	curvedMushrooms = false
}

function Mushroom.plant(x, y, angle)
	local mushroom = {}
	setmetatable(mushroom, {__index = Mushroom})

	mushroom:init(x, y, angle)
end


function Mushroom:init(x, y, angle)
	print (""..world:type())
	local _body = love.physics.newBody(world, x, y, "static")
	self.body = _body
	self.body:setAngle(angle)
	self.body:setMass(15)
	if self.curvedMushrooms == true then
		self.shape = love.physics.newCircleShape(60)
	else
		self.shape = love.physics.newPolygonShape(0, 0, 150, 0, 150, 64, 0, 64)
	end
	self.fixture = love.physics.newFixture(self.body, self.shape, 1)
	self.fixture:setUserData(self)

	self.body:setFixedRotation(true)
	self.body:setLinearDamping(0)
	self.fixture:setRestitution(0)

	objects[#objects + 1] = self
end

function Mushroom:handleCollision(other, nX, nY)

	vX, vY = other.body:getLinearVelocity()
	velV = vector(vX, vY)
	normV = vector(nX, nY)
	velV:mirrorOn(normV)
	nX, nY = velV:unpack()

	other.body:applyLinearImpulse(nX, math.max(nY * self.bounceSpeed, self.maxBounceVelocity))


end

function Mushroom:draw()
	love.graphics.reset()
	if self.curvedMushrooms == true then
		love.graphics.circle('fill', self.body:getX(), self.body:getY(), self.shape:getRadius())
	else
		love.graphics.polygon('fill', self.body:getWorldPoints(self.shape:getPoints()))
	end
	
	
end

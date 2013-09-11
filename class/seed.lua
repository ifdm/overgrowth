Seed = Class {
	remove = false
}

function Seed:init(x, y, type)
	self.body = love.physics.newBody(world, x, y, 'dynamic')
	self.body:setMass(2)
	self.shape = love.physics.newCircleShape(16)
	self.fixture = love.physics.newFixture(self.body, self.shape, 1)
	self.angle = 0
	self.body:setFixedRotation(false)
	self.body:setLinearDamping(0)
	self.fixture:setRestitution(0.25)
	self.fixture:setFriction(.95)
	self.fixture:setCategory(3)
	
	--Why?
	--self.fixture:setMask(2)
	self.fixture:setUserData(self)

	self.type = type
	self.grace = 0
	self.thrown = false
	print('spawning')	
	objects[#objects + 1] = self
end

function Seed:update()
	self.grace = math.max(self.grace - tickRate, 0)
end




function Seed:handleCollision(other, nX, nY)

	if self.thrown == true and other.type == Wall then
		normalVector = vector(nX, nY)
		selfVector = normalVector:normalized()
		--selfVector = vector(1, 1)
		--selfVector:mirrorOn(normalVector)
		nX, nY = selfVector:unpack()
		self.angle = math.atan2(nX, -nY)
		plantLater(self)
	end

	if self.grace == 0 and other.inventory then
		print("Picked up seed of type " .. self.type.name)
		other.inventory[#other.inventory + 1] = self.type
		self:collect()
	end
end

function Seed:collect()

	-- Mark for object removal
	self.remove = true

	-- Remove object components
	self.fixture:destroy()
	self.body:destroy()
end

function Seed:throw()
	self.thrown = true
	-- throw shit
	local v = vector(view.camera:mousepos()) - vector(self.body:getPosition())
	self.body:setLinearVelocity(v:normalized():permul(vector(700, 700)):unpack())
end

function Seed:draw()
	love.graphics.reset()
	love.graphics.setColor(100, 175, 100)
	love.graphics.circle('fill', self.body:getX(), self.body:getY(), self.shape:getRadius())
end

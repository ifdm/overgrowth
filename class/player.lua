Player = Class {
	walkSpeed = 180,
	jumpSpeed = -1000,
	maxSpeed = 10000
}

function Player:init(x, y)
	self.body = love.physics.newBody(world, x, y, 'dynamic')
	self.body:setMass(0, 0, 1000, 0)
	self.shape = love.physics.newRectangleShape(100, 100)
	self.fixture = love.physics.newFixture(self.body, self.shape, 1)

	self.body:setFixedRotation(true)
	self.body:setLinearDamping(0)
	self.fixture:setRestitution(0)
	self.fixture:setUserData(self)

	self.inventory = {[Mushroom] = 0}

	objects[#objects + 1] = self
end

function Player:update()
	
	local vx, vy = self.body:getLinearVelocity()
	
	-- Move
	if love.keyboard.isDown('a') then
		vx = math.max(vx - self.walkSpeed * tickRate * 10, -self.walkSpeed)
	elseif love.keyboard.isDown('d') then
		vx = math.min(vx + self.walkSpeed * tickRate * 10, self.walkSpeed)
	else
		vx = math.max(math.abs(vx) - self.walkSpeed * tickRate, 0) * (vx > 0 and 1 or -1)
	end
	
	self.body:setLinearVelocity(vx, vy)
end

function Player:keyreleased(key)

	-- Stuff comes up
	xspeed, yspeed = self.body:getLinearVelocity()
	if key == 'w' and yspeed == 0 then
		self.body:applyLinearImpulse(0, self.jumpSpeed)
	end
end

function Player:handleCollision(other, collide)
	nX, nY = collide:getNormal()

	if getmetatable(other) == Mushroom then
		if nX == 0 and nY > 0 then
			self:bounce(other.bounceSpeed)
		end
	end
	
	if getmetatable(other) == Seed then
		self.inventory[other.type] = self.inventory[other.type] + 1
		other:collect()
	end
end

function Player:bounce(bounceSpeed)
	self.body:applyLinearImpulse(0, bounceSpeed)
end

function Player:draw()
	love.graphics.reset()
	love.graphics.polygon('fill', self.body:getWorldPoints(self.shape:getPoints()))
end

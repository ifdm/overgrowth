Player = Class {
	walkSpeed = 180,
	jumpSpeed = -1000,
	maxSpeed = 10000
}

function Player:init(x, y)
	self.body = love.physics.newBody(world, x, y, 'dynamic')
	self.body:setMass(0, 0, 1000, 0)
	self.shape = love.physics.newRectangleShape(64, 128)
	self.fixture = love.physics.newFixture(self.body, self.shape, 1)

	self.body:setFixedRotation(true)
	self.body:setLinearDamping(0)
	self.fixture:setRestitution(0)
	self.fixture:setUserData(self)

	self.inventory = {}
	self.canJump = true

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
		vx = math.max(math.abs(vx) - self.walkSpeed * tickRate * 2, 0) * (vx > 0 and 1 or -1)
	end
	
	self.body:setLinearVelocity(vx, vy)
end

function Player:mousereleased(x, y, button)
	if button == 'l' then
		self:throw()
	end
end

function Player:keyreleased(key)

	-- Stuff comes up
	if key == 'w' and self.canJump then
		self:bounce(self.jumpSpeed)
  -- Stuff gets selected
	elseif key >= '1' and key <= '5' then
		self.selection = key
	end
end

function Player:handleCollision(other, nX, nY)
	if nY > 0 then
		self.canJump = true
	end

	if getmetatable(other) == Mushroom then
		if nX == 0 and nY > 0 then
			self:bounce(other.bounceSpeed)
		end
	end
	
	if getmetatable(other) == Seed then
		self.inventory[#self.inventory + 1] = other.type
		other:collect()
	end
end

function Player:bounce(bounceSpeed)
	self.body:applyLinearImpulse(0, bounceSpeed)
	self.canJump = false
end

function Player:throw()
	if #self.inventory > 0 and self.inventory[self.selection] then
		local throwingSeed = Seed()
		print('throwing')	
		throwingSeed:throw(self.inventory[self.selection])

		table.remove(self.inventory, self.selection)
	end
end

function Player:draw()
	love.graphics.reset()
	love.graphics.polygon('fill', self.body:getWorldPoints(self.shape:getPoints()))
end

Player = Class {
	walkSpeed = 180,
	jumpSpeed = -1000,
	maxSpeed = 10000,
	name = "Player"
}

function Player:init(x, y)
	self.body = love.physics.newBody(world, x, y, 'dynamic')
	self.body:setMass(0, 0, 1000, 0)
	self.shape = love.physics.newRectangleShape(64, 128)
	self.fixture = love.physics.newFixture(self.body, self.shape, 1)

	self.body:setFixedRotation(true)
	self.body:setLinearDamping(0)
	self.fixture:setRestitution(0)
	self.fixture:setCategory(2)
	self.fixture:setUserData(self)

	self.inventory = {}
	self.selection = 1
	self.tick = 0

	objects[#objects + 1] = self
end

function Player:update()
	local vx, vy = self.body:getLinearVelocity()
	self.tick = (self.tick + 1)%10
	self:simulateThrow()
	--if self.tick == 3 then self:simulateThrow() end
	
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

function Player:die()
	-- self.remove = true
end

function Player:mousereleased(x, y, button)
	if button == 'l' then
		self:throw()
	end
end

--Bad. Next stop, replace this with global key listener that delegates to player.
function Player:keyreleased(key)

	-- More robust than a self-enforced canJump is a check if we're falling or going up
	if key == 'w' then
		dx, dy = self.body:getLinearVelocity()
		if dy == 0 then
			print("jumping")
			self.body:applyLinearImpulse(0, self.jumpSpeed)
		end
	elseif key == 'r' then

		print("reloaded level")
		loadLevel(level.name)

  -- Stuff gets selected
	elseif key:match('^[1-5]$') then
		self.selection = tonumber(key)
	end
end

function Player:handleCollision(other, nX, nY)
end


function Player:throw()
	local type = self.inventory[self.selection]
	if type then
		local x = self.body:getX()
		local cx, cy = view.camera:mousepos()
		-- throw from the correct side of the player
		if x < cx then
			x = x + 64 -- change this or the trajectory spawn point to match
		else
			x = x - 64 -- same as above.
		end

		local throwingSeed = Seed(x, self.body:getY(), type)
		throwingSeed.grace = 1.5
		throwingSeed:throw()
		
		table.remove(self.inventory, self.selection)
	end
end


function Player:simulateThrow()
	
	SimSeed.throw(self.body:getX(), self.body:getY())
end

function Player:draw()
	love.graphics.reset()
	love.graphics.setColor(100, 50, 150)
	love.graphics.polygon('fill', self.body:getWorldPoints(self.shape:getPoints()))
	for _, p in pairs(SimSeed.points) do
		--the +6 are an offset because seeds have a radius of 16 pixels!
		love.graphics.circle('fill', p.x+6, p.y+6, 4)
	end
end

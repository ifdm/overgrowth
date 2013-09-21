Player = Class {
	walkSpeed = 180,
	jumpSpeed = -1000,
	maxSpeed = 10000,
	infiniteSeeds = true,
	godMode = true
}

function Player:init(x, y)
	self.body = love.physics.newBody(world, x, y, 'dynamic')
	
	self.body:setMassData(0, 0, 60, 0)
	self.shape = love.physics.newRectangleShape(64, 128)
	self.fixture = love.physics.newFixture(self.body, self.shape, 1)

	self.body:setFixedRotation(true)
	self.body:setLinearDamping(0)
	self.fixture:setRestitution(0)
	self.fixture:setCategory(2)
	self.fixture:setUserData(self)

	self.debugThrow = true
	self.inventory = {}
	self.selection = 1
	self.tick = 0

	self.tbody = love.physics.newBody(simWorld, 0, 0, 'static')

	objects[#objects + 1] = self
end

function Player:update()
	local vx, vy = self.body:getLinearVelocity()
	self.tick = (self.tick + 1) % 10
	self:simulateThrow()
	
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
	if self.godMode == false then
		self.body:setLinearVelocity(0, 0)
		self.body:setPosition(Checkpoint.active.body:getX(), Checkpoint.active.body:getY())
	end
end

function Player:mousereleased(x, y, button)
	if button == 'l' then
		self:throw()
	end
end

function Player:keyreleased(key)

	-- More robust than a self-enforced canJump is a check if we're falling or going up
	if key == 'w' then
		dx, dy = self.body:getLinearVelocity()
		if dy == 0 or self.godMode == true then
			self.body:applyLinearImpulse(0, self.jumpSpeed)
		end
	elseif key == 'r' then
		level = Level('data/level/default.lua'):enter()
	elseif key:match('^[1-5]$') then
		self.selection = tonumber(key)
	elseif key == 'g' then 
		self.godMode = not self.godMode
	elseif key == 'i' then
		self.infiniteSeeds = not self.infiniteSeeds
	elseif key == 'p' then
		Seed.persistentDebug = not Seed.persistentDebug
	end
end

function Player:throw()
	local type = self.inventory[self.selection]
	
	if type then
		local throwingSeed = Seed(self.body:getX(), self.body:getY(), type)
		throwingSeed.grace = 1.5
		throwingSeed:throw()
		
		if not self.infiniteSeeds == true then
			table.remove(self.inventory, self.selection)
		end
		
		return
	end

	if self.debugThrow then		
		local throwingSeed = Seed(self.body:getX(), self.body:getY(), 'test')
		throwingSeed.grace = 1.5
		throwingSeed:throw()
	end
end

function Player:simulateThrow()
	SimSeed.throw(self.body:getX(), self.body:getY())
end

function Player:draw()
	love.graphics.reset()
	love.graphics.setColor(100, 50, 150)
	love.graphics.polygon('fill', self.body:getWorldPoints(self.shape:getPoints()))

	local a = 100
	local r = 0
	local g = 100
	local b = 100
	for _, p in pairs(SimSeed.points) do
		love.graphics.setColor(r, g, b, a)
		a = a - 1
		g = g + 1
		b = b - 1

		love.graphics.circle('fill', p.x + 6, p.y + 6, 4) -- Seed radius is 16
	end

	if SimSeed.final.x and SimSeed.final.y then
		love.graphics.setColor(160, 20, 30, 255)
		love.graphics.circle('line', SimSeed.final.x,  SimSeed.final.y, 30)
	end

	if SimSeed.preview then
		love.graphics.setColor(100, 100, 100, 100)
		local an = SimSeed.preview.a
		local sh = SimSeed.preview.s
		local xp = SimSeed.preview.xP
		local yp = SimSeed.preview.yP
		self.tbody:setPosition(xp, yp)
		self.tbody:setAngle(an)
		love.graphics.polygon('fill',self.tbody:getWorldPoints(sh:getPoints()))
	end
end

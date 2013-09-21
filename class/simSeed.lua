SimSeed = {
	initialized = false
}

function SimSeed.setupSim()
	simWorld = love.physics.newWorld(0, 10 * 64, true)
	simWorld:setCallbacks(SimSeed.simBeginCollision, f.empty, f.empty, f.empty)
end

function SimSeed.simBeginCollision(a, b, collide)
	nX, nY = collide:getNormal()
	x, y = collide:getPositions()
	a = a:getUserData()
	b = b:getUserData()
	f.exe(a.handleCollision, a, b, nX, nY, x, y)
	f.exe(b.handleCollision, b, a, nX, nY, x, y)
end

function SimSeed:init(x, y)
	self.body = love.physics.newBody(simWorld, x, y, 'dynamic')

	self.body:setMass(2)
	self.shape = love.physics.newCircleShape(16)
	self.fixture = love.physics.newFixture(self.body, self.shape, 1)
	self.body:setFixedRotation(false)
	self.body:setLinearDamping(0)
	self.fixture:setRestitution(.25)
	self.fixture:setFriction(.95)
	self.fixture:setCategory(3)

	self.fixture:setUserData(self)
	self.initialized = true
end

function SimSeed:reset(x, y)
	self.body:setPosition(x, y)
	self.body:setLinearVelocity(0, 0)
	self.grace = 1.5
	self.points = {}
	self.collected = false
	self.final = {}
	self.preview = nil
end

function SimSeed:update()
	self.grace = math.max(self.grace - tickRate, 0)
	self:recallPoint()
end

function SimSeed:recallPoint()
	self.points[#self.points + 1] = vector(self.body:getX(), self.body:getY())
end

function SimSeed:handleCollision(other, nX, nY, x, y)
	if other.__index == Wall then
		self.final = vector(x, y)
		local seed = player.inventory[player.selection]
		if seed then
			if seed.__index == Bridge or seed.__index == Mushroom then
				local a, s, xP, yP = seed:getAngleShapeAndPosition(x, y, math.atan2(nX, -nY) + math.pi)
				self.preview = {a = a, s = s, xP = xP, yP = yP}
			end
		end
		
		self:collect()
	end
end

function SimSeed:collect()
	self.collected = true
end

function SimSeed.runSim()
	for i = 0, 100, 1 do
		simWorld:update(tickRate)
		if SimSeed.collected then return end
		SimSeed:update()
	end
end

function SimSeed.throw(x, y)
	if not SimSeed.initialized then -- for efficiency
		SimSeed:init(x, y)
	end
	
	SimSeed:reset(x, y)
	
	local v = vector(view.camera:mousepos()) - vector(SimSeed.body:getPosition())
	SimSeed.body:setLinearVelocity(v:normalized():permul(vector(700, 700)):unpack())

	SimSeed.runSim()
	SimSeed:collect()
end
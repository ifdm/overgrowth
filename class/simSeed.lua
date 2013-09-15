SimSeed = {
	initialized = false,
	name = "SimSeed"
}
function SimSeed.setupSim()
	simWorld = love.physics.newWorld(0, 10 * 64, true)
	simWorld:setCallbacks(SimSeed.simBeginCollision, SimSeed.simEndCollision, SimSeed.simPreFrameResolve, SimSeed.simPostFrameResolve)
end

function SimSeed.simBeginCollision(a, b, collide)
	nX, nY = collide:getNormal()
	a = a:getUserData()
	b = b:getUserData()
	f.exe(a.handleCollision, a, b, nX, nY)
	f.exe(b.handleCollision, b, a, nX, nY)
end

function SimSeed.simEndCollision(a, b, collide)
	
end

function SimSeed.simPreFrameResolve(a, b, collide)
	
end

function SimSeed.simPostFrameResolve(a, b, collide)

end

function SimSeed:init(x, y)

	self.body = love.physics.newBody(simWorld, x, y, 'dynamic')

	self.body:setMass(2)
	self.shape = love.physics.newCircleShape(16)
	self.fixture = love.physics.newFixture(self.body, self.shape, 1)
	self.body:setFixedRotation(false)
	self.body:setLinearDamping(0)
	self.fixture:setRestitution(0.25)
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
end

function SimSeed:update()
	self.grace = math.max(self.grace - tickRate, 0)
	local _, yVel = self.body:getLinearVelocity()
	self:recallPoint()
end

function SimSeed:recallPoint()
self.points[#self.points + 1] = vector(self.body:getX(), self.body:getY())

end
function SimSeed:handleCollision(other, nX, nY)

	if other.type == Wall then
		self:recallPoint()
		self:collect()
	end

	if other.name == "Mushroom" then

	end

end

function SimSeed:collect()
	self.collected = true
end


function SimSeed.runSim()
	for i=0, 100, 1 do
		simWorld:update(tickRate)
		if SimSeed.collected then
			return
		end
		SimSeed:update()

	end
end
function SimSeed.throw(x, y)

	--SUPER important. Prevents massive lagmonster

	if (not SimSeed.initialized) then
		SimSeed:init(x, y)
	end

	SimSeed:reset(x, y)

	-- throw shit
	local v = vector(view.camera:mousepos()) - vector(SimSeed.body:getPosition())
	SimSeed.body:setLinearVelocity(v:normalized():permul(vector(700, 700)):unpack())

	

	SimSeed.runSim()
	SimSeed:collect()
end



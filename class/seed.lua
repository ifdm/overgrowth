Seed = Class {
	remove = false,
	name = "Seed",
	persistentDebug = false,
		-- Since planting happens during physics updates, need to queue events for later (feel free to remove if there's a better way)
	plantQueue = {}
}

function Seed:init(x, y, type)
	self.body = love.physics.newBody(world, x, y, 'dynamic')
	self.body:setMassData(0, 0, 2, 0)
	self.shape = love.physics.newCircleShape(16)
	self.fixture = love.physics.newFixture(self.body, self.shape, 1)
	self.angle = 0
	self.body:setFixedRotation(false)
	self.body:setLinearDamping(0)
	self.fixture:setRestitution(0.25)
	self.fixture:setFriction(.95)
	self.fixture:setCategory(3)
	self.body:setBullet(true)
	
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


function Seed.grow()
	for i, seed in pairs(Seed.plantQueue) do
		if not (seed.t == "test") then
			seed.t:init(seed.x, seed.y, seed.angle)
			table.remove(Seed.plantQueue, i)
		end
	end
end


function Seed:handleCollision(other, nX, nY, x, y)
	--I'm pretty sure the problem is trying to plant things DURING collision detection routine
	if self.type == "test" and self.persistentDebug then
		return
	end
	

	if self.thrown == true and other.type == Wall then
		nX, nY = vector(nX, nY):normalized():unpack()
		local angle = math.atan2(nX, -nY) + math.pi
		self.plantQueue[#self.plantQueue + 1] = {
			t = self.type,
			x = x,
			y = y,
			angle = angle
		}
		self:collect()
	end

	if self.grace == 0 and other.inventory and not (self.type == "test") then
		print('Picked up seed of type ' .. self.type.name)
		other.inventory[#other.inventory + 1] = self.type
		self:collect()
	end
end

function Seed:collect()
	-- Mark for object removal
	self.remove = true
end

function Seed:destroy()
	self.fixture:destroy()
end

function Seed:throw()
	self.fixture:setMask(2)
	
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

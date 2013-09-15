Laser = Class{
	maxLength = 500,
	name = "Laser",
	radius = 30,
	curLaserForGlobalRaycast,
	mode_circular = 0,
	mode_static = 1,
	mode_sweep = 2,
	step = math.pi/400
}

function Laser.create(x, y, angle, mode)
	print(mode)
	Laser(x, y, angle, mode)
end

function Laser:init(x, y, angle, mode)
	--CREATE BODY
	local _body = love.physics.newBody(world, x, y, "static")
	self.body = _body
	--self.body:setAngle(angle)
	self.body:setMass(15)
	self.shape = love.physics.newCircleShape(self.radius)
	self.fixture = love.physics.newFixture(self.body, self.shape, 1)
	self.fixture:setUserData(self)

	self.body:setFixedRotation(true)
	self.body:setLinearDamping(0)
	self.fixture:setRestitution(0)

	--END BODY


	--DO SETUP
	self.direction = 1 --positive
	self.mode = self.mode_circular
	self.hits = {}

	self.targetX = x
	self.targetY = y
	self.startAngle = angle
	self.angle = angle
	self.mode = mode
	
	--END SETUP

	--self.angle = self.angle + (self.step * self.direction)
	self.unitVector = vector(math.cos(self.angle), math.sin(self.angle))
	self.unitVector = self.unitVector:normalized()
	self.offsetVector = vector(self.targetX, self.targetY)
	self.laserPoint = (self.offsetVector + self.unitVector * self.maxLength):clone()
	

	self.activated = true

	objects[#objects + 1] = self
end

function LaserRayCastCallback(fixture, x, y, xn, yn, fraction)
	--Easy optimization to do later: replace this with a priority queue
	if not fixture:getUserData() then return -1 end

	Laser.curLaserForGlobalRaycast.hits[#Laser.curLaserForGlobalRaycast.hits + 1] = {
		x = x,
		y = y,
		object = fixture:getUserData()
	}


	return 1

end

function Laser:update()



	if self.mode == self.mode_sweep and math.abs(self.startAngle - self.angle) > math.pi/8 then
		self.direction = self.direction * -1
	end
	--Update angle
	if self.mode == self.mode_circular or self.mode == self.mode_sweep then
		self.angle = self.angle + (self.step * self.direction)
		self.unitVector = vector(math.cos(self.angle), math.sin(self.angle))
		self.unitVector = self.unitVector:normalized()
		self.offsetVector = vector(self.targetX, self.targetY)
		self.laserPoint = (self.offsetVector + self.unitVector * self.maxLength):clone()
		
	end


	self.endPoint = self.laserPoint:clone()
	Laser.curLaserForGlobalRaycast = self
	world:rayCast(self.targetX, self.targetY, self.laserPoint.x, self.laserPoint.y, LaserRayCastCallback)

	local hit = {}
	local minSquareDist = self.maxLength^2
	for _, h in pairs(self.hits) do
		local dist = (h.x - self.targetX)^2 + (h.y - self.targetY)^2
		if(dist < minSquareDist) then
			self.endPoint = vector(h.x, h.y)
			hit = h
			minSquareDist = dist
		end
		
	end
	self.hits = {}

	if hit.object then
		local name = hit.object.name
		if name then
			--print(name)
			if name == Player.name then
				hit.object:die()
			end
		end
	end



end



function Laser:activate()

	
end

function Laser:deactivate()

end



function Laser:draw()
	love.graphics.reset()
	love.graphics.setColor(255, 0, 0)
	love.graphics.circle("fill", self.endPoint.x, self.endPoint.y, 5)
	love.graphics.line(self.endPoint.x, self.endPoint.y, self.offsetVector.x, self.offsetVector.y)
	love.graphics.setColor(122, 122 ,122)
		love.graphics.circle('fill', self.body:getX(), self.body:getY(), self.shape:getRadius())

end

Laser = Class{
	maxLength = 500,
	name = "Laser",
	boxWidth = 30,
	boxHeight = 80,
	curLaserForGlobalRaycast
}

function Laser.create(x, y, angle)
	Laser:init(x, y, angle)
end

function Laser:init(x, y, angle)
	local _body = love.physics.newBody(world, x, y, "static")
	self.body = _body
	--self.body:setAngle(angle)
	self.body:setMass(15)
	self.shape = love.physics.newPolygonShape(0, 0, self.boxWidth, 0, self.boxWidth, self.boxHeight, 0, self.boxHeight)
	self.fixture = love.physics.newFixture(self.body, self.shape, 1)
	self.fixture:setUserData(self)

	self.body:setFixedRotation(true)
	self.body:setLinearDamping(0)
	self.fixture:setRestitution(0)

	self.hits = {}

	self.targetX = x + (self.boxWidth/2)
	self.targetY = y + (self.boxHeight/2)
	print("Angle " ..angle)
	self.unitVector = vector(math.cos(angle), math.sin(angle))
	self.unitVector = self.unitVector:normalized()
	self.offsetVector = vector(x + (self.boxWidth/2), y)
	self.laserPoint = (self.offsetVector + self.unitVector * self.maxLength):clone()
	self.endPoint = self.laserPoint:clone()

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
	love.graphics.setColor(122, 122 ,122)
	love.graphics.polygon('fill', self.body:getWorldPoints(self.shape:getPoints()))
	love.graphics.setColor(255, 0, 0)
	love.graphics.circle("fill", self.endPoint.x, self.endPoint.y, 5)
	love.graphics.line(self.endPoint.x, self.endPoint.y, self.offsetVector.x, self.offsetVector.y)

end

Fan = Class{
	name = "Fan",
	radius = 400,
	radius2 = 450,
	width = 50,
	height = 128,
	fanForRaycast = nil, 
	donothit = {}
}

function Fan.create(x, y, angle, force)
	Fan(x, y, angle, force)
end

function Fan:init(x, y, angle, force)
	--CREATE BODY
	local _body = love.physics.newBody(world, x, y, "static")
	self.body = _body
	self.body:setAngle(angle)
	self.body:setMass(15)
	self.shape = love.physics.newPolygonShape(0, 0, self.width, 0, self.width, self.height, 0, self.height)
	self.fixture = love.physics.newFixture(self.body, self.shape, 1)
	self.fixture:setUserData(self)

	self.body:setFixedRotation(true)
	self.body:setLinearDamping(0)
	self.fixture:setRestitution(0)

	--END BODY

	self.force = force
	self.lines = {}
	self.curHeap = {}

	self.unitVector = vector(math.cos(angle), math.sin(angle)):normalize_inplace()
	self.orthVector = vector(math.cos(angle + math.pi/2), math.sin(angle + math.pi/2))


	for i=0, self.height, 16 do
		local cX = x + self.orthVector.x * i
		local cY = y + self.orthVector.y * i

		self.offsetVector = vector(cX, cY)
		local startPoint = (self.offsetVector + self.unitVector * self.radius):clone()
		local endPoint = (self.offsetVector + self.unitVector * (self.radius * -1)):clone()
		self.lines[#self.lines + 1] = {
			x0 = cX,
			y0 = cY,
			x1 = startPoint.x,
			y1 = startPoint.y
			
		}
		self.lines[#self.lines + 1] = {
			x0 = cX,
			y0 = cY,
			x1 = endPoint.x,
			y1 = endPoint.y
		}
		

	end

	self.activated = true

	objects[#objects + 1] = self
end

function FanRayCastCallback(fixture, x, y, xn, yn, fraction)
	if not fixture:getUserData().name then return -1 end

	Fan.fanForRaycast.hits[#Fan.fanForRaycast.hits + 1] = {
		x = x,
		y = y,
		object = fixture:getUserData()
	}

	return 1

end

function Fan:update()
	self.lineEnds = {}

	Fan.fanForRaycast = self
	for i, line in pairs(self.lines) do
		self.curLine = i
		self.hits = {}
		self.targetX = line.x0
		self.targetY = line.y0
		world:rayCast(line.x0, line.y0, line.x1, line.y1, FanRayCastCallback)
		
		self.lineEnds[i] = {
			x0 = line.x0,
			y0 = line.y0,
			x1 = line.x1,
			y1 = line.y1,
			text = ""
		}
		
		self.lineEnds[i].x0 = line.x0
		self.lineEnds[i].y0 = line.y0
		local hit = {}
		local minSquareDist = self.radius2^2

		for _, h in pairs(self.hits) do 
			local dist = (h.x - self.targetX)^2 + (h.y - self.targetY)^2
			if(dist < minSquareDist) then
				self.endPoint = vector(h.x, h.y)
				hit = h
				minSquareDist = dist
			end
		end

		if hit.object then
			self.lineEnds[i].x1 = hit.x
			self.lineEnds[i].y1 = hit.y
			self.lineEnds[i].text = "r = " .. math.floor(minSquareDist)

			local body = hit.object.body
			if body then
				if body:getType() == "dynamic" then
					local force = (self.radius2^2 - minSquareDist) * self.force
					body:applyForce(force * self.unitVector.x, force * self.unitVector.y)
				end
			end
		end
	end

end

function Fan:handleCollision(other, nX, nY)
	if other.name then
		print (other.name)
	end
	if other.name == "Player" then
		other:die()
	end

end

function Fan:activate()

	
end

function Fan:deactivate()

end



function Fan:draw()
	love.graphics.reset()
	love.graphics.setColor(120, 120, 120)
	love.graphics.polygon('fill', self.body:getWorldPoints(self.shape:getPoints()))

	for _, line in pairs(self.lineEnds) do
		love.graphics.line(line.x0, line.y0, line.x1, line.y1)
		love.graphics.circle("fill", line.x1, line.y1, 2)
		love.graphics.print(line.text, line.x1, line.y1)
	end
end

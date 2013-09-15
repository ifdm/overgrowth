Fan = Class{
	name = "Fan",
	radius = 400,
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
	self.shape = love.physics.newPolygonShape(0, 0, 64, 0, 64, 128, 0, 128)
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
	self.targetX = x + (self.unitVector.x * 32) + (self.unitVector.y * 64)
	self.targetY = y + (self.unitVector.x * 32) + (self.unitVector.y * 64)

	print("angle "..angle)
	print(self.unitVector)


	for i=0, 128, 8 do
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
	if not (fixture:getBody():getType() == "dynamic") then return -1 end
	--if Fan.donothit[fixture] then return -1 end

	--Fan.donothit[fixture] = 1
	Fan.fanForRaycast.lineEnds[Fan.fanForRaycast.curLine] = {
		x0 = nil,
		y0 = nil,
		x1 = x,
		y1 = y
	}
	local dist = (x - Fan.fanForRaycast.targetX)^2 + (y - Fan.fanForRaycast.targetY)^2
	Fan.fanForRaycast.curHeap:push(fixture, dist)
				print("dist ".. dist)

	--local body = fixture:getBody()
	--body:applyForce((Fan.radius - dist) * Fan.fanForRaycast.force, 0)
	
	--if(fixture:getUserData().name == "Player") then 
		--print("Fan hit something "..fixture:getUserData().name .. " x "..x .. ", y".. y .. ", dist " .. dist .. ", force " .. ((1000 - dist) * 0.35))
	--end

	return 1

end

function Fan:update()
	Fan.donothit = {}
	self.lineEnds = {}
	Fan.fanForRaycast = self
	for i, line in pairs(self.lines) do
		self.curHeap = Heap()
		self.curLine = i
		world:rayCast(line.x0, line.y0, line.x1, line.y1, FanRayCastCallback)
		if not self.lineEnds[i] then
			self.lineEnds[i] = {
				x0 = nil,
				y0 = nil,
				x1 = line.x1,
				y1 = line.y1
			}
		end
		self.lineEnds[i].x0 = line.x0
		self.lineEnds[i].y0 = line.y0
		if not self.curHeap:isempty() then
			local fixture, dist = self.curHeap:pop()
			if fixture then
				local body = fixture:getBody()
				if body then
					local force = (self.radius - dist) * self.force
					print("Force " .. force)
					body:applyForce(force * self.unitVector.x, force * self.unitVector.y)
				end
			end
		end
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

	end
end

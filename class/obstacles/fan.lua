Fan = Class{
	name = "Fan",
	strength = 0.25,
	radius = 400,
	fanForRaycast = nil, 
	donothit = {}
}

function Fan.create(x, y, angle)
	Fan(x, y, angle)
end

function Fan:init(x, y, angle)
	--CREATE BODY
	local _body = love.physics.newBody(world, x, y, "static")
	self.body = _body
	--self.body:setAngle(angle)
	self.body:setMass(15)
	self.shape = love.physics.newPolygonShape(0, 0, 64, 0, 64, 128, 0, 128)
	self.fixture = love.physics.newFixture(self.body, self.shape, 1)
	self.fixture:setUserData(self)

	self.body:setFixedRotation(true)
	self.body:setLinearDamping(0)
	self.fixture:setRestitution(0)

	--END BODY

	self.lines = {}

	self.targetX = x + 32

	local x0 = self.targetX - self.radius
	local x1 = self.targetX + self.radius

	for i=y, y+128, 8 do
		self.lines[#self.lines + 1] = {
			x0 = x0,
			y0 = i,
			x1 = x1,
			y1 = i
		}

	end



	self.activated = true

	objects[#objects + 1] = self
end

function FanRayCastCallback(fixture, x, y, xn, yn, fraction)
	if not fixture:getUserData().name then return -1 end
	if not (fixture:getBody():getType() == "dynamic") then return -1 end
	if Fan.donothit[fixture] then return -1 end

	Fan.donothit[fixture] = 1
	local dist = (x - Fan.fanForRaycast.targetX)
	local body = fixture:getBody()
	body:applyForce((Fan.radius - dist) * Fan.strength, 0)
	
	if(fixture:getUserData().name == "Player") then 
		print("Fan hit something "..fixture:getUserData().name .. " x "..x .. ", y".. y .. ", dist " .. dist .. ", force " .. ((1000 - dist) * 0.35))
	end

	return 1

end

function Fan:update()
	Fan.donothit = {}
	Fan.fanForRaycast = self
	for _, line in pairs(self.lines) do
		world:rayCast(line.x0, line.y0, line.x1, line.y1, FanRayCastCallback)

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

	for _, line in pairs(self.lines) do
		love.graphics.line(line.x0, line.y0, line.x1, line.y1)

	end
end

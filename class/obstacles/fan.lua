Fan = Class{
	name = "Fan",
	strength = 500
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
	local x0 = x - 100
	local x1 = x + 100

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
	--Easy optimization to do later: replace this with a priority queue
	if not fixture:getUserData() then return -1 end

	Laser.curLaserForGlobalRaycast.hits[#Laser.curLaserForGlobalRaycast.hits + 1] = {
		x = x,
		y = y,
		object = fixture:getUserData()
	}


	return 1

end

function Fan:update()


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

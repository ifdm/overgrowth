Bridge = Class {
	name = "Bridge"
}



function Bridge.plant(x, y, angle)
	local bridge = {}
	setmetatable(bridge, {__index = Bridge})
	bridge:init(x, y, angle)

end



function Bridge:init(x, y, angle)
	local _body = love.physics.newBody(world, x, y, "static")
	self.body = _body
	self.body:setAngle(angle)
	self.body:setMass(15)
	self.shape = love.physics.newPolygonShape(0, 0, 150, 0, 150, 64, 0, 64)
	self.fixture = love.physics.newFixture(self.body, self.shape, 1)
	self.fixture:setUserData(self)

	self.body:setFixedRotation(true)
	self.body:setLinearDamping(0)
	self.fixture:setRestitution(0)

	objects[#objects + 1] = self
end


function Bridge:draw()
	love.graphics.reset()
	love.graphics.setColor(30, 150, 30)
	love.graphics.polygon('fill', self.body:getWorldPoints(self.shape:getPoints()))
end

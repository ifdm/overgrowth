PhysTrigger = Class {
	visible = true
}

function PhysTrigger:init(x, y, w, h, func)
	self.func = func

	self.body = love.physics.newBody(world, x, y, 'static')
	self.shape = love.physics.newPolygonShape(0, 0, w, 0, w, h, 0, h)
	self.fixture = love.physics.newFixture(self.body, self.shape, 1)
	self.fixture:setUserData(self)

	self.body:setFixedRotation(true)
	self.body:setLinearDamping(0)
	self.body:setSensor(true)
end

function PhysTrigger:handleCollision(other, nX, nY, x, y)
	if other.__index == Player then self.func() end
end

function PhysTrigger:draw()
	if self.visible then
		love.graphics.reset()
		love.graphics.setColor(0, 0, 200)
		love.graphics.polygon('fill', self.body:getWorldPoints(self.shape:getPoints()))
	end
end
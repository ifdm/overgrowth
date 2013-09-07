Player = Class {
	walkSpeed = 1000,
	jumpSpeed = -1000,
	maxSpeed = 10000
}

function Player:init()
	self.body = love.physics.newBody(world, x, y, 'dynamic')
	self.body:setMass(10)
	self.shape = love.physics.newRectangleShape(100, 100)
	self.fixture = love.physics.newFixture(self.body, self.shape, 1)

	self.body:setFixedRotation(true)
	self.body:setLinearDamping(0)
	self.fixture:setRestitution(0)
	self.fixture:setFriction(.95)
end

function Player:update()
	
	-- Move
	if love.keyboard.isDown('a') then
		self.body:applyForce(-self.walkSpeed, 0)
	elseif love.keyboard.isDown('d') then
		self.body:applyForce(self.walkSpeed, 0)
	end
end

function Player:keyreleased(key)

	-- Stuff comes up
	xspeed, yspeed = self.body:getLinearVelocity()
	print(yspeed)
	if key == 'w' and yspeed == 0 then
		self.body:applyLinearImpulse(0, self.jumpSpeed)
	end
end

function Player:draw()
	love.graphics.reset()
	love.graphics.polygon('fill', self.body:getWorldPoints(self.shape:getPoints()))
end

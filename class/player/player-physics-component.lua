PlayerPhysicsComponent = {
	name = 'PlayerPhysicsComponent'
}

function PlayerPhysicsComponent:init(data)
	self.body = love.physics.newBody(Game.level.world, data.x, data.y, 'dynamic')
	self.shape = love.physics.newRectangleShape(0, 0, data.w, data.h)
	self.direction = vector(0, 0)
	
	self.grounded = false

	PhysicsComponent.init(self)

	self.fixture:setFriction(.5)
end

function PlayerPhysicsComponent:update()
	self.body:applyForce(self.direction:unpack())
end

function PlayerPhysicsComponent:move(key)
	local down = love.keyboard.isDown(key)
	
	self.direction = vector(0, 0)
	if key == 'a' then self.direction.x = down and -self.moveSpeed or 0 end
	if key == 'd' then self.direction.x = down and self.moveSpeed or 0 end
end

function PlayerPhysicsComponent:jump()
	if self.grounded then
		self.body:applyLinearImpulse(0, -self.jumpSpeed)
		self.grounded = false
	end
end

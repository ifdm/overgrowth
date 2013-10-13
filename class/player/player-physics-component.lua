PlayerPhysicsComponent = {
	name = 'PlayerPhysicsComponent'
}

function PlayerPhysicsComponent:init()
	self.body = love.physics.newBody(Level:all()[1].world, 400, 300, 'dynamic')
	self.shape = love.physics.newRectangleShape(0, 0, 16, 32)
	self.moveSpeed = 350
	self.jumpSpeed = 200
	self.direction = vector(0, 0)

	PhysicsComponent.init(self)
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
	self.body:applyLinearImpulse(0, -self.jumpSpeed)
end
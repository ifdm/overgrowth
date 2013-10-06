PlayerPhysicsComponent = {
	name = 'PlayerPhysicsComponent'
}

function PlayerPhysicsComponent:init()
	self.body = love.physics.newBody(world, 400, 300, 'dynamic')
	self.shape = love.physics.newRectangleShape(0, 0, 16, 32)
	
	PhysicsComponent.init(self)
end
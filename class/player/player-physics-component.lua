PlayerPhysicsComponent = {
	name = 'PlayerPhysicsComponent'
}

function PlayerPhysicsComponent:init()
	self.body = love.physics.newBody(Level:all()[1].world, 400, 300, 'dynamic')
	self.shape = love.physics.newRectangleShape(0, 0, 16, 32)
	
	PhysicsComponent.init(self)
end
WallPhysicsComponent = {
	name = 'WallPhysicsComponent'
}

function WallPhysicsComponent:init()
	self.body = love.physics.newBody(Level:all()[1].world, x, y, 'dynamic')
	self.shape = love.physics.newRectangleShape(0, 0, 32, 32)
	
	PhysicsComponent.init(self)
end
WallPhysicsComponent = {
	name = 'WallPhysicsComponent'
}

function WallPhysicsComponent:init()
	self.body = love.physics.newBody(world, x, y, 'dynamic')
	self.shape = love.physics.newRectangleShape(0, 0, 32, 32)
	
	PhysicsComponent.init(self)
end
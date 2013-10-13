WallPhysicsComponent = {
	name = 'WallPhysicsComponent'
}

function WallPhysicsComponent:init()
	self.body = love.physics.newBody(Level:all()[1].world, 400, 384, 'kinematic')
	self.shape = love.physics.newRectangleShape(0, 0, 800, 200)
	
	PhysicsComponent.init(self)
end
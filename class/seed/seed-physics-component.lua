SeedPhysicsComponent = {
	name = 'SeedPhysicsComponent'
}

function SeedPhysicsComponent:init()
	self.body = love.physics.newBody(Level:all()[1].world, 400, 300, 'dynamic')
	self.shape = love.physics.newCircleShape(0, 0, 10)
	
	PhysicsComponent.init(self)
end
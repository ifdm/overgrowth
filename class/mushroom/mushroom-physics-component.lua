MushroomPhysicsComponent = {
	name = 'MushroomPhysicsComponent'
}

function MushroomPhysicsComponent:init()
	self.body = love.physics.newBody(Game.level.world, 200, 84, 'dynamic')
	self.shape = love.physics.newRectangleShape(0, 0, 30, 30)

	PhysicsComponent.init(self)
end
WallPhysicsComponent = {
	name = 'WallPhysicsComponent'
}

function WallPhysicsComponent:init()
	self.body = love.physics.newBody(Game.level.world, 400, 384, 'kinematic')
	self.shape = love.physics.newRectangleShape(0, 0, 800, 200)
	
	PhysicsComponent.init(self)
end
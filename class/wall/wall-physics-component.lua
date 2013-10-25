WallPhysicsComponent = {
	name = 'WallPhysicsComponent'
}

function WallPhysicsComponent:init(data)
	self.body = love.physics.newBody(Game.level.world, data.x, data.y, 'kinematic')
	self.shape = love.physics.newRectangleShape(0, 0, data.w, data.h)
	
	PhysicsComponent.init(self)
end

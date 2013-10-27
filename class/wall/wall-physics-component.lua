WallPhysicsComponent = {
	name = 'WallPhysicsComponent'
}

function WallPhysicsComponent:init(data)
	self.body = love.physics.newBody(Game.level.world, data.x, data.y, 'kinematic')
	self.shape = love.physics.newChainShape(true, unpack(data.points))

	self.points = {self.body:getWorldPoints(unpack(data.points))}
	
	PhysicsComponent.init(self)
end

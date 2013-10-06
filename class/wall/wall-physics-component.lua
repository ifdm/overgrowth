WallPhysicsComponent = {
	name = 'WallPhysicsComponent'
}

function WallPhysicsComponent:init()
	self.body = love.physics.newBody(Level:all()[1].world, x, y, 'static')
	self.shape = love.physics.newRectangleShape(0, 0, 800, 32)
	self.body:setY(600 - 32)
	
	PhysicsComponent.init(self)
end
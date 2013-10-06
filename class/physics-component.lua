PhysicsComponent = {
	name = 'PhysicsComponent'
}

function PhysicsComponent:init()
	if self.body and self.shape then
		self.fixture = love.physics.newFixture(self.body, self.shape, 1.0)
	end
end

function PhysicsComponent:update()
	if self.body then
		self.x = self.body:getX()
		self.y = self.body:getY()
	end
end
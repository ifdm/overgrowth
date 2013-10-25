PhysicsComponent = {
	name = 'PhysicsComponent'
}

function PhysicsComponent:init()
	if self.body and self.shape then
		self.fixture = love.physics.newFixture(self.body, self.shape, 1.0)
		self.fixture:setUserData(self)
	end
end

function PhysicsComponent:destroy()
	if self.body then self.body:destroy() end
end

function PhysicsComponent:update()
	if self.body then
		self.x = self.body:getX()
		self.y = self.body:getY()
	end
end

function PhysicsComponent:getBoundingBox()
	if self.body and self.shape then
		local tx, ty, bx, by = self.shape:computeAABB(self.body:getX(), self.body:getY(), 0)
		return tx, ty, bx - tx, by - ty
	end
end

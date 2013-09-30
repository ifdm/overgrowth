SeedPhysicsComponent = {
	name = 'SeedPhysicsComponent'
}

function SeedPhysicsComponent:init()
	PhysicsComponent.init(self)
end

function SeedPhysicsComponent:update()
	self.state.acc = gravity * unitSize
	PhysicsComponent.update(self)
end
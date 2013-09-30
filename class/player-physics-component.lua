PlayerPhysicsComponent = {
	name = 'PlayerPhysicsComponent'
}

function PlayerPhysicsComponent:init()
	PhysicsComponent.init(self)
end

function PlayerPhysicsComponent:left()
	self.state.vel.x = -1
end

function PlayerPhysicsComponent:right()
	self.state.vel.x = 1
end

function PlayerPhysicsComponent:update()
	self.state.acc = gravity * unitSize
	PhysicsComponent.update(self)
end
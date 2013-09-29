PhysicsComponent = {
	name = 'PhysicsComponent'
}

function PhysicsComponent:init()
	self.state.pos = vector(0, 0)
	self.state.vel = vector(0, 0)
	self.state.acc = vector(0, 0)
end

function PhysicsComponent:update()
	self.state.vel = self.state.vel + self.state.acc * tickRate
	self.state.pos = self.state.pos + self.state.vel * tickRate
end
PlayerPhysicsComponent = {
	name = 'PlayerPhysicsComponent'
}

function PlayerPhysicsComponent:left()
	self.state.vel.x = -1
end

function PlayerPhysicsComponent:right()
	self.state.vel.x = 1
end
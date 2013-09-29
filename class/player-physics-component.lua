PlayerPhysicsComponent = {
	name = 'PlayerPhysicsComponent'
}

function PlayerPhysicsComponent:init()
	print('asdf')
	PhysicsComponent.init(self)
end

function PlayerPhysicsComponent:left()
	self.state.vel.x = -1
end

function PlayerPhysicsComponent:right()
	self.state.vel.x = 1
end
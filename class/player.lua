Player = Class {
	name = 'Player',

	controls = {
		keyreleased = {
			a = 'left',
			d = 'right',
			w = 'jump'
		}
	},
	
	components = {PhysicsComponent, ControlComponent, DrawComponent}
}

Player:include(Entity)

function Player:init()
	Entity.init(self)
end
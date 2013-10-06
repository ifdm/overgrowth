Player = Class {
	name = 'Player',

	controls = {
		keyreleased = {
			a = 'left',
			d = 'right',
			w = 'jump'
		}
	},
	
	render = {
		rectangle = function(self)
			return 'fill', self.x, self.y, 16, 32
		end,
	},
	
	components = {PhysicsComponent, ControlComponent, DrawComponent}
}

Player:include(Entity)

function Player:init()
	Entity.init(self)
end
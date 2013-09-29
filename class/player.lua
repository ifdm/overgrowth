Player = Class {
	name = 'Player',
	
	controls = {
		keyreleased = {
			a = 'left',
			d = 'right',
			w = 'jump'
		}
	},
	
	components = {ControlComponent, CollideComponent}
}

Player:include(Entity)
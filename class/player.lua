Player = Class {
	name = 'Player',
	
	controls = {
		keyreleased = {
			a = 'left',
			d = 'right',
			w = 'jump'
		}
	},
	
	components = {Controllable, Collideable}
}

Player:include(Entity)
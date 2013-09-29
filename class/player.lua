Player = Class {
	name = 'Player',
	
	controls = {
		keyreleased = {
			a = 'left',
			d = 'right',
			w = 'jump'
		}
	},
	
	state = {
		
	},
	
	components = {ControlComponent, CollideComponent, PhysicsComponent}
}

Player:include(Entity)
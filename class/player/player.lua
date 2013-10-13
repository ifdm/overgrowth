Player = Class {
	name = 'Player',

	controls = {
		keypressed = {
			a = 'move',
			d = 'move',
			w = 'jump'
		},

		keyreleased = {
			a = 'move',
			d = 'move',
		}
	},
	
	render = {
		rectangle = function(self)
			love.graphics.setColor(255, 255, 255)
			return 'fill', self:getBoundingBox()
		end
	},

	moveSpeed = 350,
	jumpSpeed = 200,
	
	components = {PhysicsComponent, ControlComponent, DrawComponent},
	__includes = Entity
}
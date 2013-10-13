Player = Class {
	name = 'Player',

	controls = {
		keyreleased = {
			--[[a = 'left',
			d = 'right',
			w = 'jump']]
		}
	},
	
	render = {
		rectangle = function(self)
			love.graphics.setColor(255, 255, 255)
			return 'fill', self:getBoundingBox()
		end
	},
	
	components = {PhysicsComponent, ControlComponent, DrawComponent},
	__includes = Entity
}
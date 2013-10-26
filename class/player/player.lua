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

	collideWith = {
		['*'] = function(self, other, dx, dy)
			if other:isa(Wall) and dy < 0 then
				self.grounded = true
			end
		end
	},

	moveSpeed = 350,
	jumpSpeed = 200,
	
	components = {PhysicsComponent, ControlComponent, DrawComponent},
	__includes = Entity
}

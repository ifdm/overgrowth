Mushroom = Class {
	name = 'Mushroom',
	
	render = {
		rectangle = function(self)
			love.graphics.setColor(64, 128, 64)
			return 'fill', self:getBoundingBox()
		end
	},

	editor = {
		meta = {
			name = 'Mushroom',
			icon = 'iconMushroom.png'
		},
		
		tools = {
			'select',
			'move'
		}
	},

	bounceSpeed = 450,

	collideWith = {
		['*'] = function(self, other, dx, dy)
			if other.body then other.body:applyLinearImpulse(0, -self.bounceSpeed) end
		end
	},
	
	components = {PhysicsComponent, DrawComponent, EditorComponent},
	__includes = Entity
}
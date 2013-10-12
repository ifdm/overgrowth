Wall = Class {
	name = 'Wall',
	
	render = {
		rectangle = function(self)
			love.graphics.setColor(255, 255, 255)
			return 'fill', self.x, self.y, 16, 16
		end
	},
	
	editor = {
		meta = {
			name = 'Wall',
			icon = 'iconWall.png'
		},
		
		tools = {
			polygon = 'points',
			move = function(x, y)
				self.body:setPosition(x, y)
			end
		}
	},
	
	components = {PhysicsComponent, DrawComponent, EditorComponent},
	__includes = Entity
}
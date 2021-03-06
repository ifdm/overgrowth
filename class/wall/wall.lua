Wall = Class {
	name = 'Wall',
	
	render = {
		polygon = function(self)
			love.graphics.setColor(255, 255, 255)
			return 'fill', self.points
		end
	},
	
	editor = {
		meta = {
			name = 'Wall',
			icon = 'iconWall.png'
		},
		
		tools = {
			'select',
			'move',
			'polygon'
		}
	},
	
	components = {PhysicsComponent, DrawComponent, EditorComponent},
	__includes = Entity
}
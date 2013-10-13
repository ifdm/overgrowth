Wall = Class {
	name = 'Wall',
	
	render = {
		rectangle = function(self)
			love.graphics.setColor(255, 255, 255)
			return 'fill', self:getBoundingBox()
		end
	},
	
	editor = {
		meta = {
			name = 'Wall',
			icon = 'iconWall.png'
		},
		
		tools = {
			'select',
			'polygon',
			'move'
		}
	},
	
	components = {PhysicsComponent, DrawComponent, EditorComponent},
	__includes = Entity
}
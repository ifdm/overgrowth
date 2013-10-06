Wall = Class {
	name = 'Wall',
	
	render = {
		rectangle = function(self)
			return 'fill', self.x, self.y, 16, 16
		end
	},
	
	components = {PhysicsComponent, DrawComponent}
}

Wall:include(Entity)

function Wall:init()
	Entity.init(self)
end
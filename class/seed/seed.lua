Seed = Class {
	name = 'Seed',
	render = {
		circle = function(self)
			love.graphics.setColor(255, 0, 0)
			return 'fill', self.x, self.y, 6
		end
	},
	components = {PhysicsComponent, DrawComponent},
	__includes = Entity
}
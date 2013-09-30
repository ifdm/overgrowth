SeedDrawComponent = {
	name = 'SeedDrawComponent'
}

function SeedDrawComponent:init()
	self.state.mask = {}
	self.state.mask.width = 1
	self.state.mask.height = 1
end

function SeedDrawComponent:draw()
	love.graphics.setColor(100, 255, 100, 255)
	love.graphics.circle('fill', self.state.pos.x + (self.state.mask.width / 2 * unitSize), self.state.pos.y + (self.state.mask.height / 2 * unitSize), self.state.mask.width / 2 * unitSize)
end
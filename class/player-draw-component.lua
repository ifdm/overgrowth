PlayerDrawComponent = {
	name = 'PlayerDrawComponent'
}

function PlayerDrawComponent:init()
	self.state.mask = {}
	self.state.mask.width = 1
	self.state.mask.height = 2
end

function PlayerDrawComponent:draw()
	love.graphics.setColor(0, 0, 0, 255)
	love.graphics.rectangle('fill', self.state.pos.x, self.state.pos.y, self.state.mask.width * unitSize, self.state.mask.height * unitSize)
end
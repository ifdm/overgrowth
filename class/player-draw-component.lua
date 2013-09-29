PlayerDrawComponent = {
	name = 'PlayerDrawComponent'
}

function PlayerDrawComponent:init()
	self.width = 1
	self.height = 2
end

function PlayerDrawComponent:draw()
	love.graphics.setColor(0, 0, 0, 255)
	love.graphics.rectangle('fill', self.state.pos.x, self.state.pos.y, self.width * unitSize, self.height * unitSize)
end
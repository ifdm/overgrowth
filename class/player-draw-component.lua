PlayerDrawComponent = {
	name = 'PlayerDrawComponent',
	width = 1,
	height = 2
}

function PlayerDrawComponent:draw()
	love.graphics.setColor(0, 0, 0, 255)
	love.graphics.rectangle("fill", self.x, self.y, width * unitSize, height * unitSize)
end
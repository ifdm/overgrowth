WallDrawComponent = {
	name = 'WallDrawComponent'
	width = 1,
	height = 1
}

function WallDrawComponent:draw()
	love.graphics.setColor(255, 255, 255, 255)
	love.graphics.rectangle("fill", self.x, self.y, width * unitSize, height * unitSize)
end
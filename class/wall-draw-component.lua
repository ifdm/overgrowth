WallDrawComponent = {
	name = 'WallDrawComponent'
}

function WallDrawComponent:init()
	self.width = 1
	self.height = 1
end

function WallDrawComponent:draw()
	love.graphics.setColor(255, 255, 255, 255)
	love.graphics.rectangle('fill', self.state.pos.x, self.state.pos.y, self.width * unitSize, self.height * unitSize)
end
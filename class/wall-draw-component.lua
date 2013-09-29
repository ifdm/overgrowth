WallDrawComponent = {
	name = 'WallDrawComponent'
}

function WallDrawComponent:init()
	self.state.mask = {}
	self.state.mask.width = 1
	self.state.mask.height = 1
end

function WallDrawComponent:draw()
	love.graphics.setColor(255, 255, 255, 255)
	love.graphics.rectangle('fill', self.state.pos.x, self.state.pos.y, self.state.mask.width * unitSize, self.state.mask.height * unitSize)
end
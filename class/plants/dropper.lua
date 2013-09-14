Class {
	name = 'Dropper'
}

function Dropper:init(x, y)
	objects[#objects + 1] = self
end

function Dropper:draw()
	love.graphics.reset()
	love.graphics.polygon('fill', self.body:getWorldPoints(self.shape:getPoints()))
end

Drop = Class {
	name = 'Drop'
}

function Drop:init(x, y)
	objects[#objects + 1] = self
end

function Drop:draw()

end

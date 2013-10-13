MushroomEditorComponent = {
	name = 'MushroomEditorComponent'
}

function MushroomEditorComponent:init()
	self.selected = false
end

function MushroomEditorComponent:move(delta)
	if self.selected then
		self.body:setX(self.body:getX() + delta.x)
		self.body:setY(self.body:getY() + delta.y)		
	end
end

function MushroomEditorComponent:select(x, y)
	if math.inside(x, y, self:getBoundingBox()) then
		self.selected = true
		return self
	end
end

function MushroomEditorComponent:deselect()
	self.selected = false
end

function MushroomEditorComponent:draw()
	if self.selected then
		love.graphics.setColor(0, 255, 255, 100)
		love.graphics.rectangle('fill', self:getBoundingBox())
		love.graphics.setColor(0, 255, 255, 255)
		love.graphics.rectangle('line', self:getBoundingBox())
	end
end
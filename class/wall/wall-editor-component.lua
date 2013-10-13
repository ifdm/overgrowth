WallEditorComponent = {
	name = 'WallEditorComponent'
}

function WallEditorComponent:init()
	self.selected = false
end

function WallEditorComponent:move(delta)
	if self.selected then
		self.body:setX(self.body:getX() + delta.x)
		self.body:setY(self.body:getY() + delta.y)		
	end
end

function WallEditorComponent:select(x, y)
	if math.inside(x, y, self:getBoundingBox()) then
		self.selected = true
		return self
	end
end

function WallEditorComponent:deselect()
	self.selected = false
end

function WallEditorComponent:draw()
	if self.selected then
		love.graphics.setColor(0, 255, 255, 100)
		love.graphics.rectangle('fill', self:getBoundingBox())
	end
end
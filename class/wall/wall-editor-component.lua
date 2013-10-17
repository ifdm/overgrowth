WallEditorComponent = {
	name = 'WallEditorComponent'
}

----------------
-- Core
----------------
function WallEditorComponent:init()
	self.selected = false
end

function WallEditorComponent:draw()
	if self.selected then
		love.graphics.setColor(0, 255, 255, 100)
		love.graphics.rectangle('fill', self:getBoundingBox())
		love.graphics.setColor(0, 255, 255, 255)
		love.graphics.rectangle('line', self:getBoundingBox())
	end
end

----------------
-- Move
----------------
function WallEditorComponent:move(delta)
	if self.selected then
		self.body:setX(self.body:getX() + delta.x)
		self.body:setY(self.body:getY() + delta.y)		
	end
end

----------------
-- Select
----------------
function WallEditorComponent:select(x, y)
	if math.inside(x, y, self:getBoundingBox()) then
		self.selected = true
		return self
	end
end

function WallEditorComponent:deselect()
	self.selected = false
end
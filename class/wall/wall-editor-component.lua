WallEditorComponent = {
	name = 'WallEditorComponent'
}

----------------
-- Core
----------------
function WallEditorComponent:init()
	self.selected = false
	self.skeleton = false
end

function WallEditorComponent:draw()
	if self.selected then
		if self.skeleton then
			love.graphics.setColor(255, 255, 0)
			love.graphics.polygon('line', self.points)

			for i = 1, #self.points, 2 do
				love.graphics.circle('fill', self.points[i], self.points[i+1], 5)
			end
		else
			love.graphics.setColor(0, 255, 255, 100)
			love.graphics.rectangle('fill', self:getBoundingBox())
			love.graphics.setColor(0, 255, 255, 255)
			love.graphics.rectangle('line', self:getBoundingBox())
		end
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
-- Polygon
----------------

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

----------------
-- IO
----------------
function WallEditorComponent:save()
	local x, y = self.body:getPosition()
	return {
		x = x,
		y = y,
		points = self.points
	}
end
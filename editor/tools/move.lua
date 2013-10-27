local MoveTool = {}
--used to relocate entities, outputs an x, y coordinate.

function MoveTool:activate()
	self.dragging = false
	self.dragOffset = vector()
end

function MoveTool:deactivate()
	--
end

function MoveTool:update()
	if self.dragging then
		local es = Game.entities:filter(function(e)
			return table.has(e.editor and e.editor.tools, 'move')
		end)

		local mouse = vector(love.mouse:getPosition())
		local delta = mouse - self.dragOffset
		table.with(es, function(e)
			e:move(mouse - self.dragOffset)
		end)

		self.dragOffset = mouse
	end
end

function MoveTool:draw()
	--
end

function MoveTool:mousepressed(x, y, button)
	self.dragging = true
	self.dragOffset.x, self.dragOffset.y = x, y
end

function MoveTool:mousereleased()
	self.dragging = false
end

return MoveTool, 'move'

--function over form
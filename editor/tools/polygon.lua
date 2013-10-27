local PolygonTool = {
	threshold = 10
}
--used to draw shape data, outputs a list of points.

function PolygonTool:activate()
	self.dragging = false

	for _, entity in pairs(Editor:entitiesWith('polygon')) do
		entity.skeleton, entity.selected = true, true
	end
end

function PolygonTool:deactivate()
	--
end

function PolygonTool:update()
	-- Check if we are dragging
	if self.dragging and self.selected then

	end
end

function PolygonTool:draw()
	-- 
end

function PolygonTool:mousepressed(x, y, button)
	if button == 'l' and self.selected then
		self.dragging = true
	end
end

function PolygonTool:mousereleased(x, y, button)
	if self.dragging then
		self.dragging = false
		return
	end

	if button == 'l' then
		if love.keyboard.isDown('lshift') then

		else
			-- Create Vertex
			for _, entity in pairs(Editor:entitiesWith('polygon')) do
				if entity.selected then
					for i = 1, #entity.points - 1, 2 do
						local nextX, nextY = (i + 2), (i + 3)
						if nextX > #entity.points then nextX = nextX - #entity.points end
						if nextY > #entity.points then nextY = nextY - #entity.points end

						if math.lineDistance(x, y, entity.points[i], entity.points[i+1], entity.points[nextX], entity.points[nextY]) < self.threshold then
							self:vertexCreate((entity.points[i] + entity.points[nextX]) / 2, (entity.points[i+1] + entity.points[nextY]) / 2)
						end
					end
				end
			end
		end
	elseif button == 'r' then
		if love.keyboard.isDown('lshift') then

		else

		end
	end
end

function PolygonTool:vertexSelect()

end

function PolygonTool:vertexDeselect()

end

function PolygonTool:vertexMove()

end

function PolygonTool:vertexDelete()

end

function PolygonTool:vertexCreate(x, y)
	print('adding to' .. x .. ' ' .. y)
end

return PolygonTool, 'polygon'

--function over form
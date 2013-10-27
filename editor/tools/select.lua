local SelectTool = {}
--used to select entities

function SelectTool:activate()
	--
end

function SelectTool:deactivate()
	--
end

function SelectTool:update()
	if #Editor.selected > 0 then
	end
end

function SelectTool:draw()
	-- draw cursor
end

function SelectTool:deselect()
	table.clear(Editor.selected)
	Game.entities:ego('deselect')
end

function SelectTool:keypressed(key)
	if key == 'd' then self:deselect() end
end

function SelectTool:mousepressed()
	--
end

function SelectTool:mousereleased(x, y, button)
	if not love.keyboard.isDown('lshift') then self:deselect() end

	for _, e in pairs(Editor:entitiesWith('select')) do
		if e:select(x, y) then
			table.insert(Editor.selected, e)
			break
		end
	end
end

return SelectTool, 'select'

--function over form!
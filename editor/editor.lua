Editor = {}

function Editor:init(objects)
	self.tool = nil
	self.selected = {}
	
	self.tools = {}
	local dir = '/editor/tools'
	for _, file in ipairs(love.filesystem.enumerate(dir)) do
		if file:match('\.lua') then
			local tool, key = love.filesystem.load(dir .. '/' .. file)()
			self.tools[key] = tool
			self.tools[key].editor = self
		end
	end

	return self
end

for _, action in pairs({'update', 'draw', 'keypressed', 'keyreleased', 'mousepressed', 'mousereleased'}) do
	Editor[action] = function(self, ...) f.exe(self.tool and self.tool[action], self.tool, ...) end
end

function Editor:keypressed(key)
	if key == '1' then
		self:switchTool('select')
	elseif key == '2' then
		self:switchTool('move')
	elseif key == '3' then
		self:switchTool('polygon')
	end

	f.exe(self.tool and self.tool.keypressed, self.tool, key)
end

function Editor:switchTool(tool)
	f.exe(self.tool and self.tool.deactivate, self.tool)
	self.tool = self.tools[tool]
	self.tool:activate()
end

function Editor:draw()
	-- toolbars
end

function Editor:entitiesWith(tool)
	return Game.entities:filter(function(entity)
		return table.has(entity.editor and entity.editor.tools, tool)
	end)
end
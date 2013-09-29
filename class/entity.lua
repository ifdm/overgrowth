Entity = Class {
	name = 'Entity'
}

local actions = {
	init = {},
	update = {},
	draw = {},
	keypressed = {},
	keyreleased = {},
	mousepressed = {},
	mousereleased = {},
	sakujo = {},
	quit = {}
}

function Entity:boot()
	for i, component in pairs(self.components) do
		if _G[self.name .. component.name] then
			self.components[i] = _G[self.name .. component.name]
		end
	end
	
	self.actions = table.copy(actions)
	
	for k, component in pairs(self.components) do
		for action, _ in pairs(self.actions) do
			if component[action] then
				table.insert(self.actions[action], component[action])
			end
		end
	end
end

for action, _ in pairs(actions) do
	Entity[action] = function(self) self:act(action) end
end

function Entity:act(action)
	table.with(self.actions[action], function(f)
		f(self)
	end)
end
Entity = Class {
	name = 'Entity'
}

function Entity:boot()
	for i, component in pairs(self.components) do
		if _G[self.name .. component.name] then
			self.components[i] = _G[self.name .. component.name]
		end
	end
	
	self.actions = {}
	
	for k, component in pairs(self.components) do
		for _, action in pairs(actions) do
			self.actions[action] = self.actions[action] or {}
			if component[action] then
				table.insert(self.actions[action], component[action])
			end
		end
		
		for key, f in pairs(table.except(component, actions)) do
			if type(f) == 'function' then self[key] = f end
		end
	end
end

for _, action in pairs(actions) do
	Entity[action] = function(self) self:act(action) end
end

function Entity:init()
	self.state = {}
	self:act('init')
end

function Entity:act(action)
	table.with(self.actions[action], function(f)
		f(self)
	end)
end
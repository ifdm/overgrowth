Entity = Class {
	name = 'Entity'
}

function Entity:boot()
	print(self.name, self.render)
	
	for i, component in pairs(self.components) do
		local subclass = _G[self.name .. component.name]
		if subclass then
			if not getmetatable(subclass) then setmetatable(subclass, {__index = component}) end
			self.components[i] = subclass
		end
	end
	
	self.actions = {}
	
	for k, component in ipairs(self.components) do
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
	self:act('init')
end

function Entity:act(action)
	table.with(self.actions[action], function(f)
		f(self)
	end)
end

function Entity:all()
	return Game.entityManager.byClass[self.name]
end
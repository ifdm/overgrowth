Entity = Class {
	name = 'Entity'
}

function Entity:boot()
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
		
		local m = getmetatable(component)
		for key, f in pairs(table.except(table.merge(component, m and table.copy(m.__index)), actions)) do
			if type(f) == 'function' and key ~= 'name' then self[key] = f end
		end
	end
end

for _, action in pairs(actions) do
	Entity[action] = function(self, ...) self:act(action, ...) end
end

function Entity:init()
	self:act('init')
end

function Entity:act(action, ...)
	local args = {...}
	table.with(self.actions[action], function(f)
		f(self, unpack(args))
	end)
end

function Entity:all()
	return entityManager.byClass[self.name]
end
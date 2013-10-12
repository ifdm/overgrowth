EntityManager = Class {}

for _, action in pairs(actions) do
	EntityManager[action] = function(self, ...)
		for _, v in pairs(self.entities) do
			v[action](v, ...)
		end
	end
end

function EntityManager:init()
	self.entities = {}
	self.byClass = {}
end

function EntityManager:register(entity)
	local e = entity()
	table.insert(self.entities, e)
	
	self.byClass[entity.name] = self.byClass[entity] or {}
	table.insert(self.byClass[entity.name], e)
	
	return e
end
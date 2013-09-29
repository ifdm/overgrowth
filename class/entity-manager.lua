EntityManager = Class {}

for _, action in pairs(actions) do
	EntityManager[action] = function(self) table.with(self.entities, f.ego(action)) end
end

function EntityManager:init()
	self.entities = {}
end

function EntityManager:register(entity)
	local e = entity()
	table.insert(self.entities, e)
	return e
end
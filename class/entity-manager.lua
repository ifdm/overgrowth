EntityManager = Class {}

function EntityManager:init()
	self.entities = {}
end

function EntityManager:register(entity, vars)
	local e = entity()
	table.insert(self.entities, e)
	table.merge(vars, e)
end

for action in pairs(actions) do
	EntityManager[action] = function(self) table.with(self.entities, f.ego(action)) end
end

EntityManager = Class {}

function EntityManager:init()
	self.entities = {}
end

function EntityManager:register(entity)
	table.insert(self.entities, entity())
end

for action in pairs(actions) do
	EntityManager[action] = function(self) table.with(self.entities, f.ego(action)) end
end

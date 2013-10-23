EntityManager = Class {}

function EntityManager:init(entities)
	self.entities = {}

	for _, t in pairs(self.entities) do
		local e = t.entity
		table.insert(self.entities, e(t.data))
	end
end

function EntityManager:all()
	return self.entities
end

function EntityManager:filter(fn)
	return table.filter(self.entities, fn)
end

function EntityManager:update()
	table.with(self.entities, f.ego('update'))
end

function EntityManager:draw()
	table.with(self.entities, f.ego('draw'))
end
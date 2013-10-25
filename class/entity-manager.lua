EntityManager = Class {}

function EntityManager:init(entities)
	self.entities = {}

	for _, t in pairs(entities) do
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

function EntityManager:keypressed(key)
	table.with(self.entities, function(e)
		e:keypressed(key)
	end)
end

function EntityManager:keyreleased(key)
	table.with(self.entities, function(e)
		e:keyreleased(key)
	end)
end

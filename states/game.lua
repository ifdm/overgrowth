Game = {}

function Game:enter()
	entityManager = EntityManager()
	
	local p = entityManager:register(Player)
	p.state.pos.x = 3 * unitSize
	p.state.pos.y = 2 * unitSize
	
	local w = entityManager:register(Wall)
	w.state.pos.x = 10 * unitSize
	w.state.pos.y = 10 * unitSize
end

for _, action in pairs(actions) do
	Game[action] = function() entityManager[action](entityManager) end
end
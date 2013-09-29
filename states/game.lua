Game = {}

function Game:enter()
	entityManager = EntityManager()
	
	local p = entityManager:register(Player)
	p.state.pos.x = 3 * unitSize
	p.state.pos.y = 2 * unitSize
	
	local g = entityManager:register(Wall)
	g.state.pos.x = 0 * unitSize
	g.state.pos.y = 18 * unitSize
	g.state.mask.width = 25
end

for _, action in pairs(actions) do
	Game[action] = function() entityManager[action](entityManager) end
end
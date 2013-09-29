Game = {}

function Game:enter()
	entityManager = EntityManager()
	entityManager:register(Player)
end

for action in pairs(actions) do
	Game[action] = function() entityManager[action](entityManager) end
end

Game = {}

function Game:enter()
	entityManager = EntityManager()
	entityManager:register(Player, {
								state: {
								  pos: {
								    x = 3 * unitSize,
								    y = 2 * unitSize
								  }
							    }
							  })
	entityManager:register(Wall, {
								state: {
								  pos: {
								    x = 10 * unitSize,
								    y = 10 * unitSize
								  }
							    }
							  })
end

for action in pairs(actions) do
	Game[action] = function() entityManager[action](entityManager) end
end

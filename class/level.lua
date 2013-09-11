Level = Class {
	
}

levelIndex = {}

function Level:init(filename)
	local data = love.filesystem.load(filename)()
	table.merge(data, self)
	levelIndex[self.name] = self
end

function Level:enter()
	print('Loading level "' .. self.name .. '"')
	
	fixtureMap = {}
	objects = {}
	history = {}
	plantQueue = {}
	
	for _, wall in pairs(self.walls) do
		Wall(wall)
	end
	
	for _, seed in pairs(self.seeds) do
		Seed(unpack(seed))
	end

	player = Player(self.px, self.py)
	view = View(player)
end

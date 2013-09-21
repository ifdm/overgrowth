Level = Class {}

levelIndex = {}

function Level:init(filename)
	local data = require(filename)
	table.merge(data, self, true)
	self.walls = data.walls
	self.seeds = data.seeds
	self.entities = data.entities
	levelIndex[self.name] = self
end

function Level:enter()
	print('Loading level "' .. self.name .. '"')

	for _, obj in pairs(objects) do
		f.exe(obj.destory, obj)
	end
	
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

	for _, e in pairs(self.entities) do
		e.c(unpack(e.p))
	end

	player = Player(self.px, self.py)
	view = View(player)
end
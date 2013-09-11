Level = Class {
	
}

levelIndex = {}

function Level:init(name)
	self.name = name
	self.walls = {}
	self.seeds = {}
	self.pX = 0
	self.pY = 0
	levelIndex[name] = self
end

function Level:addWall(x, y, points)
	local w = {
		x = x, 
		y = y,
		p = points
	}	
	self.walls[#self.walls + 1] = w
end

function Level:setPlayer(x, y)
	self.pX = x
	self.pY = y
end

function Level:addSeed(x, y, type)
	local s = {
		x = x,
		y = y,
		t = type
	}
	
	self.seeds[#self.seeds + 1] = s
end

function Level:enter()
	print('Loading level "' .. self.name .. '"')

	for i, w in pairs(self.walls) do
		Wall(w.x, w.y, w.p)
	end
	
	for i, s in pairs(self.seeds) do
		Seed(s.x, s.y, s.t)
	end
	
	player = Player(self.pX, self.pY)
	view = View(player)
end

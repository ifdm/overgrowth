Level = Class{}

levelIndex = {}

function Level:init(name)
	self.name = name
	self.walls = {}
	self.seeds = {}
	self.entities = {}
	self.pX = 0
	self.pY = 0
	levelIndex[name] = self

end

function Level:addWall(_x, _y, _points)
	local w = {
		x = _x, 
		y = _y,
		p = _points
	}	
	self.walls[#self.walls + 1] = w
end

function Level:setPlayer(_x, _y)
	self.pX = _x
	self.pY = _y
end

function Level:addEntity(_x, _y, _angle, _constructor)
	local e = {
		x = _x,
		y = _y,
		a = _angle,
		c = _constructor
	}
	self.entities[#self.entities + 1] = e
end


function Level:addSeed(_x, _y, _type)
	local s = {
		x = _x,
		y = _y,
		t = _type
	}
	self.seeds[#self.seeds + 1] = s
end


function Level:enter()
	print ("Loading level \"" .. self.name .. "\"")

	for i, w in pairs(self.walls) do
		Wall(w.x, w.y, w.p)
	end
	for i, e in pairs(self.entities) do

		e.c(e.x, e.y, e.a)
	end
	for i, s in pairs(self.seeds) do
		Seed(s.x, s.y, s.t)
	end
	player = Player(self.pX, self.pY)
	view = View(player)

end

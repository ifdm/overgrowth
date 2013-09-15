local level = {}

----------------
-- Meta
----------------
level.name = 'default'
level.px = 96
level.py = 400
level.width = 2000
level.height = 600

----------------
-- Mask
----------------
level.walls = {
	{
		0, 0,
		0, 600,
		700, 600,
		700, 300,
		900, 300,
		900, 600,
		1200, 600,
		1200, 0
	}
}

level.seeds = {
	{200, 400, Mushroom},
	{300, 400, Bridge},
	{400, 400, Dropper}
}

level.entities = {
	{c=Laser.create, p={350, 400, math.pi/2, Laser.mode_circular}},
	{c=Laser.create, p={450, 400, math.pi/2, Laser.mode_sweep}},
	{c=Laser.create, p={550, 400, 2*math.pi, Laser.mode_static}},
	{c=Fan.create, p={200, 200, math.pi/2, 0.003}},
	{c=Fan.create, p={1100, 550, 3*math.pi/2, 0.005}},
	{c=Fan.create, p={1200, 100, 2*math.pi, -0.002}}
	
}

return level
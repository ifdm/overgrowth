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
		900, 0
	}
}

level.seeds = {
	{200, 400, Mushroom},
	{300, 400, Bridge}
}

level.entities = {
	{x=350, y=410, c=Laser.create, a=3*math.pi/2 }

}

return level
Level = {}




--Create a new level for the level editor
function Level.create(width, height)


	local level = {
		world = love.physics.newWorld(0, 9.81*64, true), 
		--create a world for the bodies to exist in with horizontal gravity of 0 and vertical gravity of 9.81

 		objects = {},
 		-- table to hold all our physical objects


  		terrain = Terrain.create(width, 300),
  		width = width,
  		height = height



	}

	setmetatable(level, {__index = Level})
	level:initDefault()

	return level

end

function Level:getHeight()

	return height
end
function Level:getWidth()
	return width
end



-- some defaults for new levels for the level editor
function Level:initDefault()
--let's create the ground


  self.objects.ground = {}
  self.objects.ground.body = love.physics.newBody(self.world, 650/2, 650-50/2) --remember, the shape (the rectangle we create next) anchors to the body from its center, so we have to move it to (650/2, 650-50/2)
  self.objects.ground.shape = love.physics.newRectangleShape(5000, 50) --make a rectangle with a width of 650 and a height of 50
  self.objects.ground.fixture = love.physics.newFixture(self.objects.ground.body, self.objects.ground.shape); --attach shape to body
  
  --let's create a player
  self.player = Player.create(200, 200, self.world);
  


  --let's create a couple blocks to play around with
  self.objects.block1 = {}
  self.objects.block1.body = love.physics.newBody(self.world, 200, 550, "dynamic")
  self.objects.block1.shape = love.physics.newRectangleShape(0, 0, 50, 100)
  self.objects.block1.fixture = love.physics.newFixture(self.objects.block1.body, self.objects.block1.shape, 5) -- A higher density gives it more mass.

  self.objects.block2 = {}
  self.objects.block2.body = love.physics.newBody(self.world, 200, 400, "dynamic")
  self.objects.block2.shape = love.physics.newRectangleShape(0, 0, 100, 50)
  self.objects.block2.fixture = love.physics.newFixture(self.objects.block2.body, self.objects.block2.shape, 2)

end

function Level:draw()
 self.player:draw()
 self.terrain:draw()
  love.graphics.setColor(72, 160, 14) -- set the drawing color to green for the ground
  love.graphics.polygon("fill", self.objects.ground.body:getWorldPoints(self.objects.ground.shape:getPoints())) -- draw a "filled in" polygon using the ground's coordinates
  

  love.graphics.setColor(50, 50, 50) -- set the drawing color to grey for the blocks
  love.graphics.polygon("fill", self.objects.block1.body:getWorldPoints(self.objects.block1.shape:getPoints()))
  love.graphics.polygon("fill", self.objects.block2.body:getWorldPoints(self.objects.block2.shape:getPoints()))

end


--Load a level for the game to play
function Level.load(source)



end


--Save a level for the level editor AND potentially for savegames
--We'll cross that bridge when we get to it
function Level:save()


end


--Reset a level to it's starting state - not sure if we'll need this
function Level:reset()


end

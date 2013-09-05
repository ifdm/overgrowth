require 'player'
require 'camera'

function love.load()
  love.physics.setMeter(64) --the height of a meter our worlds will be 64px
  world = love.physics.newWorld(0, 9.81*64, true) --create a world for the bodies to exist in with horizontal gravity of 0 and vertical gravity of 9.81

  objects = {} -- table to hold all our physical objects
  
  
  
  --let's create the ground
  objects.ground = {}
  objects.ground.body = love.physics.newBody(world, 650/2, 650-50/2) --remember, the shape (the rectangle we create next) anchors to the body from its center, so we have to move it to (650/2, 650-50/2)
  objects.ground.shape = love.physics.newRectangleShape(5000, 50) --make a rectangle with a width of 650 and a height of 50
  objects.ground.fixture = love.physics.newFixture(objects.ground.body, objects.ground.shape); --attach shape to body
  
  --let's create a ball
  player = Player.create(200, 200);
  


  --let's create a couple blocks to play around with
  objects.block1 = {}
  objects.block1.body = love.physics.newBody(world, 200, 550, "dynamic")
  objects.block1.shape = love.physics.newRectangleShape(0, 0, 50, 100)
  objects.block1.fixture = love.physics.newFixture(objects.block1.body, objects.block1.shape, 5) -- A higher density gives it more mass.

  objects.block2 = {}
  objects.block2.body = love.physics.newBody(world, 200, 400, "dynamic")
  objects.block2.shape = love.physics.newRectangleShape(0, 0, 100, 50)
  objects.block2.fixture = love.physics.newFixture(objects.block2.body, objects.block2.shape, 2)


  canvas = love.graphics.newCanvas(800, 600)

  camera.init(player, 10)


  --initial graphics setup
  love.graphics.setBackgroundColor(104, 136, 248) --set the background color to a nice blue
  love.graphics.setMode(650, 650, false, true, 0) --set the window dimensions to 650 by 650
end


function love.update(dt)
  world:update(dt) --this puts the world into motion

  player:update()
  camera.update()
  counter = dt
end

function love.draw()

  love.graphics.translate(-camera.getX() + (love.graphics.getWidth()/2), -camera.getY() + (love.graphics.getHeight()/2))
  love.graphics.setCanvas(canvas)
  canvas:clear()
  love.graphics.setBlendMode('alpha')
  camera.draw()
  
  player:draw()
  love.graphics.setColor(72, 160, 14) -- set the drawing color to green for the ground
  love.graphics.polygon("fill", objects.ground.body:getWorldPoints(objects.ground.shape:getPoints())) -- draw a "filled in" polygon using the ground's coordinates
  

  love.graphics.setColor(50, 50, 50) -- set the drawing color to grey for the blocks
  love.graphics.polygon("fill", objects.block1.body:getWorldPoints(objects.block1.shape:getPoints()))
  love.graphics.polygon("fill", objects.block2.body:getWorldPoints(objects.block2.shape:getPoints()))

  love.graphics.setCanvas()
  love.graphics.draw(canvas)
end



-- The run function as written didn't work with the new code I wrote, so I commented it instead of removing it, because I figured I didn't understand what it was doing
--[[function love.run()
  math.randomseed(os.time())
  math.random()

  tickRate = .02
  tickDelta = 0

   if love.load then love.load(arg) end

   local dt = 0
  while true do
    love.timer.step()
    local delta = love.timer.getDelta()

    love.event.pump()
    for e, a, b, c, d in love.event.poll() do
      if e == 'quit' then if love.quit then love.quit() end love.audio.stop() return
      else love.handlers[e](a, b, c, d) end
    
    
    end

    tickDelta = tickDelta + delta
    while tickDelta >= tickRate do
      tickDelta = tickDelta - tickRate
      love.update()
    end
    
    love.graphics.clear()
    love.draw()
    love.graphics.present()
    
    love.timer.sleep(.001)
  end
end]]--
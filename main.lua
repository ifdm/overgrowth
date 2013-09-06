require 'player'
require 'camera'
require 'level'
require 'editor'
require 'terrain'
require 'util'
require 'game'

function love.load()
  --[[Need a layer of abstraction to represent 
  A) The game
  B) Menus
  C) The editor
  D) Game over screen
  E) Credits

  Each can do it's own draw function, update function, and context switch function, plus
  any mouse and key listeners needed per the context.


]]--
  context = game



  love.physics.setMeter(64) --the height of a meter our worlds will be 64px
  
  

  canvas = love.graphics.newCanvas(800, 600)
  level = Level.create(1100, 800)

  camera.init(level.player, 10)


  --initial graphics setup
  love.graphics.setBackgroundColor(104, 136, 248) --set the background color to a nice blue
  love.graphics.setMode(650, 650, false, true, 0) --set the window dimensions to 650 by 650
end


function contextswitch(toContext)
  context.exit()
  toContext.enter()
  context = toContext


end

function love.update(dt)
  context.update(dt)
end

function love.draw()
  context.draw()


end

function love.mousepressed(x, y, button)
  print ("Mouse x" .. x .. ", Camera x " .. camera.getX())
  context.mousepressed(-camera.getX()  + x,  y, button)
end

function love.keypressed(key)
  context.keypressed(key)
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
function love.load()
  love.update = function() end
  love.draw = function() end
end

function love.run()
  math.randomseed(os.time())
  math.random()

  tickRate = .02
  tickDelta = 0

  love.load(arg)

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
end
game = {}

function game.update(dt)
  level.world:update(dt) --this puts the world into motion

  level.player:update()
  camera.update()
  counter = dt
end


function game.draw()


  --[[love.graphics.translate(-camera.getX() + (love.graphics.getWidth()/2), -camera.getY() + (love.graphics.getHeight()/2))
  love.graphics.setCanvas(canvas) 
  canvas:clear()--]]
  
  love.graphics.setBlendMode('alpha')
  camera.draw()
  
  level:draw()
 
--[[
  love.graphics.setCanvas()
  love.graphics.draw(canvas)
  ]]--

end


function game.keypressed(key)


end

function game.mousepressed(x, y, button)
	contextswitch(editor)

end


function game.exit()

end

function game.enter()

end
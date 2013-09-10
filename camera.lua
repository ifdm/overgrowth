camera = {}


--Camera follows someObject
--lag determines how quickly the camera will follow the object
function camera.init(someObject, lag)

	camera.following = someObject.body
	camera.x = camera.following:getX()
	camera.y = camera.following:getY()
	camera.lag = lag
	camera.scaleX = 1
	camera.scaleY = 1
end

function camera.set()
  love.graphics.push()
  love.graphics.scale(1 / camera.scaleX, 1 / camera.scaleY)
  love.graphics.translate(-camera.x, -camera.y)
end

function camera.unset()
  love.graphics.pop()
end

function camera.mousePosition()
  return love.mouse.getX() * camera.scaleX + camera.x, love.mouse.getY() * camera.scaleY + camera.y
end

function camera.scale(sx, sy)
  sx = sx or 1
  camera.scaleX = camera.scaleX * sx
  camera.scaleY = camera.scaleY * (sy or sx)
end


function camera.update()
	local dx = camera.getX() - camera.following:getX() + (love.graphics.getWidth()/2)
	local dy = camera.getY() - camera.following:getY() + (love.graphics.getHeight()/2)

	camera.x =  camera.x - (dx/camera.lag)
	camera.y =  camera.y - (dy/camera.lag)

end



function camera.getX()
	--return camera.body:getX()
	return camera.x
end

function camera.getY()
	return camera.y
	--return camera.body:getY()
end

function camera.getCenterX()
	return camera.x + (love.graphics.getWidth()/2)
end

function camera.getCenterY()
	return camera.y + (love.graphics.getHeight()/2)
end



function camera.draw()
	love.graphics.reset()
  
	love.graphics.setColor(193, 47, 14) --set the drawing color to red for the ball
	--love.graphics.polygon("fill", camera.body:getWorldPoints(camera.shape:getPoints()))
	love.graphics.circle("fill", camera.getX(), camera.getY(), 10, 20)
end
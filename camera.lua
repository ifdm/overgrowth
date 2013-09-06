camera = {}
cameraWorld = love.physics.newWorld(0, 9.81*64, true)


--Camera follows someObject
--lag determines how quickly the camera will follow the object
function camera.init(someObject, lag)

	--[[local x = someObject.body:getX()
	local y = someObject.body:getY()
	local _body = love.physics.newBody(cameraWorld, x, y, "dynamic")
	local _shape = love.physics.newRectangleShape(10,10)
	local _fixture = love.physics.newFixture(_body, _shape, 1)

	camera.shape = _shape
	camera.fixture = _fixture
	camera.body = _body
	]]--


	camera.following = someObject.body
	camera.x = camera.following:getX()
	camera.y = camera.following:getY()
	camera.lag = lag
end


function camera.update()
	local dx = camera.getX() - camera.following:getX()
	local dy = camera.getY() - camera.following:getY()

	camera.x = camera.x - (dx/camera.lag)
	camera.y = camera.y - (dy/camera.lag)

	--camera.body:applyForce(200, 0)
end

function camera.getX()
	--return camera.body:getX()
	return camera.x
end

function camera.getY()
	return camera.y
	--return camera.body:getY()
end

function camera.draw()
	love.graphics.reset()
  
	love.graphics.setColor(193, 47, 14) --set the drawing color to red for the ball
	--love.graphics.polygon("fill", camera.body:getWorldPoints(camera.shape:getPoints()))
	love.graphics.circle("fill", camera.getX(), camera.getY(), 10, 20)
end
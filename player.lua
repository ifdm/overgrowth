Player = {}

function Player.create(x, y, world)
	local _body = love.physics.newBody(world, x, y, "dynamic")
	local _shape = love.physics.newRectangleShape(100,100)
	local _fixture = love.physics.newFixture(_body, _shape, 1)
	_body:setFixedRotation(true)
	_fixture:setRestitution(0.4) 
	
	local player = {
		startX = x,
		startY = y,
		body = _body,
		shape = _shape,
		fixture = _fixture
	}
	
	setmetatable(player, {__index = Player})
	
	
	return player
end

function Player:update()
--here we are going to create some keyboard events
  if love.keyboard.isDown("right") then --press the right arrow key to push the ball to the right
    self.body:applyForce(400, 0)
  
  elseif love.keyboard.isDown("left") then --press the left arrow key to push the ball to the left
    self.body:applyForce(-400, 0)

  elseif love.keyboard.isDown("up") then 
    self.body:applyForce(0, -4000)

  elseif love.keyboard.isDown(" ") then --press the up arrow key to set the ball in the air
   self.body:setPosition(self.startX, self.startY)
  
  end

end


  
  
function Player:draw()
	love.graphics.reset()
  
	love.graphics.setColor(193, 47, 14) --set the drawing color to red for the ball
	love.graphics.polygon("fill", self.body:getWorldPoints(self.shape:getPoints()))
end
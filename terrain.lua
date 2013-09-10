Terrain = {}



function Terrain.create(width, defaultHeight)
	local terrain = {}

	terrain.points = {}
	

	terrain.points[0] = defaultHeight
    terrain.points[width] = defaultHeight

	setmetatable(terrain, {__index = Terrain})

	return terrain
end



function nearest(n, step)
    return math.floor((n/step)+0.5) *step
end



function Terrain:draw()
	local lastX = nil
    local lastY = nil
    for x = 0, level.width, 1 do
        local y = self.points[x]
        if x and y then
            love.graphics.setColor(255, 0, 0)
            love.graphics.circle("fill", x, y, 10)

             --Old connectors
            if lastX and lastY then
                love.graphics.line(lastX, lastY, x, y) 
            end

            lastX = x
           lastY = y
       end
    end
end

function Terrain:clearPoint(x)
    self.points[nearest(x, 50)] = nil
end


function Terrain:setPoint(x, y)
    self.points[nearest(x, 50)] = nearest(y, 50)
end


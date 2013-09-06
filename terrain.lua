Terrain = {}



function Terrain.create(width, defaultHeight)
	local terrain = {}

	terrain.points = {}
	

	for x = 0, width, 50 do
		terrain.points[x] = defaultHeight

	end

	setmetatable(terrain, {__index = Terrain})

	return terrain
end



--NEEDS WORK
--Should be replaced with a more robust snap-to-grid function
-- Currently DOES NOT WORK
function nearest(n, step)
    print ("" .. (math.floor(n/step)+0.5))
    return math.floor((n/step)+0.5) *step

end



function Terrain:draw()
	local lastX = nil
    local lastY = nil
    for x = 0, level.width, 50 do
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


function Terrain:setPoint(x, y)
	xG = nearest(x, 50)
    yG = nearest(y, 50)
    self.points[xG] = yG

end


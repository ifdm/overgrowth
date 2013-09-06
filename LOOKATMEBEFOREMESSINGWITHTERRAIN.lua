function love.load()
    -- Indexes will be X coordinates, Y coordinates will be the VALUES
    points = {}

    for x = 0, love.graphics.getWidth(), 50 do
        points[x] = nearest(love.graphics.getHeight()*9/10, 50)
    end

    love.graphics.setBackgroundColor(104, 136, 248) --set the background color to a nice blue
    love.graphics.setMode(650, 650, false, true, 0) --set the window dimensions to 650 by 650
end


function love.draw()
    drawGrid()

    local lastX = nil
    local lastY = nil

    for x = 0, love.graphics.getWidth(), 50 do
        local y = points[x]
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

function drawGrid()

    love.graphics.setColor(255, 255, 255)
    for x = 0, love.graphics.getWidth(), 50 do

        love.graphics.line(x, 0, x, love.graphics.getHeight())
    end

    for y = 0, love.graphics.getHeight(), 50 do
        love.graphics.line(0, y, love.graphics.getWidth(), y)
    end

end


function nearest(n, step)
    print ("" .. (math.floor(n/step)+0.5))
    return math.floor((n/step)+0.5) *step

end

function table.print(t, n)
  n = n or 0
  if t == nil then print('nil') end
  if type(t) ~= 'table' then io.write(tostring(t)) io.write('\n')
  else
    for k, v in pairs(t) do
      io.write(string.rep('\t', n))
      io.write(k)
      if type(v) == 'table' then io.write('\n')
      else io.write('\t') end
      table.print(v, n + 1)
    end
  end
end


function love.mousepressed(x, y, button)

    xG = nearest(x, 50)
    yG = nearest(y, 50)



    if button == "l" then
        points[xG] = yG



    elseif button == "r" then
        points[xG] = nil
    end
end

function love.update(dt)
  
end

function love.mousereleased(x, y, button)
    table.print(points)
end
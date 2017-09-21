-- Working --
function love.load(arg)
  love.graphics.setLineWidth(3)
  love.graphics.setLineStyle('smooth')
  love.graphics.setDefaultFilter('nearest', 'nearest', 16)
  ubuntuFont = love.graphics.newFont("resourcen/fonts/Ubuntu-Medium.ttf", 16)

  -- for the atom color package --
  function rgb(r, g, b, a)
    return r, g, b, a
  end

  function arcClock(sWidth, sHeight, time, red, green, blue, alpha)
    local defaultColor = {love.graphics.getColor()}
    local secondToRad = math.rad((360/60)*time.sec)
    local redIN, greenIN, blueIN, alphaIN = red or 255, green or 255, blue or 255, alpha or 255

    love.graphics.translate(sWidth/2, sHeight/2)
    love.graphics.rotate(-math.pi / 2)
    love.graphics.translate(-sWidth/2, -sHeight/2)
    love.graphics.setColor(redIN, greenIN, blueIN, alphaIN)

    love.graphics.arc("line", "open", (sWidth*0.5), (sHeight*0.5), 150, math.rad(0), secondToRad) -- arg #8 : segments

    love.graphics.setColor(defaultColor)
    love.graphics.translate(sWidth/2, sHeight/2)
    love.graphics.rotate(math.pi*0.5)
    love.graphics.translate(-sWidth/2, -sHeight/2)
  end

  function showClock(width, height, time, font, red, green, blue, alpha)
    local redIN, greenIN, blueIN, alphaIN = red or 255, green or 255, blue or 255, alpha or 255
    local timeData = {
      function() if string.len(time.hour) < 2 then return "0"..time.hour else return time.hour end end,
      function() if string.len(time.min) < 2 then return "0"..time.min else return time.min end end,
      function() if string.len(time.sec) < 2 then return "0"..time.sec else return time.sec end end
    }
    local defaultColor = {love.graphics.getColor()}
    local timeText = love.graphics.newText(font, timeData[1]()..":"..timeData[2]()..":"..timeData[3]())

    love.graphics.setColor(redIN, greenIN, blueIN, alphaIN)

    love.graphics.draw(timeText, (width/2)-(timeText:getWidth()/2) , (height/2)-(timeText:getHeight()/2))

    love.graphics.setColor(defaultColor)
  end
end

function love.update(dt)
  screenWidth, screenHeight = love.graphics.getDimensions()
  love.window.setTitle("ArcClock "..love.timer.getFPS().."FPS")
  osTime = os.date('*t')
end

function love.draw()
  arcClock(screenWidth, screenHeight, osTime, rgb(16, 141, 212))
  showClock(screenWidth, screenHeight, osTime, ubuntuFont, rgb(154, 0, 83))
end

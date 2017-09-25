-- Working --
function love.load(arg)
  love.graphics.setLineWidth(10)
  love.graphics.setPointSize(10)
  love.graphics.setLineStyle('smooth')
  love.graphics.setDefaultFilter('nearest', 'nearest', 16)
  ubuntuFont = love.graphics.newFont("resources/fonts/Ubuntu-Medium.ttf", 16)
  bloomShader = love.graphics.newShader("resources/shader/bloom.glsl")


  -- for the atom color package --
  function rgb(r, g, b)
    return r, g, b
  end
  function rgba(r, g, b, a)
    return r, g, b, a
  end

  function startendDots(radius, sWidth, sHeight, radEnd)
    local rotatedRadEnd = radEnd-math.rad(90)
    local centerX, centerY = sWidth*0.5, sHeight*0.5
    local startX, startY = centerX, centerY -radius
    local endX, endY = centerX+radius*math.cos(rotatedRadEnd), centerY+radius*math.sin(rotatedRadEnd)
    -- Start --
    love.graphics.points(startX, startY)
    -- End --
    love.graphics.points(endX, endY)
  end

  function arcClock(radius, sWidth, sHeight, currentPercent, maxPercent, red, green, blue, alpha)
    local defaultColor = {love.graphics.getColor()}
    local secondToRad = math.rad((360/maxPercent)*currentPercent)
    local redIN, greenIN, blueIN, alphaIN = red or 255, green or 255, blue or 255, alpha or 255

    love.graphics.translate(sWidth/2, sHeight/2)
    love.graphics.rotate(-math.pi / 2)
    love.graphics.translate(-sWidth/2, -sHeight/2)
    love.graphics.setColor(redIN, greenIN, blueIN, alphaIN)

    love.graphics.arc("line", "open", (sWidth*0.5), (sHeight*0.5), radius, math.rad(0), secondToRad) -- arg #8 : segments

    love.graphics.translate(sWidth/2, sHeight/2)
    love.graphics.rotate(math.pi*0.5)
    love.graphics.translate(-sWidth/2, -sHeight/2)
    startendDots(radius, sWidth, sHeight, secondToRad)
    love.graphics.setColor(defaultColor)
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
  arcClock(200, screenWidth, screenHeight, osTime.sec, 60,  rgb(0, 255, 79)) -- sec
  arcClock(175, screenWidth, screenHeight, osTime.min, 60, rgb(0, 94, 255)) -- min
  arcClock(150, screenWidth, screenHeight, osTime.hour % 12, 12, rgb(208, 0, 69)) -- hour
  showClock(screenWidth, screenHeight, osTime, ubuntuFont, rgb(96, 95, 92))
end

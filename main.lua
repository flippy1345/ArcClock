-- Working --
function love.load(arg)
  love.graphics.setLineWidth(3)
  love.graphics.setLineStyle('smooth')
  love.graphics.setDefaultFilter('nearest', 'nearest', 16)
  text = love.graphics.newText(love.graphics.getFont(), "")

  -- for the atom color package --
  function rgb(r, g, b, a)
    return r, g, b, a
  end

  function arcClock(sWidth, sHeight, time, red, green, blue, alpha)
    local defaultColor = {}
    secondToRad = math.rad((360/60)*time.sec)
    local redIN, greenIN, blueIN, alphaIN = red or 255, green or 255, blue or 255, alpha or 255
    defaultColor[1], defaultColor[2], defaultColor[3], defaultColor[4] = love.graphics.getColor()
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
end

function love.update(dt)
  screenWidth, screenHeight = love.graphics.getDimensions()
  osTime = os.date('*t')
  love.window.setTitle("ArcClock "..love.timer.getFPS().."FPS")
end

function love.draw()
  arcClock(screenWidth, screenHeight, osTime, rgb(231, 7, 74))
  love.graphics.draw(text, (screenWidth/2)-(text:getWidth()/2) , (screenHeight/2)-(text:getHeight()/2))
  print("Rad: "..math.rad(6*osTime.sec), "Degree: "..6*osTime.sec)
end

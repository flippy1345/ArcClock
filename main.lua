-- Working --
function love.load(arg)
  love.graphics.setLineWidth(3)
  love.graphics.setLineStyle('smooth')
  love.graphics.setDefaultFilter('nearest', 'nearest', 16)
  ubuntuFont = love.graphics.newFont("resourcen/fonts/Ubuntu-Medium.ttf", 16)
  text = love.graphics.newText(ubuntuFont, "")

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

  function showClock(width, height, drawableTimeText)
    love.graphics.draw(drawableTimeText, (width/2)-(text:getWidth()/2) , (height/2)-(text:getHeight()/2))
  end
end

function love.update(dt)
  screenWidth, screenHeight = love.graphics.getDimensions()
  love.window.setTitle("ArcClock "..love.timer.getFPS().."FPS")
  osTime = os.date('*t')
  text:set(osTime.hour..":"..osTime.min..":"..osTime.sec)
end

function love.draw()
  arcClock(screenWidth, screenHeight, osTime, rgb(16, 141, 212))
  showClock(screenWidth, screenHeight, text)
  -- Testing --
  print("Rad: "..math.rad(6*osTime.sec), "Degree: "..6*osTime.sec)
end

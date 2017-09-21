function love.load(arg)
  screenWith, screenHeight = love.graphics.getDimensions()
end

function love.update(dt)
  screenWith, screenHeight = love.graphics.getDimensions()
  osTime = os.date('*t')
  love.window.setTitle("ArcClock "..love.timer.getFPS().."FPS")
end

function love.draw()
  print("Hour", osTime.sec)
end

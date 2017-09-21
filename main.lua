function love.load(arg)
  screenWith, screenHeight = love.graphics.getDimensions()
end

function love.update(dt)
  screenWith, screenHeight = love.graphics.getDimensions()
  osTime = os.date('*t')
end

function love.draw()
  print("Hour", osTime.hour)
end

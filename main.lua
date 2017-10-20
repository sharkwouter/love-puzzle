function love.load()
  
  --Create player object with variables
  player = {}
  player.x = 100
  player.y = 100
  player.speed = 64
  player.aimDirection = 0
  player.isMoving = false
  
  --Create mouse object, so we can track the mouse position
  mouse = {}
  mouse.x = love.mouse.getX()
  mouse.y = love.mouse.getY()
end

function love.update(dt)
  mouse.x = love.mouse.getX()
  mouse.y = love.mouse.getY()
  
  --move
  if love.keyboard.isDown("w") then
    movePlayer(player.speed, 0, dt)
  end
  if love.keyboard.isDown("a") then
    movePlayer(player.speed, 90, dt)
  end
  if love.keyboard.isDown("s") then
    movePlayer(player.speed, 180, dt)
  end
  if love.keyboard.isDown("d") then
    movePlayer(player.speed, 270, dt)
  end
end

function love.draw()
  love.graphics.circle("fill", player.x, player.y, 16)
  love.graphics.line(player.x, player.y, mouse.x, mouse.y)
end

--Calculated the direction to a point in degrees
function directionToPoint(orgX, orgY, aimX, aimY)
  deltaX = aimX - orgX
  deltaY = aimY - orgY
  result = math.atan2(deltaX, deltaY)
  return math.deg(result)
end

--Move the player
function movePlayer(speed, direction, dt)
  player.x = player.x - math.sin(direction*math.pi/180) * speed * dt
  player.y = player.y - math.cos(direction*math.pi/180) * speed * dt
end
  --Create player object with variables
  player = {}
  player.x = 0
  player.y = 0
  player.moveSpeed = level.blocksize*4
  player.directionAim = 0
  player.directionBody = 0
  player.isMoving = false
  player.colorBody = {0,100,255}
  player.width = level.blocksize
  
  --variables used to responding to a button press early
  player.nextMoveSet = false
  player.nextMoveDirection = 0
  
  --Either set the direction and movement speed or set the direction of the next move
function playerMove(direction)
  if (player.isMoving) then
    player.nextMoveDirection = direction
    player.nextMoveSet = true
  else
    player.directionBody = direction
    player.isMoving = true
  end
end

function playerDraw()
  love.graphics.setColor(player.colorBody)
  love.graphics.circle("fill", player.x, player.y, player.width/2)
  love.graphics.line(player.x, player.y, mouse.x, mouse.y)
end

function playerDrawAim()
  
end

function playerUpdatePosition(dt)
  if(player.isMoving == false and player.nextMoveSet) then
    player.directionBody = player.nextMoveDirection
    player.isMoving = player.nextMoveSet
    player.nextMoveSet = false
  end
  
  if(player.isMoving) then
    local movement = calculateMovementDegrees(player.directionBody, player.moveSpeed*dt)
    player.x = player.x + movement.x
    player.y = player.y + movement.y
  end
  if(playerOnGrid(dt)) then
    player.isMoving = false
    if(player.nextMoveSet) then
      player.directionBody = player.nextMoveDirection
      player.isMoving = true
      player.nextMoveSet = false
    end
  end
end

function playerOnGrid(dt)
  local nextMove = calculateMovementDegrees(player.directionBody, player.moveSpeed*dt)
  local x = player.x % level.blocksize
  local y = player.y % level.blocksize
  print(nextMove.x.." "..x)
  if(x < math.abs(nextMove.x) or y < math.abs(nextMove.y)) then
    player.x = math.floor(player.x/level.blocksize)*level.blocksize
    player.y = math.floor(player.y/level.blocksize)*level.blocksize
    return true
  end
  return false
end

function calculateMovementDegrees(direction, speed)
  local radials = direction*math.pi/180
  local movement = {}
  movement.x = math.sin(radials) * speed
  movement.y = math.cos(radials) * speed
  return movement
end
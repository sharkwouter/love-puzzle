--Create player object with variables
player = {}
player.size = level.blocksize
player.x = player.size
player.y = player.size
player.moveSpeed = level.blocksize*4
player.directionAim = 0
player.directionBody = 0
player.isMoving = false
player.colorBody = {0,100,255}

  
--variables used to responding to a button press early
player.nextMoveSet = false
player.nextMoveDirection = 0
  
--Either set the direction and movement speed or set the direction of the next move
function playerMove(direction)
  --if the player isn't moving, set it in motion. Otherwise set the next move to make
  if (player.isMoving) then
    --Only set the next move if it is in a diffent direction
    if((direction == player.directionBody) == false) then
      player.nextMoveDirection = direction
      player.nextMoveSet = true
    end
  else
    player.directionBody = direction
    player.isMoving = true
  end
end

function playerDraw()
  love.graphics.setColor(player.colorBody)
  love.graphics.circle("fill", player.x, player.y, player.size/2)
end

--Draw the aim line
function playerDrawAim()
  local hit = false
  
  local point = {}
  point.x = player.x
  point.y = player.y
  
  --calculate the movement per iteration
  local movement = calculateMovementDegrees(player.directionAim,1)

  while(hit == false) do
    --move the cursor
    point.x = point.x + movement.x
    point.y = point.y + movement.y
    
    --iterate until you find the last point
    if(point.x < level.blocksize/2) then
      hit = true
    elseif(point.y < level.blocksize/2) then
      hit = true
    elseif(point.x > window.width-level.blocksize/2) then
      hit = true
    elseif(point.y > window.height-level.blocksize/2) then
      hit = true
    end
  end
  
  --draw the line
  love.graphics.line(player.x, player.y, point.x, point.y)
end

--Is called all the time, keeps everything up to date
function playerUpdatePosition(dt)
  --Keep the aim correct
  playerSetAim()
  
  --Use the next move if it has been set
  --This is set if you press another direction while moving
  if(player.isMoving == false and player.nextMoveSet) then
    player.directionBody = player.nextMoveDirection
    player.isMoving = player.nextMoveSet
    player.nextMoveSet = false
  end
  
  --If isMoving is set, actually move the player
  if(player.isMoving) then
    local movement = playerCalcMovement(player.directionBody, dt)
    player.x = player.x + movement.x
    player.y = player.y + movement.y
  end
  
  --Keep the player on the grid
  if(playerOnGrid(dt)) then
    player.isMoving = false
    if(player.nextMoveSet) then
      player.directionBody = player.nextMoveDirection
      player.isMoving = true
      player.nextMoveSet = false
    end
  end
end

--check if the player is on a grid point. If it is, move it exactly on it
function playerOnGrid(dt)
  --first we check if we haven't walked out of the level
  if(player.x < level.blocksize) then
    player.x = level.blocksize
    return true
  end
  if(player.y < level.blocksize) then
    player.y = level.blocksize
    return true
  end
  if(player.x > window.width-level.blocksize) then
    player.x = window.width-level.blocksize
    return true
  end
  if(player.y > window.height-level.blocksize) then
    player.y = window.height-level.blocksize
    return true
  end
  
  --predict next movement
  local nextMove = playerCalcMovement(player.directionBody, dt)
  
  --calculate the distance from the grid
  local x = player.x % level.blocksize
  local y = player.y % level.blocksize
  
  --if the distance from the grid is smaller than the predicted movement, place the player on the grid and return true
  if((player.directionBody == 90 or player.directionBody == 270) and x < math.abs(nextMove.x)) then
    player.x = math.floor(player.x/level.blocksize)*level.blocksize
    return true
  end
    if((player.directionBody == 0 or player.directionBody == 180) and y < math.abs(nextMove.y)) then
    player.y = math.floor(player.y/level.blocksize)*level.blocksize
    return true
  end
  --Return false if nothing happened
  return false
end

--This is not as precise as I was hoping, but it does work
--It can calulate how something should move in a specific direction in degrees
function calculateMovementDegrees(direction, speed)
  local radials = direction*math.pi/180
  local movement = {}
  movement.x = math.sin(radials) * speed
  movement.y = math.cos(radials) * speed
  return movement
end

--is used for getting how much the player will move based on direction and delta time
function playerCalcMovement(direction, dt)
  local movement = {}
  movement.x = 0
  movement.y = 0
  
  --set for all 4 directions
  if(direction == 0) then --down
    movement.y = player.moveSpeed*dt
  elseif(direction == 90) then --right
    movement.x = player.moveSpeed*dt
  elseif(direction == 180) then --up
    movement.y = -player.moveSpeed*dt
  elseif(direction == 270) then --left
    movement.x = -player.moveSpeed*dt
  end
  
  return movement
end

function playerSetAim()
  local deltaX = mouse.x - player.x
  local deltaY = mouse.y - player.y
  player.directionAim = math.floor((math.deg(math.atan2(deltaX, deltaY))+45)/90)*90
end
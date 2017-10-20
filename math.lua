pi = 3.14

--Calculated the direction to a point in degrees
function directionToPoint(orgX, orgY, aimX, aimY)
  deltaX = aimX - orgX
  deltaY = aimY - orgY
  result = math.atan2(deltaX, deltaY)
  return math.deg(result)
end

function calculateMovement(speed, direction)
  local movement = {}
  movement.x = math.sin(direction) * speed
  movement.y = math.cos(direction) * speed
  return movement
end

function calculateMovementDegrees(speed, direction)
  local radials = direction*math.pi/180
  local movement = {}
  movement.x = math.sin(radials) * speed
  movement.y = math.cos(radials) * speed
  return movement
end

function test()
  print("test")
end


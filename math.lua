--Calculated the direction to a point in degrees
function directionToPoint(orgX, orgY, aimX, aimY)
  deltaX = aimX - orgX
  deltaY = aimY - orgY
  result = math.atan2(deltaX, deltaY)
  return math.deg(result)
end

--Create mouse object, so we can track the mouse position
mouse = {}
mouse.x = love.mouse.getX()
mouse.y = love.mouse.getY()
  
function mouseUpdatePosition()
  mouse.x = love.mouse.getX()
  mouse.y = love.mouse.getY()
end

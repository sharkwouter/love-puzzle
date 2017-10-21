function love.load()
  --objects for level
  level = {}
  window = {}
  tiles = {}
  enemies = {}
  
  --object for player
  player = {}
  
  --load other project files
  require("mouse")
  require("level")
  require("player")
end

function love.update(dt)
  --set move coordinates
  mouseUpdatePosition()
  
  --keyboard input
    if love.keyboard.isDown("s") then
    playerMove(0)
  end
  if love.keyboard.isDown("d") then
    playerMove(90)
  end
  if love.keyboard.isDown("w") then
    playerMove(180)
  end
  if love.keyboard.isDown("a") then
    playerMove(270)
  end
  
  --move player
  playerUpdatePosition(dt)
end

function love.draw()
  --draw level
  levelDrawGrid()
  
  --draw player
  playerDrawAim()
  playerDraw()
  
  --draw fps
  love.graphics.print(love.timer.getFPS(),0,0)
end
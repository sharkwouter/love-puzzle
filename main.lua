function love.load()
  --Base variables which count for every level
  level = {}
  level.width = 20
  level.height = 15
  level.blocksize = 48
  level.colorBackground = {50,200,0}
  level.colorGrid = {0,0,0}
    
  require("player")
  require("level")
  require("mouse")
end

function love.update(dt)
  --set move coordinates
  mouseUpdatePosition()
  
  --move player
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
  
  playerUpdatePosition(dt)
end

function love.draw()
  levelDrawGrid()
  playerDraw()
  
  --draw test
  love.graphics.setColor(0,0,0)
  love.graphics.print("X, Y: "..player.x..", "..player.y,0,0)
end
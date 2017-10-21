function love.load()
  --base variables which count for every level
  level = {}
  level.width = 10
  level.height = 10
  level.blocksize = 48
  level.colorBackground = {50,200,0}
  level.colorGrid = {0,0,0}
    
  --base variables for the window, allows us to resize it to the correct size
  window = {}
  window.width = (level.width+1)*level.blocksize
  window.height = (level.height+1)*level.blocksize

  --resize window to the level size
  love.window.setMode(window.width, window.height, {})
  
  --load other project files
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
  playerDrawAim()
end
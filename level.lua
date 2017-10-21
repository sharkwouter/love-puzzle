level.width = 10
level.height = 10
level.blocksize = 48
level.colorBackground = {50,200,0}
level.colorGrid = {0,0,0}

window.width = (level.width+1)*level.blocksize
window.height = (level.height+1)*level.blocksize

--resize window to the level size
love.window.setMode(window.width, window.height, {})

--set background color
love.graphics.setBackgroundColor(level.colorBackground)

function levelDrawGrid()
  love.graphics.setColor(level.colorGrid)
  for x=0.5,level.width+0.5 do
    love.graphics.line(x*level.blocksize, level.blocksize/2, x*level.blocksize, window.height-level.blocksize/2)
  end
  for y=0.5,level.height+0.5 do
      love.graphics.line(level.blocksize/2, y*level.blocksize, window.width-level.blocksize/2, y*level.blocksize)
  end
end
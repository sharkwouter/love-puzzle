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
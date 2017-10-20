--set background color
love.graphics.setBackgroundColor(level.colorBackground)

--base variables for the window, allows us to resize it to the correct size
window = {}
window.width = level.width*level.blocksize
window.height = level.height*level.blocksize

--resize window to the level size
love.window.setMode(window.width, window.height, {})



function levelDrawGrid()
  love.graphics.setColor(level.colorGrid)
  for x=1,level.width-1 do
    love.graphics.line(x*level.blocksize,0,x*level.blocksize,window.height)
  end
  for y=1,level.height-1 do
      love.graphics.line(0,y*level.blocksize,window.width,y*level.blocksize)
  end
end
local Field = Class('Field')

function Field:initialize()
  print('Field created')
end

function Field:draw(theme_color)
  offset = {55,125}
  print(theme_color)
  self.rate = 0.7

  --draw the battlefield
  love.graphics.rectangle("fill",0,0,400,600)

  for i=0,4 do
    for j = 0,5 do
      love.graphics.setColor(love.math.colorFromBytes(239,171,109,70))
      love.graphics.rectangle("fill",offset[1] + i*60, offset[2] + j*60, 50, 50)

      love.graphics.setColor(love.math.colorFromBytes(theme_color[1]*self.rate,theme_color[2]*self.rate,theme_color[3]*self.rate))
      love.graphics.rectangle("line",offset[1] + i*60, offset[2] + j*60, 50, 50)
    end
  end

  --set back to default
  love.graphics.setColor(love.math.colorFromBytes(219,161,89))
end

return Field
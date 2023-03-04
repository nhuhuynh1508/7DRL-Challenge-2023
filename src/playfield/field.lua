local Field = Class('Field')

function Field:initialize(cellSize,spacing)
  self.rate = 0.7
  self.cellSize = cellSize
  print(cellSize)
  print(self.cellSize)
  self.spacing = spacing or 10
  self.offset = {(400 - 5*self.cellSize - 4*self.spacing)/2, (600 - 6*self.cellSize - 5*self.spacing)/2}
end

function Field:draw(theme_color, isFighting)
  
  --draw the battlefield
  love.graphics.rectangle("fill",0,0,400,600)

  for i=0,4 do
    for j = 0,5 do
      love.graphics.setColor(love.math.colorFromBytes(239,171,109,70))
      love.graphics.rectangle("fill", self.offset[1] + i*(self.cellSize + self.spacing), self.offset[2] + j*(self.cellSize + self.spacing), self.cellSize, self.cellSize)

      if (isFighting == false) and (j>2) then
        love.graphics.setColor(love.math.colorFromBytes(theme_color[1]*self.rate*0.5,theme_color[2]*self.rate*0.5,theme_color[3]*self.rate*0.5))
      else 
        love.graphics.setColor(love.math.colorFromBytes(theme_color[1]*self.rate,theme_color[2]*self.rate,theme_color[3]*self.rate))
      end
      love.graphics.rectangle("line", self.offset[1] + i*(self.cellSize + self.spacing), self.offset[2] + j*(self.cellSize + self.spacing), self.cellSize, self.cellSize)
    end
  end

  --set back to default
  love.graphics.setColor(love.math.colorFromBytes(219,161,89))
end

return Field
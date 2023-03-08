local Tablet = require 'src.tablets.tablet'
local Templar = Class('Tablet', Tablet)

function Templar:initialize(column, row, level, color)
  Tablet.initialize(self, column, row, level, color)
end

function Templar:_draw()
  love.graphics.setColor(1, 1, 1)
  love.graphics.draw(Sprites.tablets.templar, self.x, self.y, 0, 2, 2)
end

return Templar
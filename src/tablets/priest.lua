local Tablet = require 'src.tablets.tablet'
local Priest = Class('Tablet', Tablet)

function Priest:initialize(column, row, level, color)
  Tablet.initialize(self, column, row, level, color)
end

function Priest:_draw()
  love.graphics.setColor(1, 1, 1)
  love.graphics.draw(Sprites.tablets.priest, self.x, self.y, 0, 2, 2)
end

return Priest
local Tablet = require 'src.tablets.tablet'
local Mage = Class('Tablet', Tablet)

function Mage:initialize(column, row, level, color)
  Tablet.initialize(self, column, row, level, color)
end

function Mage:_draw()
  love.graphics.setColor(1, 1, 1)
  love.graphics.draw(Sprites.tablets.mage, self.x, self.y, 0, 2, 2)
end

return Mage
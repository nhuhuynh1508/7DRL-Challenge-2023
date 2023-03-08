local Tablet = require 'src.tablets.tablet'
local Berserker = Class('Tablet', Tablet)

function Berserker:initialize(column, row, level, color)
  Tablet.initialize(self, column, row, level, color)
end

function Berserker:_draw()
  love.graphics.setColor(1, 1, 1)
  love.graphics.draw(Sprites.tablets.berserker, self.x, self.y, 0, 2, 2)
end

return Berserker
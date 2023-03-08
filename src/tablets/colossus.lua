local Tablet = require 'src.tablets.tablet'
local Colossus = Class('Tablet', Tablet)

function Colossus:initialize(column, row, level, color)
  Tablet.initialize(self, column, row, level, color)
end

function Colossus:_draw()
  love.graphics.setColor(1, 1, 1)
  love.graphics.draw(Sprites.tablets.colossus, self.x, self.y, 0, 2, 2)
end

return Colossus
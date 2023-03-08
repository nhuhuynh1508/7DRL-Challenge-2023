local Tablet = require 'src.tablets.tablet'
local Ranger = Class('Tablet', Tablet)

function Ranger:initialize(column, row, level, color)
  Tablet.initialize(self, column, row, level, color)
end

function Ranger:_draw()
  love.graphics.setColor(1, 1, 1)
  love.graphics.draw(Sprites.tablets.ranger, self.x, self.y, 0, 2, 2)
end

return Ranger
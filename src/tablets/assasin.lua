local Tablet = require 'src.tablets.tablet'
local Assassin = Class('Tablet', Tablet)

function Assassin:initialize(column, row, level, color)
  Tablet.initialize(self, column, row, level, color)
end

function Assassin:_draw()
  love.graphics.setColor(1, 1, 1)
  love.graphics.draw(Sprites.tablets.assassin, self.x, self.y, 0, 2, 2)
end

return Assassin
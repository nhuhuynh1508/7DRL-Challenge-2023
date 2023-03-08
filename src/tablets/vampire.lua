local Tablet = require 'src.tablets.tablet'
local Vampire = Class('Tablet', Tablet)

function Vampire:initialize(column, row, level, color)
  Tablet.initialize(self, column, row, level, color)
end

function Vampire:_draw()
  love.graphics.setColor(1, 1, 1)
  love.graphics.draw(Sprites.tablets.vampire, self.x, self.y, 0, 2, 2)
end

return Vampire
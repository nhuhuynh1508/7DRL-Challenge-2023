local Tablet = require 'src.tablets.tablet'
local wizard = Class('Tablet', Tablet)

function Wizard:initialize(column, row, level, color)
  Tablet.initialize(self, column, row, level, color)
end

function Wizard:_draw()
  love.graphics.setColor(1, 1, 1)
  love.graphics.draw(Sprites.tablets.wizard, self.x, self.y, 0, 2, 2)
end

return Wizard
local Slot = require 'src.dragAndDrop.slot'

local BenchSlot = Class('BenchSlot', Slot)

function BenchSlot:initialize(x, y)
  Slot.initialize(self, x, y)
end

function BenchSlot:draw()
  love.graphics.setColor(1, 1, 1)
  love.graphics.draw(Sprites.benchSlot, self.x, self.y, 0, 2, 2)
  love.graphics.setColor(love.math.colorFromBytes(theme_color))
end

return BenchSlot
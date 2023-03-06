local Entity = require 'src.entity'

local BenchSlot = Class('BenchSlot', Entity)

function BenchSlot:initialize(x, y)
  self.x, self.y = x, y
end

function BenchSlot:draw()
  love.graphics.setColor(1, 1, 1)
  love.graphics.draw(Sprites.benchSlot, self.x, self.y, 0, 2, 2)
  love.graphics.setColor(love.math.colorFromBytes(theme_color))
end

return BenchSlot
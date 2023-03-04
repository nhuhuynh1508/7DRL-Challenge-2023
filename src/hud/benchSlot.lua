local Entity = require 'src.entity'

local FieldSlot = Class('FieldSlot', Entity)

function FieldSlot:initialize(x, y)
  self.x, self.y = x, y
end

function FieldSlot:draw()
  love.graphics.setColor(1, 1, 1)
  love.graphics.draw(Sprites.benchSlot, self.x, self.y, 0, 2, 2)
end

return FieldSlot
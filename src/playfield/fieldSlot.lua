local Slot = require 'src.dragAndDrop.slot'

local FieldSlot = Class('FieldSlot', Slot)

function FieldSlot:initialize(x, y, gx, gy)
  Slot.initialize(self, x, y)
  self.gx, self.gy = gx, gy
end

function FieldSlot:draw()
  local mx, my = love.mouse.getPosition()
  if self.x < mx and mx < self.x + 50 and
      self.y < my and my < self.y + 54 then
    love.graphics.setColor(0.8, 0.8, 0.8)
  else
    love.graphics.setColor(1, 1, 1)
  end
  love.graphics.draw(Sprites.fieldSlot, self.x, self.y, 0, 2, 2)

  love.graphics.setColor(1, 1, 1)
end

return FieldSlot
local Entity = require 'src.entity'

local Slot = Class('Slot', Entity)

function Slot:initialize(x, y)
  self.x, self.y = x, y

  self.tablet = nil
end

function Slot:attachTablet(tablet)
  self.tablet = tablet
end

function Slot:detachTablet()
  self.tablet = nil
end

function Slot:onTabletReleased(tablet, x, y)
  if self.x < x and x < self.x + 50 and
      self.y < y and y < self.y + 54 then
    self:attachTablet(tablet)
    tablet.attachedSlot = self
    return true
  else 
    return false
  end
end

return Slot
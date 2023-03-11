local Tablet = require 'src.tablets.tablet'
local Priest = Class('Tablet', Tablet)

function Priest:initialize(column, row, level, color)
  Tablet.initialize(self, column, row, level, color)
  self.atkByLevel= {5,8,15}
  self.atkspdByLevel = {1.3, 1.5, 1.7}
  self.maxhpByLevel = {80,140,250}
  self.skillCDByLevel = {4,3.7,3.5}
  self.atk = self.atkByLevel[self.level]
  self.atkspd = self.atkspdByLevel[self.level]
  self.maxhp = self.maxhpByLevel[self.level]
  self.skillCD = self.skillCDByLevel[self.level]
  self.hp = self.maxhp or 100
  self.range = 7.0
  self.type = 'priest'
end

function Priest:_draw()
  love.graphics.setColor(1, 1, 1)
  love.graphics.draw(Sprites.tablets.priest, self.x, self.y, 0, 2, 2)
end

function Priest:skillUse()
  self.skillWait = true
  for _, ally in ipairs(self.allies) do
    ally:healHP(0.3*self.maxhp + 0.05*(ally.maxhp-ally.hp))
  end
  self.timer:after(self.skillCD, function() self:resetSkillWait() end)
end

return Priest
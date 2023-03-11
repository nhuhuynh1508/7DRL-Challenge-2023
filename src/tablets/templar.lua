local Tablet = require 'src.tablets.tablet'
local Templar = Class('Tablet', Tablet)

function Templar:initialize(column, row, level, color)
  Tablet.initialize(self, column, row, level, color)
  self.atkByLevel= {12,16,20}
  self.atkspdByLevel = {0.5, 0.6, 0.7}
  self.maxhpByLevel = {180,290,405}
  self.skillCDByLevel = {15,14,13}
  self.atk = self.atkByLevel[self.level]
  self.atkspd = self.atkspdByLevel[self.level]
  self.maxhp = self.maxhpByLevel[self.level]
  self.skillCD = self.skillCDByLevel[self.level]
  self.hp = self.maxhp or 100
  self.range = 7.0
  self.type = 'templar'
end

function Templar:_draw()
  love.graphics.setColor(1, 1, 1)
  love.graphics.draw(Sprites.tablets.templar, self.x, self.y, 0, 2, 2)
end

function Templar:skillUse()
  self.skillWait = true
  self.dmgReduced = 0.9
  self.timer:after(3, function() self.dmgReduced = 0 end)
  self.timer:after(self.skillCD, function() self:resetSkillWait() end)
end

return Templar
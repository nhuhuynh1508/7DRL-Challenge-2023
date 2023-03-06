local Tablet = require 'src.tablets.tablet'
local Knight = Class('Tablet', Tablet)

function Knight:initialize(column, row, level, color)
  Tablet.initialize(self,column, row, level, color)
  
  self.atkByLevel= {10,15,30}
  self.atkspdByLevel = {0.7,0.8,1}
  self.maxhpByLevel = {120,250,700}
  self.skillCDByLevel = {7,6,6}
  self.atk = self.atkByLevel[self.level]
  self.atkspd = self.atkspdByLevel[self.level]
  self.maxhp = self.maxhpByLevel[self.level]
  self.skillCD = self.skillCDByLevel[self.level]
  self.hp = self.maxhp
  self.range = 7.0
  self.type = 'Knight'
end

function Knight:skillUse()
  self.skillWait = true
  self:healHP(self.maxhp*0.07)
  self.timer:after(self.skillCD, function() self:resetSkillWait() end)
end

return Knight
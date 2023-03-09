local Tablet = require 'src.tablets.tablet'
local Warrior = Class('Tablet', Tablet)

function Warrior:initialize(column, row, level, color)
  Tablet.initialize(self,column, row, level, color)
  
  self.atkByLevel= {10,13,17}
  self.atkspdByLevel = {0.7,0.8,1}
  self.maxhpByLevel = {120,200,300}
  self.skillCDByLevel = {7,6,6}
  self.atk = self.atkByLevel[self.level]
  self.atkspd = self.atkspdByLevel[self.level]
  self.maxhp = self.maxhpByLevel[self.level]
  self.skillCD = self.skillCDByLevel[self.level]
  self.hp = self.maxhp
  self.range = 7.0
  self.type = 'warrior'
end

function Warrior:skillUse()
  self.skillWait = true
  self:healHP(self.maxhp*0.07)
  self.timer:after(self.skillCD, function() self:resetSkillWait() end)
end

function Warrior:_draw()
  love.graphics.setColor(1, 1, 1)
  love.graphics.draw(Sprites.tablets.warrior, self.x, self.y, 0, 1.5, 1.5)
end

return Warrior
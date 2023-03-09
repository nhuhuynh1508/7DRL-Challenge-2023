local Tablet = require 'src.tablets.tablet'
local Ranger = Class('Tablet', Tablet)

function Ranger:initialize(column, row, level, color)
  Tablet.initialize(self, column, row, level, color)
  self.atkByLevel= {10,14,19}
  self.atkspdByLevel = {1.3, 1.5, 1.7}
  self.maxhpByLevel = {60,85,130}
  self.skillCDByLevel = {14,12,10}
  self.atk = self.atkByLevel[self.level]
  self.atkspd = self.atkspdByLevel[self.level]
  self.maxhp = self.maxhpByLevel[self.level]
  self.skillCD = self.skillCDByLevel[self.level]
  self.hp = self.maxhp or 100
  self.range = 7.0
  self.type = 'ranger'
end

function Ranger:_draw()
  love.graphics.setColor(1, 1, 1)
  love.graphics.draw(Sprites.tablets.ranger, self.x, self.y, 0, 1.5, 1.5)
end

function Ranger:skillUse()
  self.skillWait = true
  self.atkspd = self.atkspd * 3
  self.timer:after(2, function() self.atkspd = self.atkspd/3 end)
  self.timer:after(self.skillCD, function() self:resetSkillWait() end)
end

return Ranger
local Tablet = require 'src.tablets.tablet'
local Mage = Class('Tablet', Tablet)

function Mage:initialize(column, row, level, color)
  Tablet.initialize(self, column, row, level, color)

  self.atkByLevel= {15,20,25}
  self.atkspdByLevel = {0.9, 0.95, 1.1}
  self.maxhpByLevel = {60,75,140}
  self.skillCDByLevel = {4,3,3}
  self.atk = self.atkByLevel[self.level]
  self.atkspd = self.atkspdByLevel[self.level]
  self.maxhp = self.maxhpByLevel[self.level]
  self.skillCD = self.skillCDByLevel[self.level]
  self.hp = self.maxhp
  self.range = 7.0
  self.type = 'mage'
end

function Mage:_draw()
  love.graphics.setColor(1, 1, 1)
  love.graphics.draw(Sprites.tablets.mage, self.x, self.y, 0, 1.5, 1.5)
end

function Mage:skillUse()
  self.skillWait = true
  self.enemies[love.math.random( #self.enemies)]:stunned(2)
  self.timer:after(self.skillCD, function() self:resetSkillWait() end)
end

return Mage
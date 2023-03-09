local Tablet = require 'src.tablets.tablet'
local Archer = Class('Tablet', Tablet)

function Archer:initialize(column, row, level, color)
  Tablet.initialize(self,column, row, level, color)
  
  self.atkByLevel= {13,18,26}
  self.atkspdByLevel = {0.8, 0.92, 1}
  self.maxhpByLevel = {50,70,120}
  self.skillCDByLevel = {7,7,6}
  self.atk = self.atkByLevel[self.level]
  self.atkspd = self.atkspdByLevel[self.level]
  self.maxhp = self.maxhpByLevel[self.level]
  self.skillCD = self.skillCDByLevel[self.level]
  self.hp = self.maxhp
  self.range = 7.0
  self.type = 'archer'
end

function Archer:skillUse()
  self.skillWait = true
  for i = 1, (self.level+2) do
    self:normalAttack(self.atk*0.35)
  end
  self.timer:after(self.skillCD, function() self:resetSkillWait() end)
end

function Archer:_draw()
  love.graphics.setColor(1, 1, 1)
  love.graphics.draw(Sprites.tablets.archer, self.x, self.y, 0, 1.5, 1.5)
end

return Archer
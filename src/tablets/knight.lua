local Tablet = require 'src.tablets.tablet'
local Knight = Class('Tablet', Tablet)

function Knight:initialize(column, row, level, color)
  Tablet.initialize(self,column, row, level, color)
  
  self.atkByLevel= {12,14,18.5}
  self.atkspdByLevel = {0.5, 0.65, 0.77}
  self.maxhpByLevel = {150,250,370}
  self.skillCDByLevel = {7,7,7}
  self.atk = self.atkByLevel[self.level]
  self.atkspd = self.atkspdByLevel[self.level]
  self.maxhp = self.maxhpByLevel[self.level]
  self.skillCD = self.skillCDByLevel[self.level]
  self.hp = self.maxhp
  self.range = 7.0
  self.type = 'knight'
end

function Knight:skillUse()
end

function Knight:_draw()
  love.graphics.setColor(1, 1, 1)
  love.graphics.draw(Sprites.tablets.knight, self.x, self.y, 0, 1, 1)
end

return Knight
local Tablet = require 'src.tablets.tablet'
local Rogue = Class('Tablet', Tablet)
local Bullet = require 'src.tablets.bullet.bullet'

function Rogue:initialize(column, row, level, color)
  Tablet.initialize(self,column, row, level, color)
  
  self.atkByLevel= {15,20,25}
  self.atkspdByLevel = {0.9, 0.95, 1.1}
  self.maxhpByLevel = {60,75,140}
  self.skillCDByLevel = {7,7,7}
  self.atk = self.atkByLevel[self.level]
  self.atkspd = self.atkspdByLevel[self.level]
  self.maxhp = self.maxhpByLevel[self.level]
  self.skillCD = self.skillCDByLevel[self.level]
  self.hp = self.maxhp
  self.range = 7.0
  self.type = 'rogue'
end

function Rogue:setup(allies, enemies)
  self.allies = allies
  self.enemies = enemies
  self.timer = Timer.new()

  self.isDead = false
  self.norAtkWait, self.skillWait = false, false
  
  -- local max = 0
  -- for _,enemy in ipairs(self.enemies) do
  --   local a = self:distanceAway(enemy.column, enemy.row)
  --   if (a > max) then
  --     max = a
  --   end
  -- end
  -- for _,enemy in ipairs(self.enemies) do
  --   print('Rogue set up')
  --   if (self:distanceAway(enemy.column, enemy.row) == max) then
  --     self:reposition(enemy.column, enemy.row)
  --     break
  --   end
  -- end
end

function Rogue:skillUse()
  --empty on purpose
end

function Rogue:normalAttack(damage)
  self.norAtkWait = true
  self.hitableEnemies = self:objectsWithinRange(self.range,self.enemies)
  
  self.closestRange = 0
  for _, enemy in ipairs(self.hitableEnemies) do
    local a = self:distanceAway(enemy.column, enemy.row) 
    if (a > self.closestRange) then
      self.closestRange = a
    end
  end
  for _, enemy in ipairs(self.hitableEnemies) do
    if (self:distanceAway(enemy.column, enemy.row) == self.closestRange) then
      table.insert(self.bullets, Bullet(self.x,self.y,enemy.x,enemy.y))
      self.timer:after(0.7, function() enemy:receiveDamage(damage) end)
      break
    end
  end
  waiting_time = 1/self.atkspd
  self.timer:after(waiting_time, function() self:resetNorAtkWait() end)
end

function Rogue:_draw()
  love.graphics.setColor(1, 1, 1)
  love.graphics.draw(Sprites.tablets.rogue, self.x, self.y, 0, 2, 2)
end

return Rogue
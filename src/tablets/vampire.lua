local Tablet = require 'src.tablets.tablet'
local Bullet = require 'src.tablets.bullet.bullet'
local Vampire = Class('Tablet', Tablet)

function Vampire:initialize(column, row, level, color)
  Tablet.initialize(self, column, row, level, color)
  self.atkByLevel= {10,11.5,13.5}
  self.atkspdByLevel = {1.2, 1.33, 1.5}
  self.maxhpByLevel = {150,222,314}
  self.skillCDByLevel = {7,6,6}
  self.atk = self.atkByLevel[self.level]
  self.atkspd = self.atkspdByLevel[self.level]
  self.maxhp = self.maxhpByLevel[self.level]
  self.skillCD = self.skillCDByLevel[self.level]
  self.hp = self.maxhp
  self.range = 7.0
  self.type = 'vampire'
end

function Vampire:normalAttack(damage)
  self.norAtkWait = true
  self.hitableEnemies = self:objectsWithinRange(self.range,self.enemies)
  
  self.closestRange = self.range
  for _, enemy in ipairs(self.hitableEnemies) do
    local a = self:distanceAway(enemy.column, enemy.row) 
    if (a < self.closestRange) then
      self.closestRange = a
    end
  end
  for _, enemy in ipairs(self.hitableEnemies) do
    if (self:distanceAway(enemy.column, enemy.row) == self.closestRange) then
      table.insert(self.bullets, Bullet(self.x,self.y,enemy.x,enemy.y))
      self.timer:after(0.7, function() 
        enemy:receiveDamage(damage)
        self:healHP(0.03*self.maxhp)
      end)
      break
    end
  end
  waiting_time = 1/self.atkspd
  self.timer:after(waiting_time, function() self:resetNorAtkWait() end)
end

function Vampire:_draw()
  love.graphics.setColor(1, 1, 1)
  love.graphics.draw(Sprites.tablets.vampire, self.x, self.y, 0, 1.5, 1.5)
end

function Vampire:skillUse()

end

return Vampire
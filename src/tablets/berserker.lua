local Bullet = require 'src.tablets.bullet.bullet'
local Tablet = require 'src.tablets.tablet'
local Berserker = Class('Tablet', Tablet)

function Berserker:initialize(column, row, level, color)
  Tablet.initialize(self, column, row, level, color)

  self.atkByLevel= {20,23,27}
  self.atkspdByLevel = {0.8,0.8,0.9}
  self.maxhpByLevel = {140,240,330}
  self.skillCDByLevel = {4,3,3}
  self.atk = self.atkByLevel[self.level]
  self.atkspd = self.atkspdByLevel[self.level]
  self.maxhp = self.maxhpByLevel[self.level]
  self.skillCD = self.skillCDByLevel[self.level]
  self.hp = self.maxhp
  self.range = 7.0
  self.type = 'berserker'
end

function Berserker:_draw()
  love.graphics.setColor(1, 1, 1)
  love.graphics.draw(Sprites.tablets.berserker, self.x, self.y, 0, 2, 2)
end

function Berserker:normalAttack(damage)
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
        for _, otherenemy in ipairs(self.hitableEnemies) do
          if otherenemy:distanceAway(enemy.column,enemy.row) < 1 then
            otherenemy:receiveDamage(0.4*damage)
          end
        end
      end)
      break
    end
  end
  waiting_time = 1/self.atkspd
  self.timer:after(waiting_time, function() self:resetNorAtkWait() end)
end

function Berserker:skillUse()

end

return Berserker
local Bullet = require 'src.tablets.bullet.bullet'
local Tablet = Class('Tablet')

healthBarWidth = 50
healthBarHeight = 6

function Tablet:initialize(column, row, level, color)
  --Draw attribute
  self.row, self.column = row, column
  self.color = color
  self.gap = spacing + cellSize
  self.x, self.y = fieldOffset[1] + self.gap*self.column + cellSize/2, fieldOffset[2] + self.gap*self.row + cellSize*4/7
  self.offset = cellSize/2
  self.bullets, self.targetedEnemies = {}, {}

  --Tablet strength attribute
  self.level = level
  self.atkByLevel= {10,15,30}
  self.atkspdByLevel = {0.7,0.8,1}
  self.maxhpByLevel = {100,150,300}
  self.skillCDByLevel = {10,9,8}
  self.atk = self.atkByLevel[self.level]
  self.atkspd = self.atkspdByLevel[self.level]
  self.maxhp = self.maxhpByLevel[self.level]
  self.skillCD = self.skillCDByLevel[self.level]
  self.hp = self.maxhp or 100
  self.range = 7.0
  self.type = 'default'
end

function Tablet:setup(allies, enemies)
  self.allies = allies
  self.enemies = enemies
  self.timer = Timer.new()

  self.isDead = false
  self.norAtkWait, self.skillWait = false, false
end

function Tablet:update(dt)
  self.timer:update(dt)
  if not self.isDead then
    if not self.norAtkWait then
      self.norAtkWait = true
      self:normalAttack(self.atk)
    end
    if not self.skillWait then
      self.skillWait = true
      self:skillUse()
    end
  end
end

function Tablet:draw()
  if not self.isDead then
    --Draw health bar & name for tablets
    self:drawHealthBar()

    --Temporary asset : circle
    self:_draw()
  end

  --Draw bullets (if ranged)
  self:drawBullets()
end

function Tablet:_draw()
  love.graphics.setColor(0.8, 0.8, 0.8)
  love.graphics.circle('fill', self.x, self.y, 15)
  love.graphics.setColor(1, 1, 1)
end

function Tablet:keypressed(key)
  if not self.isDead then
    if key == 'a' then
      print("Pressed A")
      -- self:normalAttack()
      self:receiveDamage(50)
    end
    if key == 's' then
      print("Pressed S")
      self:healHP(20)
    end
  end
end

function Tablet:normalAttack(damage)
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
      self.timer:after(0.7, function() enemy:receiveDamage(damage) end)
      break
    end
  end
  waiting_time = 1/self.atkspd
  self.timer:after(waiting_time, function() self:resetNorAtkWait() end)
end

function Tablet:skillUse()
  self.skillWait = true
  for _, ally in ipairs(self.allies) do
    -- print("Skill use by ", self.type)
    ally:healHP(10)
  end
  self.timer:after(self.skillCD, function() self:resetSkillWait() end)
end

function Tablet:receiveDamage(damage)
  self.hp = math.max(self.hp - damage, 0)
  if self.hp <= 0 then
    self.isDead = true

    Gamestate.current():onTabletDie(self)
  end
end

function Tablet:healHP(heal)
  self.hp = math.min(self.hp + heal, self.maxhp)
end

function Tablet:resetSkillWait()
  self.skillWait = false
end

function Tablet:resetNorAtkWait()
  self.norAtkWait = false
end

function Tablet:drawHealthBar()
  local healthBarHeight = healthBarHeight
  local healthBarWidth = healthBarWidth
  love.graphics.setColor(0,0,0)
  love.graphics.print(self.type, self.x-healthBarWidth/2, self.y-42, 0, 1, 1)
  if (self.maxhp > 500) then
    healthBarWidth = 1.5*healthBarWidth
  end
  if (self.hp > 0.5*self.maxhp) then
    love.graphics.setColor(love.math.colorFromBytes(0, 200, 0))
  elseif (self.hp > 0.3*self.maxhp) then
    love.graphics.setColor(love.math.colorFromBytes(255, 255, 0))
  else
    love.graphics.setColor(love.math.colorFromBytes(255, 0, 0))
  end
  love.graphics.rectangle('fill', self.x-healthBarWidth/2, self.y-30, healthBarWidth*self.hp/self.maxhp, healthBarHeight)
  love.graphics.setColor(love.math.colorFromBytes(self.color))
  love.graphics.rectangle('line', self.x-healthBarWidth/2, self.y-30, healthBarWidth, healthBarHeight)
  love.graphics.rectangle('line', self.x-healthBarWidth/2, self.y-30, healthBarWidth, healthBarHeight)
  segment = self.maxhp/100
  for i = 0, math.ceil(segment)-1 do
    if i < (math.ceil(segment)-1) then
      love.graphics.rectangle('line', self.x-healthBarWidth/2+i*healthBarWidth/segment, self.y-30, healthBarWidth/segment, healthBarHeight)
    end
  end
end

function Tablet:distanceAway(target_column, target_row)
  local x = self.column - target_column
  local y = self.row - target_row
  return math.sqrt(x^2 + y^2)
end

function Tablet:objectsWithinRange(range,objects)
  selectedObjects = {}
  for _,object in ipairs(objects) do
    if (self:distanceAway(object.column, object.row) < range) then
      table.insert(selectedObjects, object)
    end
  end
  return selectedObjects
end

function Tablet:drawBullets()
  a = 1
  arrivedBullets ={}
  for _, bullet in ipairs(self.bullets) do
    bullet:draw(self.color)
    if bullet.isArrived then
      table.insert(arrivedBullets, a)
    end
    a = a+1
  end
  arrivedBulletsRemoved = 0
  for _,i in ipairs(arrivedBullets) do
    table.remove(self.bullets, i - arrivedBulletsRemoved)
  end
end

function Tablet:reposition(column, row)
  self.column, self.row = column, row
  self.x, self.y = fieldOffset[1] + self.gap*self.column + cellSize/2, fieldOffset[2] + self.gap*self.row + cellSize*4/7
  print('Reposition')
end

return Tablet
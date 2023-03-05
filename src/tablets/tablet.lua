local Bullet = require 'src.tablets.bullet.bullet'
local Tablet = Class('Tablet')

healthBarWidth = 50
healthBarHeight = 6

function Tablet:initialize(column, row, atk, atkspd, maxhp, color)
  self.range = 7
  self.row, self.column = row, column
  self.gap = spacing + cellSize
  self.x, self.y = fieldOffset[1] + self.gap*column + cellSize/2, fieldOffset[2] + self.gap*row + cellSize*4/7
  self.offset = cellSize/2
  self.atk = atk or 1
  self.atkspd = atkspd or 1
  self.maxhp = maxhp
  self.hp = maxhp
  self.color = color
  self.skillCD = 20
  self.type = 'archer'
  self.bullets = {}
  self.targetedEnemies = {}

  self.isDead = false
  self.norAtkWait = false
  self.skillWait = false
  
end

function Tablet:setup(allies, enemies)
  self.allies = allies
  self.enemies = enemies
  print(name)
end

function Tablet:update(dt)
  Timer.update(dt)
  if self.hp == 0 then
    self.isDead = true
  end
  if not self.isDead then
    if not self.norAtkWait then
      self.norAtkWait = true
      self:normalAttack()
    end
    if not self.skillWait then
      self.skillWait = true
      self:skillUse()
    end
  end
end

function Tablet:draw()
  if not self.isDead then
    --Draw health bar for tablets
    self:drawHealthBar()

    --Temporary asset : circle
    love.graphics.circle('fill', self.x, self.y,15)

    love.graphics.setColor(1,1,1)
  end

  --Draw bullets (if ranged)
  a = 1
  arrivedBullets ={}
  for _, bullet in ipairs(self.bullets) do
    bullet:draw(self.color)
    if bullet:arrive() then
      table.insert(arrivedBullets, a)
    end
    a = a+1
  end
  for _,i in ipairs(arrivedBullets) do
    table.remove(self.bullets, a)
  end
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

function Tablet:normalAttack(waiting_time)
  self.norAtkWait = true
  self.targetedEnemies = {}
  for _, enemy in ipairs(self.enemies) do
    if (self:distanceAway(enemy.column, enemy.row) < self.range*self.range) then
      table.insert(self.targetedEnemies, enemy)
    end
  end
  for _, enemy in ipairs(self.targetedEnemies) do
    table.insert(self.bullets, Bullet(self.x,self.y,enemy.x,enemy.y))
    Timer.after(0.7, function() enemy:receiveDamage(self.atk) end)

  end
  waiting_time = 1/self.atkspd
  print(waiting_time)
  Timer.after(waiting_time, function() self:resetNorAtkWait() end)
end

function Tablet:skillUse()
  self.skillWait = true
  for _, ally in ipairs(self.allies) do
    -- print("Skill use by ", self.type)
    ally:healHP(10)
  end
  Timer.after(self.skillCD, function() self:resetSkillWait() end)
end

function Tablet:receiveDamage(damage)
  self.hp = math.max(self.hp - damage,0)
end

function Tablet:healHP(heal)
  self.hp = math.min(self.hp + heal, self.maxhp)
end

function Tablet:resetSkillWait()
  self.skillWait = false
end

function Tablet:resetNorAtkWait()
  self.norAtkWait = false
  print("reset normal attack")
end

function Tablet:drawHealthBar()
  local healthBarHeight = healthBarHeight
  local healthBarWidth = healthBarWidth
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
  return x*x + y*y
end

return Tablet
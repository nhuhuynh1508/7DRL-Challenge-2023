local Tablet = Class('Tablet')

healthBarWidth = 45
healthBarHeight = 7

function Tablet:initialize(x, y, type, atk, atkspd, maxhp, color, cellSize)
  self.x, self.y = x,y
  self.offset = cellSize/2
  self.atk = atk or 1
  self.atkspd = atkspd or 1
  self.maxhp = maxhp
  self.hp = maxhp
  self.color = color
  self.skillTime = 10
  self.type = type

  self.isDead = false
  self.norAtkWait = false
  self.skillWait = false
  
end

function Tablet:setup(allies, enemies)
  self.allies = allies
  self.enemies = enemies
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
    love.graphics.rectangle('fill', self.x-healthBarWidth/2, self.y-25, healthBarWidth*self.hp/self.maxhp, healthBarHeight)
    love.graphics.setColor(love.math.colorFromBytes(self.color))
    love.graphics.rectangle('line', self.x-healthBarWidth/2, self.y-25, healthBarWidth, healthBarHeight)
    love.graphics.rectangle('line', self.x-healthBarWidth/2, self.y-25, healthBarWidth, healthBarHeight)
    segment = self.maxhp/100
    for i = 0, math.ceil(segment)-1 do
      if i < (math.ceil(segment)-1) then
        love.graphics.rectangle('line', self.x-healthBarWidth/2+i*healthBarWidth/segment, self.y-25, healthBarWidth/segment, healthBarHeight)
      end
    end

    love.graphics.circle('fill', self.x, self.y,10)

    love.graphics.setColor(1,1,1)
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
  for _, enemy in ipairs(self.enemies) do
    enemy:receiveDamage(self.atk)
  end
  waiting_time = 1/self.atkspd
  Timer.after(waiting_time, function() self:resetNorAtkWait() end)
end

function Tablet:skillUse()
  self.skillWait = true
  for _, ally in ipairs(self.allies) do
    print("Skill use by ", type)
    ally:healHP(10)
  end
  Timer.after(self.skillTime, function() self:resetSkillWait() end)
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
end

return Tablet
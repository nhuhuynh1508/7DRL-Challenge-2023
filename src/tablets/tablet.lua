local Tablet = Class('Tablet')

healthBarWidth = 45
healthBarHeight = 7

function Tablet:initialize(x, y, type, atk, atkspd, maxhp, color)
  self.x, self.y = x,y
  self.atk = atk or 1
  self.atkspd = atkspd or 1
  self.maxhp = maxhp
  self.hp = maxhp
  self.isDead = false
  self.color = color
  print(self.color[1],self.color[2],self.color[3])
end

function Tablet:setup(allies, enemies)
  self.allies = allies
  self.enemies = enemies
  print(self.allies)
  print(self.enemies)
  print("----------------")
end

function Tablet:receiveDamage(damage)
  print("HP now: ", self.hp)
  print("Receive damage", damage)
  self.hp = math.max(self.hp - damage,0)
end

function Tablet:healHP(heal)
  self.hp = math.min(self.hp + heal, self.maxhp)
end

function Tablet:update(dt)
  if self.hp == 0 then
    self.isDead = true
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
      self:normalAttack(self.enemies)
    end
    if key == 's' then
      print("Pressed S")
    end
  end
end

function Tablet:normalAttack(enemies)
  for _, enemy in ipairs(enemies) do
    enemy:receiveDamage(self.atk)
  end
end

return Tablet
local Tablet = Class('Tablet')

healthBarWidth = 40
healthBarHeight = 7

function Tablet:initialize(x,y,type, atk, atkspd, maxhp)
  self.x, self.y = x,y
  self.team = team or 1
  self.atk = atk or 1
  self.atkspd = atkspd or 1
  self.maxhp = maxhp
  self.hp = maxhp
  self.isDead = false

  function receiveDamage(damage)
    print("HP now: ", self.hp)
    print("Receive damage", damage)
    self.hp = math.max(self.hp - damage,0)
  end

  function healHP(heal)
    self.hp = math.min(self.hp + heal, self.maxhp)
  end
end

function Tablet:setup()
  print(self.hp)
end

function Tablet:update(dt)
  if self.hp == 0 then
    self.isDead = true
  end
  Timer.update(dt)
end

function Tablet:draw()
  if not self.isDead then
    local healthBarWidth = healthBarWidth
    --Draw Health Bar
    if (self.maxhp > 500) then
      healthBarWidth = 1.5*healthBarWidth
    end
    if (self.hp > 0.5*self.maxhp) then
      love.graphics.setColor(0,150,0)
    elseif (self.hp > 0.3*self.maxhp) then
      love.graphics.setColor(255,255,0)
    else
      love.graphics.setColor(255,0,0)
    end
    love.graphics.rectangle('fill',self.x-healthBarWidth/2,self.y-25,healthBarWidth*self.hp/self.maxhp,healthBarHeight)
    love.graphics.setColor(love.math.colorFromBytes(89,104,105))
    love.graphics.rectangle('line',self.x-healthBarWidth/2,self.y-25,healthBarWidth,healthBarHeight)
    segment = self.maxhp/100
    for i = 0, math.ceil(segment)-1 do
      if i < (math.ceil(segment)-1) then
        love.graphics.rectangle('line',self.x-healthBarWidth/2+i*healthBarWidth/segment,self.y-25,healthBarWidth/segment,healthBarHeight)
      end
    end
    
    love.graphics.setColor(1,1,1)
    love.graphics.circle('line',self.x,self.y,10)
  end
end

function Tablet:keypressed(key)
  if key == 'a' then
    print("Pressed A")
    receiveDamage(20)
  end
  if key == 's' then
    print("Pressed S")
    healHP(20)
  end
end

return Tablet
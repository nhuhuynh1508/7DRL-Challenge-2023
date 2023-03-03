local Tablet = Class('Tablet')

healthBarWidth = 40
healthBarHeight = 7

function Tablet:initialize(x,y,team,type, atk, atkspd, maxhp)
  self.x, self.y = x,y
  self.team = team or 1
  self.atk = atk or 1
  self.atkspd = atkspd or 1
  self.maxhp, self.hp = maxhp, maxhp
  self.isDead = false

  self.hp = 0
  -- love.graphics.newImage

end

function Tablet:receiveDamage(damage)
  if (self.hp > damage) then
    self.hp = self.hp - damage
  else
    self.hp = 0
  end
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
  if not isDead then
    --Draw Health Bar
    if (self.maxhp > 500) then
      local healthBarWidth = 1.5*healthBarWidth
      if (self.hp > 0.5*self.maxhp) then
        love.graphics.setColor(0,200,0)
      elseif (self.hp > 0.3*self.maxhp) then
        love.graphics.setColor(255,255,0)
      else
        love.graphics.setColor(255,0,0)
      end
      love.graphics.rectangle('fill',self.x-healthBarWidth/2,self.y-25,healthBarWidth*self.hp/self.maxhp,healthBarHeight)
      love.graphics.setColor(255,255,255)
      love.graphics.rectangle('line',self.x-healthBarWidth/2,self.y-25,healthBarWidth,healthBarHeight)
      segment = self.maxhp/100
      for i = 0, math.ceil(segment)-1 do
        if i < (math.ceil(segment)-1) then
          love.graphics.rectangle('line',self.x-healthBarWidth/2+i*healthBarWidth/segment,self.y-25,healthBarWidth/segment,healthBarHeight)
        end
      end
    end

    print('sup')
    love.graphics.circle('line',self.x,self.y,10)
  end
end

return Tablet
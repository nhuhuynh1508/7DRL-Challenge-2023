local Tablet = Class('Tablet')

function Tablet:initialize(team, atk, maxhp)
  self.team = team
  self.atk = atk or 1
  self.maxhp, self.hp = maxhp
  self.isDead = false
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

end

function Tablet:draw()
  if not isDead then
    love.graphics.circle('line',0,0,10)
  end
end

return Tablet
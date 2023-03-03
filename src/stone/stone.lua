local Stone = Class('Stone')

function Stone:initialize(team, atk, maxhp)
  self.team = team
  self.atk = atk
  self.maxhp, self.hp = maxhp
end

function Stone:receiveDamage(damage)
  if (self.hp > damage) then
    self.hp = self.hp - damage
  else
    self.hp = 0
  end
end

function Stone:healHP(heal)
  self.hp = math.min(self.hp + heal, self.maxhp)
end

function
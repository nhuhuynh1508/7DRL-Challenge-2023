local Tablet = require 'src.tablets.tablet'
local Field = require 'src.playfield.field'
local Benchslot = require 'src.hud.benchSlot'
local Map = require 'src.map.map'


-- Global variable
theme_color = {219,161,89}
isDead = false
isFighting = false
done_once = false

-- Battlefield relating variable
cellSize = 60
spacing = 10
fieldOffset = {(400 - 5*cellSize - 4*spacing)/2, (600 - 6*cellSize - 5*spacing)/2}

blue = {0,0,255}
red = {255,0,0}


local Game = {}

function Game:enter()
  --Self variable
  self.teamBlue = {}
  self.teamRed = {}

  self.map = Map(12)
  
  self.maxhp, self.hp = maxhp or 100, maxhp or 100

  self:setup()
end

function Game:setup()
  self.playfield = Field()
  
  -- table.insert(self.teamBlue, Priest(0, 0, 1, blue))
  -- table.insert(self.teamBlue, Mage(1, 1, 1, blue))
  table.insert(self.teamBlue, Vampire(self.playfield.fieldSlots.entities[4], 3, blue))
  table.insert(self.teamRed, Templar(self.playfield.fieldSlots.entities[11], 1, red))
  table.insert(self.teamRed, Ranger(self.playfield.fieldSlots.entities[12], 1, red))
  table.insert(self.teamRed, Knight(self.playfield.fieldSlots.entities[13], 1, red))
  -- table.insert(self.teamRed, Archer(4, 5, 1, red))

  for _, member in ipairs(self.teamBlue) do
    member:setup(self.teamBlue,self.teamRed)
  end
  for _, member in ipairs(self.teamRed) do
    member:setup(self.teamRed,self.teamBlue)
  end

  -- setup benchslot
  self.benchslots = {}
  table.insert(self.benchslots, Benchslot(10, 650))
  table.insert(self.benchslots, Benchslot(90, 650))
  table.insert(self.benchslots, Benchslot(175, 650))
  table.insert(self.benchslots, Benchslot(260, 650))
  table.insert(self.benchslots, Benchslot(340, 650))
end

function Game:update(dt)
  --remove dead tablets
  self:destroyDeadTablets()

  --update tablets
  for _, member in ipairs(self.teamBlue) do
    member:update(dt)
  end
  for _, member in ipairs(self.teamRed) do
    member:update(dt)
  end

  self.map:update(dt)
end

function Game:draw()
  --Theme color: kaki
  --benchslot
  love.graphics.line(400, 0, 400, 800)
  for _,benchslot in ipairs(self.benchslots) do
    benchslot:draw()
  end

  self.playfield:draw()

  --draw UI for health & money
  love.graphics.rectangle('line', 10, 740, 380, 30)
  love.graphics.line(200, 740, 200, 770)
  --draw heart
  love.graphics.draw(Sprites.heart, 20, 745, 0, 0.1, 0.1)
  --write health
  love.graphics.print(self.hp, 50, 748, 0, 1, 1)
  --draw coin
  love.graphics.draw(Sprites.coin, 210, 745, 0, 2, 2)

  ---draw tablets
  for _, member in ipairs(self.teamBlue) do
    member:draw()
  end
  for _, member in ipairs(self.teamRed) do
    member:draw()
  end

  self.map:draw()
end

function Game:keypressed(key)
  for _, member in ipairs(self.teamBlue) do
    member:keypressed(key)
  end
  for _, member in ipairs(self.teamRed) do
    member:keypressed(key)
  end
end

function Game:mousepressed(x, y)
  self.map:mousepressed(x, y)

  for _, member in ipairs(self.teamBlue) do member:mousepressed(x, y) end
  for _, member in ipairs(self.teamRed) do member:mousepressed(x, y) end
end

function Game:mousemoved(x, y)
  self.map:mousemoved(x, y)
end

function Game:mousereleased(x, y)
  for _, member in ipairs(self.teamBlue) do member:mousereleased(x, y) end
  for _, member in ipairs(self.teamRed) do member:mousereleased(x, y) end
end

function Game:destroyDeadTablets()
  deadTablets = {}
  a = 1
  for _, member in ipairs(self.teamBlue) do
    if member.isDead then
      table.insert(deadTablets, a)
    end
    a = a + 1
  end
  deadRemoved = 0
  for _, i in ipairs(deadTablets) do
    table.remove(self.teamBlue, i-deadRemoved)
    deadRemoved = deadRemoved + 1
  end
  deadTablets = {}
  a = 1
  for _, member in ipairs(self.teamRed) do
    if member.isDead then
      table.insert(deadTablets, a)
    end
    a = a+1
  end
  deadRemoved = 0
  for _, i in ipairs(deadTablets) do
    table.remove(self.teamRed, i-deadRemoved)
    deadRemoved = deadRemoved + 1
  end
end

function Game:checkHealth()
  if self.teamRed then
    if self.maxhp <= 0 then
      isDead = true
        print('lmao')
    end
  end
end

function Game:receiveDamage(damage)
  self.hp = math.max(self.hp - damage, 0)
  print('hp: '..tostring(self.hp)..'/'..tostring(self.maxhp))
end

--team Red is the player, when the player lost the battle 
--receive damage(minus HP)
function Game:checkResult()
  if #self.teamBlue == 0 then
    return 'red'
  elseif #self.teamRed == 0 then
    return 'blue'
  else
  end

  -- if #self.teamBlue == 0 then 
  --   print("Team Blue has been defeated")
  -- elseif #self.teamBlue ~= 0 then
  --   print("Victory")
  -- end
  -- if #self.teamRed == 0 then
  --   self.receiveDamage(5) 
  --   print("Team Red has been defeated")
  -- elseif #self.teamRed ~= 0 then
  --   print("Defeat")
  -- end
end

function Game:onTabletDie(tablet)
  local winner = self:checkResult()
  if winner == 'red' then
    print('win')
  elseif winner == 'blue' then
    print('lost')
    self:receiveDamage(5)
  end
end

return Game
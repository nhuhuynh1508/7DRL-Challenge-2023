local Tablet = require 'src.tablets.tablet'
local Field = require 'src.playfield.field'
local Warrior = require 'src.tablets.warrior'

local Game = {}

function Game:enter()
  --Global variable
  theme_color = {219,161,89}
  isFighting = false
    --Battlefield relating variable
    cellSize = 60
    spacing = 10
    fieldOffset = {(400 - 5*cellSize - 4*spacing)/2, (600 - 6*cellSize - 5*spacing)/2}
  
  --Self variable
  self.teamBlue = {}
  self.teamRed = {}

  self:setup()
end

function Game:setup()
  field = Field()
  blue = {0,0,255}
  red ={255,0,0}
  table.insert(self.teamBlue, Tablet(0, 0, 1, blue))
  table.insert(self.teamBlue, Tablet(1, 1, 1, blue))
  table.insert(self.teamBlue, Tablet(2, 2, 1, blue))
  table.insert(self.teamRed, Tablet(2, 5, 1, red))
  table.insert(self.teamRed, Tablet(4, 5, 1, red))
  table.insert(self.teamRed, Warrior(0, 5, 1, red))

  for _, member in ipairs(self.teamBlue) do
    member:setup(self.teamBlue,self.teamRed)
  end
  for _, member in ipairs(self.teamRed) do
    member:setup(self.teamRed,self.teamBlue)
  end
end

function Game:update(dt)
  --Remove dead tablets
  self:destroyDeadTablets()

  --Update tablets
  for _, member in ipairs(self.teamBlue) do
    member:update(dt)
  end
  for _, member in ipairs(self.teamRed) do
    member:update(dt)
  end
end

function Game:draw()
  --Theme color: kaki
  love.graphics.setColor(love.math.colorFromBytes(theme_color))

  love.graphics.rectangle('line', 10, 750, 580, 20)
  love.graphics.line(290, 750, 290, 770)

--slots for tablets
  love.graphics.rectangle('line', 0, 600, 600, 80)
  love.graphics.line(120, 600, 120, 680)
  love.graphics.line(240, 600, 240, 680)
  love.graphics.line(360, 600, 360, 680)
  love.graphics.line(480, 600, 480, 680)

  --battlefield
  field:draw()

  ---draw tablets
  for _, member in ipairs(self.teamBlue) do
    member:draw()
  end
  for _, member in ipairs(self.teamRed) do
    member:draw()
  end
end

function Game:keypressed(key)
  for _, member in ipairs(self.teamBlue) do
    member:keypressed(key)
  end
  for _, enemy in ipairs(self.teamRed) do
    member:keypressed(key)
  end
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

return Game
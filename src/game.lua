local Tablet = require 'src.tablets.tablet'
local Field = require 'src.playfield.field'

local Game = {}

function Game:enter()
  --Global variable
  theme_color = {219,161,89}
  isFighting = false
    --Battlefield relating variable
    cellSize = 60
    spacing = 10
    fieldOffset = {(400 - 5*cellSize - 4*spacing)/2, (600 - 6*cellSize - 5*spacing)/2}
    print("Field offset", fieldOffset[1], fieldOffset[2])
  --Self variable
  self.allies = {}
  self.enemies = {}

  self:setup()
end

function Game:setup()
  battlefield = Field()
  blue = {0,0,255}
  red ={255,0,0}
  table.insert(self.enemies, Tablet(0, 0, 10, 0.2, 100, blue))
  -- table.insert(self.enemies, Tablet(1, 1, 10, 0.2, 100, blue))
  -- table.insert(self.enemies, Tablet(2, 2, 5, 0.2, 100, blue))
  table.insert(self.allies, Tablet(4, 5, 4, 0.2, 200, red))
  table.insert(self.allies, Tablet(2, 5, 4, 0.2, 200, red))

  for _, ally in ipairs(self.allies) do
    ally:setup(self.allies,self.enemies)
  end
  for _, enemy in ipairs(self.enemies) do
    enemy:setup(self.enemies,self.allies)
  end
end

function Game:update(dt)
  for _, ally in ipairs(self.allies) do
    ally:update(dt)
  end
  for _, enemy in ipairs(self.enemies) do
    enemy:update(dt)
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
  battlefield:draw()

  ---draw tablets
  for _, ally in ipairs(self.allies) do
    ally:draw()
  end
  for _, enemy in ipairs(self.enemies) do
    enemy:draw()
  end
end

function Game:keypressed(key)
  for _, ally in ipairs(self.allies) do
    ally:keypressed(key)
  end
  for _, enemy in ipairs(self.enemies) do
    enemy:keypressed(key)
  end
end

return Game
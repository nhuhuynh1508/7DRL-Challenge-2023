local Tablet = require 'src.tablets.tablet'
local Field = require 'src.playfield.field'

local Game = {}

function Game:enter()
  self.theme_color = {219,161,89}
  self.isFighting = false
  self.cellSize = 60
  self.allies = {}
  self.enemies = {}

  self:setup()
end

function Game:setup()
  battlefield = Field(self.cellSize,10)
  blue = {0,0,255}
  red ={255,0,0}
  table.insert(self.allies, Tablet(100, 100, "archer", 10, 0.5, 100, blue, self.cellSize))
  table.insert(self.allies, Tablet(300, 100, "archer", 10, 0.5, 100, blue, self.cellSize))
  table.insert(self.enemies, Tablet(100, 300, "archer", 10, 0.7, 200, red, self.cellSize))

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
---UI for health, money, and slots
-- function Game:load()
--   heart = love.graphics.newImage('assets/heart.png')
-- end

  --Theme color: kaki
  love.graphics.setColor(love.math.colorFromBytes(self.theme_color))

  love.graphics.rectangle('line', 10, 750, 580, 20)
  love.graphics.line(290, 750, 290, 770)

--slots for tablets
  love.graphics.rectangle('line', 0, 600, 600, 80)
  love.graphics.line(120, 600, 120, 680)
  love.graphics.line(240, 600, 240, 680)
  love.graphics.line(360, 600, 360, 680)
  love.graphics.line(480, 600, 480, 680)

  --battlefield
  battlefield:draw(self.theme_color, self.isFighting)

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
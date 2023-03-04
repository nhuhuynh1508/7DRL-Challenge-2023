local Tablet = require 'src.tablets.tablet'
local Field = require 'src.playfield.field'
local Map = require 'src.map'
local HUD = require 'src.hud.hud'

local Game = {}

function Game:enter()
  self.theme_color = {219,161,89}
  self.isFighting = false
  self.cellSize = 60
  self.allies = {}
  self.enemies = {}

  self.map = Map()
  self.hud = HUD()

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

  self.map:update(dt)
  self.hud:update(dt)
end

function Game:draw()
  love.graphics.setColor(1, 1, 1)
  love.graphics.draw(Sprites.base, 0, 0, 0, 2, 2)

  --battlefield
  battlefield:draw(self.theme_color, self.isFighting)

  ---draw tablets
  for _, ally in ipairs(self.allies) do
    ally:draw()
  end
  for _, enemy in ipairs(self.enemies) do
    enemy:draw()
  end
  

  self.map:draw()
  self.hud:draw()
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
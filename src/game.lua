local Tablet = require 'src.tablets.tablet'

local Game = {}

function Game:enter()
  self.allies = {}
  self.enemies = {}

  self:setup()
end

function Game:setup()
  table.insert(self.allies, Tablet(100, 100, "blue", "archer", 10, 1, 978))
  table.insert(self.enemies, Tablet(100, 300, "blue", "archer", 10, 1, 978))
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
  for _, ally in ipairs(self.allies) do
    ally:draw()
  end
  for _, enemy in ipairs(self.enemies) do
    enemy:draw()
  end
end

return Game
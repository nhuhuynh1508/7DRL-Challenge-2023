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

---UI for health, money, and slots
-- function Game:load()
--   heart = love.graphics.newImage('assets/heart.png')
-- end

function Game:draw()
  love.graphics.rectangle('line', 10, 750, 580, 20)
  love.graphics.line(290, 750, 290, 770)

--slots for tablets
  love.graphics.rectangle('line', 0, 600, 600, 80)
  love.graphics.line(120, 600, 120, 680)
  love.graphics.line(240, 600, 240, 680)
  love.graphics.line(360, 600, 360, 680)
  love.graphics.line(480, 600, 480, 680)

end

return Game
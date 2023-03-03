local Tablet = require 'src/tablets/tablet'

local Game = {}

function Game:enter()
  self.tablet1 = Tablet(100,100,"blue","archer", 10, 1, 978)
  -- self.tablet2 = Tablet(100,100,"blue", 10, 1, 278)
end

function Game:update(dt)
  self.tablet1:update(dt)
  -- self.tablet2:update(dt)
end

function Game:draw()
  self.tablet1:draw()
  -- self.tablet2:draw()
end

return Game
local Tablet = require 'src/tablets/tablet'

local Game = {}

function Game:enter()
  self.tablet = Tablet()
end

function Game:update(dt)
  self.tablet:update(dt)
end

function Game:draw()
  self.tablet:draw()
end

return Game
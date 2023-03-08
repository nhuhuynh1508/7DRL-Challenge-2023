local Manager = require 'src.manager'
local BenchSlot = require 'src.hud.benchSlot'

local HUD = Class('HUD')

function HUD:initialize()
  self.cellSize = 60
  self.spacing = 10

  self.benchSlots = Manager()
  local y = 538 + (self.cellSize + self.spacing)
  for gx = 0, 4 do
    local x = (400 - 5 * self.cellSize - 4 * self.spacing)/2 + 24 + gx * (self.cellSize + self.spacing)
    self.benchSlots:add(BenchSlot(x, y))
  end
end

function HUD:update(dt)

end

function HUD:draw()
  ---UI for health, money, and slots

  
  

  --Theme color: kaki
  -- love.graphics.setColor(love.math.colorFromBytes({219,161,89}))

  -- love.graphics.rectangle('line', 10, 750, 580, 20)
  -- love.graphics.line(290, 750, 290, 770)

--slots for tablets
  -- love.graphics.rectangle('line', 0, 600, 600, 80)
  -- love.graphics.line(120, 600, 120, 680)
  -- love.graphics.line(240, 600, 240, 680)
  -- love.graphics.line(360, 600, 360, 680)
  -- love.graphics.line(480, 600, 480, 680)

  self.benchSlots:draw()
end

return HUD
local Manager = require 'src.manager'
local FieldSlot = require 'src.playfield.fieldSlot'

local Field = Class('Field')

function Field:initialize()
  --Global variable in game.lua (cellSize, spacing)
  self.rate = 0.7
  self.fieldSlots = Manager()
  for gx = 1, 3 do
    for gy = 1, 3
     do
      local x = fieldOffset[1] + 28 + gx * (cellSize + spacing)
      local y = fieldOffset[2] + 180 + gy * (cellSize + spacing)
      
      self.fieldSlots:add(FieldSlot(x, y))
    end
  end
end

function Field:draw()
  
  --draw the battlefield
  love.graphics.rectangle("fill", 0, 0, 400, 600)
  
  for i = 0,4 do
    for j = 0,5 do
      love.graphics.setColor(love.math.colorFromBytes(239, 171, 109, 70))
      love.graphics.rectangle("fill", fieldOffset[1] + i*(cellSize + spacing), fieldOffset[2] + j*(cellSize + spacing), cellSize, cellSize)

      if (isFighting == false) and (j>2) then
        love.graphics.setColor(love.math.colorFromBytes(theme_color[1]*self.rate*0.5,theme_color[2]*self.rate*0.5,theme_color[3]*self.rate*0.5))
      else 
        love.graphics.setColor(love.math.colorFromBytes(theme_color[1]*self.rate,theme_color[2]*self.rate,theme_color[3]*self.rate))
      end
      love.graphics.rectangle("line", fieldOffset[1] + i*(cellSize + spacing), fieldOffset[2] + j*(cellSize + spacing), cellSize, cellSize)
    end
  end

  -- set back to default
  love.graphics.setColor(love.math.colorFromBytes(219, 161, 89))

  -- self.fieldSlots:draw()
end

return Field
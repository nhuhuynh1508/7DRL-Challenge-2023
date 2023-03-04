local HUD = Class('HUD')

function HUD:initialize()

end

function HUD:update(dt)

end

function HUD:draw()
  ---UI for health, money, and slots
-- function Game:load()
--   heart = love.graphics.newImage('assets/heart.png')
-- end

  --Theme color: kaki
  love.graphics.setColor(love.math.colorFromBytes({219,161,89}))

  love.graphics.rectangle('line', 10, 750, 580, 20)
  love.graphics.line(290, 750, 290, 770)

--slots for tablets
  love.graphics.rectangle('line', 0, 600, 600, 80)
  love.graphics.line(120, 600, 120, 680)
  love.graphics.line(240, 600, 240, 680)
  love.graphics.line(360, 600, 360, 680)
  love.graphics.line(480, 600, 480, 680)
end

return HUD
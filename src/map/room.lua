local Room = Class('Room')

local colors = {
  enemy = {0.8, 0.8, 0.8},
  shop = {0.4, 0.55, 1},
  coin = {0.84, 0.84, 0.5},
  health = {0.9, 0.55, 0.55},
}

function Room:initialize(x, y, type)
  self.x, self.y = x, y
  self.type = type
end

function Room:update(dt)

end

function Room:draw()
  love.graphics.setColor(colors[self.type])
  love.graphics.rectangle('fill', self.x, self.y, 25, 25)
end

function Room:mousepressed(x, y)
  
end

function Room:mousemoved(x, y)

end

return Room
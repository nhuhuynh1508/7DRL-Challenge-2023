local Room = Class('Room')

local colors = {
  enemy = {0.8, 0.8, 0.8},
  shop = {0.4, 0.55, 1},
  coin = {0.84, 0.84, 0.5},
  health = {0.9, 0.55, 0.55},
}

local size = 25

function Room:initialize(map, roomIndex, floor, type)
  self.map = map
  self.roomIndex, self.floor = roomIndex, floor
  self.x, self.y = 400 + 45 * roomIndex, 760 - 45 * floor
  self.type = type
end

function Room:update(dt)

end

function Room:draw()
  love.graphics.setColor(colors[self.type])
  love.graphics.rectangle('fill', self.x, self.y, size, size)
end

function Room:mousepressed(x, y)
  if self.x < x and x < self.x + size and
      self.y < y and y < self.y + size then
    self.map:onRoomPressed(self)
  end
end

function Room:mousemoved(x, y)

end

return Room
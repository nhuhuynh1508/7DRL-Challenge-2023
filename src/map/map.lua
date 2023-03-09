local Room = require 'src.map.room'

local Map = Class('Map')

local shopsPerMap = 3
local shopStddev = 1

local baseCoinChance = 0.135
local growthCoinChance = 0.0135
local maxRoomsWithoutCoin = 7

local baseHealthChance = 0.06
local growthHealthChance = 0.006
local maxRoomsWithoutHealth = 15

function Map:initialize(floors)
  self.map = {}
  self.currentFloor = 1

  -- Generate map
  local coinChance = baseCoinChance
  local roomsWithoutCoin = 0
  local healthChance = baseHealthChance
  local roomsWithoutHealth = 0

  for f = 1, floors or 20 do
    self.map[f] = {}
    for i = 1, 3 do
      local n = math.random()
      
      if roomsWithoutCoin >= maxRoomsWithoutCoin then
        self.map[f][i] = Room(self, i, f, 'coin')
        coinChance = baseCoinChance
        roomsWithoutCoin = 0
        healthChance = healthChance + growthHealthChance
        roomsWithoutHealth = roomsWithoutHealth + 1
      
      elseif roomsWithoutHealth >= maxRoomsWithoutHealth then
        self.map[f][i] = Room(self, i, f, 'health')
        coinChance = coinChance + growthCoinChance
        roomsWithoutCoin = roomsWithoutCoin + 1
        healthChance = baseHealthChance
        roomsWithoutHealth = 0

      else
        if n < coinChance then
          self.map[f][i] = Room(self, i, f, 'coin')
          coinChance = baseCoinChance
          roomsWithoutCoin = 0
          healthChance = healthChance + growthHealthChance
          roomsWithoutHealth = roomsWithoutHealth + 1

        elseif n < coinChance + healthChance then
          self.map[f][i] = Room(self, i, f, 'health')
          coinChance = coinChance + growthCoinChance
          roomsWithoutCoin = roomsWithoutCoin + 1
          healthChance = baseHealthChance
          roomsWithoutHealth = 0

        else
          self.map[f][i] = Room(self, i, f, 'enemy')
          coinChance = coinChance + growthCoinChance
          roomsWithoutCoin = roomsWithoutCoin + 1
          healthChance = healthChance + growthHealthChance
          roomsWithoutHealth = roomsWithoutHealth + 1

        end
      end
    end
  end

  for i = 1, shopsPerMap do
    local floorIndex = floors / shopsPerMap * i
    floorIndex = love.math.randomNormal(shopStddev, floorIndex)
    floorIndex = math.floor(floorIndex)
    if floorIndex < 1 then floorIndex = 1
    elseif floorIndex > floors then floorIndex = floors
    end

    local rIndex = math.random(1, 3)
    local oldRoom = self.map[floorIndex][rIndex]
    self.map[floorIndex][rIndex] = Room(self, oldRoom.roomIndex, oldRoom.floor, 'shop')
  end

  self.selectedRoom = self.map[1][1]
end

function Map:onRoomPressed(room)
  if room.floor - self.currentFloor == 1 and
      math.abs(room.roomIndex - self.selectedRoom.roomIndex) <= 1 then
    self.selectedRoom = room
    self.currentFloor = self.selectedRoom.floor
  end
end

function Map:update(dt)

end

function Map:draw()
  for floor = 1, #self.map do
    for i = 1, 3 do
      self.map[floor][i]:draw()
    end
  end

  love.graphics.setColor(1, 1, 1)
  love.graphics.rectangle('line', self.selectedRoom.x - 2, self.selectedRoom.y - 2, 29, 29)
end

function Map:mousepressed(x, y)
  for floor = 1, #self.map do
    for i = 1, 3 do
      self.map[floor][i]:mousepressed(x, y)
    end
  end
end

function Map:mousemoved(x, y)
  for floor = 1, #self.map do
    for i = 1, 3 do
      self.map[floor][i]:mousemoved(x, y)
    end
  end
end

return Map
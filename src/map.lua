local Map = Class('Map')

local shopsPerMap = 3
local shopStddev = 1

local baseCoinChance = 0.15
local growthCoinChance = 0.015
local maxRoomsWithoutCoin = 6

local baseHealthChance = 0.06
local growthHealthChance = 0.006
local maxRoomsWithoutHealth = 15

local colors = {
  enemy = {0.8, 0.8, 0.8},
  shop = {0.4, 0.55, 1},
  coin = {0.84, 0.84, 0.5},
  health = {0.9, 0.55, 0.55},
}

function Map:initialize(floors)
  self.map = {}
  self.floorIndex = 1

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
        self.map[f][i] = {
          type = 'coin',
        }
        coinChance = baseCoinChance
        roomsWithoutCoin = 0
        healthChance = healthChance + growthHealthChance
        roomsWithoutHealth = roomsWithoutHealth + 1
      
      elseif roomsWithoutHealth >= maxRoomsWithoutHealth then
        self.map[f][i] = {
          type = 'health',
        }
        coinChance = coinChance + growthCoinChance
        roomsWithoutCoin = roomsWithoutCoin + 1
        healthChance = baseHealthChance
        roomsWithoutHealth = 0

      else
        if n < coinChance then
          self.map[f][i] = {
            type = 'coin',
          }
          coinChance = baseCoinChance
          roomsWithoutCoin = 0
          healthChance = healthChance + growthHealthChance
          roomsWithoutHealth = roomsWithoutHealth + 1

        elseif n < coinChance + healthChance then
          self.map[f][i] = {
            type = 'health',
          }
          coinChance = coinChance + growthCoinChance
          roomsWithoutCoin = roomsWithoutCoin + 1
          healthChance = baseHealthChance
          roomsWithoutHealth = 0

        else
          self.map[f][i] = {
            type = 'enemy',
          }
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

    self.map[floorIndex][math.random(1, 3)] = {
      type = 'shop'
    }
  end
end

function Map:update(dt)

end

function Map:draw()
  for floor = 1, #self.map do
    local y = 800 - 45 * floor
    for i = 1, 3 do
      local x = 400 + 45 * i
      love.graphics.setColor(colors[self.map[floor][i].type])
      
      love.graphics.rectangle('fill', x, y, 25, 25)
      
    end
  end
end

return Map
local Manager = Class('Manager')

function Manager:initialize()
  self.entities = {}
end

function Manager:add(entity)
  table.insert(self.entities, entity)
end

function Manager:remove(entity)
  for i, entity_ in ipairs(self.entities) do
    if entity == entity_ then
      table.remove(entity, i)
      return true
    end
  end
  return false
end

function Manager:update(dt)
  for _, entity in ipairs(self.entities) do
    entity:update(dt)
  end
end

function Manager:draw()
  for _, entity in ipairs(self.entities) do
    entity:draw()
  end
end

function Manager:mousepressed(x, y, button)
  for _, entity in ipairs(self.entities) do
    entity:mousepressed(x, y, button)
  end
end

function Manager:mousemoved(x, y)
  for _, entity in ipairs(self.entities) do
    entity:mousemoved(x, y)
  end
end

function Manager:mousereleased(x, y, button)
  for _, entity in ipairs(self.entities) do
    entity:mousereleased(x, y, button)
  end
end

function Manager:keypressed(key, scancode, isRepeat)
  for _, entity in ipairs(self.entities) do
    entity:keypressed(key, scancode, isRepeat)
  end
end

function Manager:keyreleased(key, scancode, isRepeat)
  for _, entity in ipairs(self.entities) do
    entity:keyreleased(key, scancode, isRepeat)
  end
end

return Manager
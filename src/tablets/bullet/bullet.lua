local Bullet = Class("Bullet")

function Bullet:initialize(ori_x, ori_y, des_x, des_y)
  self.speed = 0.02
  self.ori_x, self.ori_y = ori_x, ori_y
  self.des_x, self.des_y = des_x, des_y
  self.x = self.ori_x
  self.y = self.ori_y
  self.isArrived = false
end

function Bullet:draw(color)
  self.x = self.x + (self.des_x-self.ori_x)*self.speed
  self.y = self.y + (self.des_y-self.ori_y)*self.speed
  love.graphics.setColor(love.math.colorFromBytes(color))
  love.graphics.circle('fill',self.x,self.y,3)
  love.graphics.setColor(1,1,1)
  self:checkArrived()
end

function Bullet:checkArrived()
  local x = self.x - self.des_x
  local y = self.y -self.des_y
  self.isArrived = (math.sqrt(x^2 + y^2) < cellSize/3)
end

return Bullet
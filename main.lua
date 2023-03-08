require 'globals'
require 'assets'

Game = require 'src.game'

function love.load()
  Gamestate.registerEvents()
  Gamestate.switch(Game)
end

function love.update(dt)

end

function love.draw()
  
end
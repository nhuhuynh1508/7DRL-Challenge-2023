local lg = love.graphics
local li = love.image

love.graphics.setDefaultFilter('nearest', 'nearest')

Sprites = {
    heart = {
      lg.newImage('assets/heart.png'),
    },
    base = lg.newImage('assets/base.png'),
    benchSlot = lg.newImage('assets/benchSlot.png'),
    coin = lg.newImage('assets/coin.png'),
    fieldSlot = lg.newImage('assets/fieldSlot.png'),
}
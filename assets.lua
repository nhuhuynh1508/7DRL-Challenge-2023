local lg = love.graphics
local li = love.image

love.graphics.setDefaultFilter('nearest', 'nearest')

Sprites = {
  heart = lg.newImage('assets/heart.png'),
  base = lg.newImage('assets/base.png'),
  benchSlot = lg.newImage('assets/benchSlot.png'),
  coin = lg.newImage('assets/coin.png'),
  fieldSlot = lg.newImage('assets/fieldSlot.png'),

  tablets = {
    warrior = lg.newImage('assets/tablets/warrior.png'),
    knight = lg.newImage('assets/tablets/knight.png'),
    archer = lg.newImage('assets/tablets/archer.png'),
    mage = lg.newImage('assets/tablets/mage.png'),
    rogue = lg.newImage('assets/tablets/rogue.png'),

    berserker = lg.newImage('assets/tablets/berserker.png'),
    templar = lg.newImage('assets/tablets/templar.png'),
    ranger = lg.newImage('assets/tablets/ranger.png'),
    priest = lg.newImage('assets/tablets/priest.png'),
    vampire = lg.newImage('assets/tablets/assassin.png'),

    assassin = lg.newImage('assets/tablets/assassin.png'),
    colossus = lg.newImage('assets/tablets/colossus.png'),
    wizard = lg.newImage('assets/tablets/wizard.png'),
  },
}
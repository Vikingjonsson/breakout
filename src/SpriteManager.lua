local Class = require 'lib.hump.class'

local SPRITE_PATH = 'assets/sprites/'
local COLORS = {
  'blue',
  'green',
  'red',
  'purple',
  'yello',
  'grey',
  'orange'
}

--- @class SpriteManager
local SpriteManager = Class {}

--- State construtor
function SpriteManager:init()
  self.images = {
    background = love.graphics.newImage(SPRITE_PATH .. 'background.png'),
    breakout = love.graphics.newImage(SPRITE_PATH .. 'breakout.png'),
    arrows = love.graphics.newImage(SPRITE_PATH .. 'arrows.png'),
    hearts = love.graphics.newImage(SPRITE_PATH .. 'hearts.png'),
    particle = love.graphics.newImage(SPRITE_PATH .. 'particle.png')
  }
end

--- Generate quads
--- @param image table
--- @param sprite_width number
--- @param sprite_height number
function SpriteManager:generate_quads(image, sprite_width, sprite_height)
  local quads = {}
  local rows = image:getWidth() / sprite_width
  local columns = image:getHeight() / sprite_height

  for y = 0, columns - 1 do
    for x = 0, rows - 1 do
      table.insert(
        quads,
        love.graphics.newQuad(x, y, sprite_width, sprite_height, image:getDimensions())
      )
    end
  end

  return quads
end

--- Get sprite from image
--- @param image any SpriteManage.images
--- @return table[] list of quads
function SpriteManager:generate_ball_quads(image)
  local quads = {}
  local h, w = 8, 8

  -- first row
  local x, y = 96, 48
  for i = 1, 4, 1 do
    quads[COLORS[i]] = love.graphics.newQuad(x, y, w, h, image:getDimensions())
    x = x + w
  end

  -- second row
  local x2, y2 = 96, 56
  for i = 5, 7, 1 do
    quads[COLORS[i]] = love.graphics.newQuad(x2, y2, w, h, image:getDimensions())
    x2 = x2 + w
  end

  return quads
end

--- Get sprite from image
--- @param image any SpriteManage.images
--- @return table[] list of quads small, medium, large, huge
function SpriteManager:generate_paddle_quads(image)
  local x, y, h = 0, 64, 16
  local quads = {}

  for i = 1, 4, 1 do
    quads[COLORS[i] .. '_small'] = love.graphics.newQuad(x, y, 32, h, image:getDimensions())
    quads[COLORS[i] .. '_medium'] = love.graphics.newQuad(x + 32, y, 64, h, image:getDimensions())
    quads[COLORS[i] .. '_large'] = love.graphics.newQuad(x + 96, y, 96, h, image:getDimensions())
    quads[COLORS[i] .. '_huge'] = love.graphics.newQuad(x, y + 16, 128, h, image:getDimensions())
    y = y + 32
  end

  return quads
end

--- @type SpriteManager
local instance = SpriteManager()
return instance

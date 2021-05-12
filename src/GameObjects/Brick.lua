local Class = require 'lib.hump.class'

local SPRITE_SHEET = SPRITE_MANAGER.images.breakout
local BRICK_WIDTH, BRICK_HEIGHT = 32, 16
local QUADS = SPRITE_MANAGER:generate_quads(SPRITE_SHEET, BRICK_WIDTH, BRICK_HEIGHT)
local brick_quads = table.slice(QUADS, 1, 21)

--- @class Brick
local Brick = Class {}

function Brick:init(x, y)
  self.current_quad = brick_quads[1]
  local _, _, quad_width, quad_height = self.current_quad:getViewport()

  self.x = x
  self.y = y
  self.w = quad_width
  self.h = quad_height

  self.is_active = true
end

function Brick:hit()
  local track = math.random(1, 2)
  SOUND_MANAGER:play_sound(SOUND_MANAGER.sounds['brick_hit_' .. track])
  self.is_active = false
end

--- Set Brick positon
--- @param x number
--- @param y number
function Brick:set_position(x, y)
  self.x = x
  self.y = y
end

function Brick:update(dt)
end

function Brick:draw()
  if self.is_active then
    love.graphics.draw(SPRITE_SHEET, self.current_quad, self.x, self.y)
  end

  DEBUG.draw_hit_box(self)
end

return Brick

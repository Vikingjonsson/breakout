local Class = require 'lib.hump.class'
local SpriteManager = require 'src.SpriteManager'
local SoundManager = require 'src.SoundManager'
local keyboard = require 'src.keyboard'
local constants = require 'src.constants'

local SPEED = 500
local MAX_SPEED = 1000
local SPRITE_SHEET = SpriteManager.images.breakout
local quads = SpriteManager:generate_ball_quads(SPRITE_SHEET)

--- @class Ball
local Ball = Class {}

--- Ball constructor
--- @param x number
--- @param y number
--- @param skin ?string optional defaults to 'blue'
function Ball:init(x, y, skin)
  self.skin = quads[skin] and skin or 'blue'
  self.current_quad = quads[self.skin]
  local _, _, quad_width, quad_height = self.current_quad:getViewport()

  self.w = quad_width
  self.h = quad_height
  self.x = x
  self.y = y
  self.last_set_x = x
  self.last_set_y = y

  self.is_fired = false
  self.dx = math.random(-200, 200)
  self.dy = math.random(-50, -60)
end

--- Set ball positon
--- @param x number
--- @param y number
function Ball:set_position(x, y)
  self.x = x
  self.y = y
  self.reset_x = x
  self.rest_y = y
end

--- Reset ball to last set position
--- @param x ?number
--- @param y ?number
function Ball:reset(x, y)
  self.is_fired = false
  self.dx = math.random(-200, 200)
  self.dy = math.random(-50, -60)

  if x and y then
    Ball:set_position(x, y)
  else
    Ball:set_position(self.last_set_x, self.last_set_y)
  end
end

function Ball:update(dt)
  if self.is_fired then
    self.y = self.y + self.dy * dt
    self.x = self.x + self.dx * dt
  end

  if self.x <= 0 then
    self.x = 0
    self.dx = -self.dx
    SoundManager:play_sound(SoundManager.sounds.wall_hit)
  end

  if self.x >= constants.VIRTUAL_WIDTH - self.w then
    self.x = constants.VIRTUAL_WIDTH - self.w
    self.dx = -self.dx
    SoundManager:play_sound(SoundManager.sounds.wall_hit)
  end

  if self.y <= 0 then
    self.y = 0
    self.dy = -self.dy
    SoundManager:play_sound(SoundManager.sounds.wall_hit)
  end

  if self.y >= constants.VIRTUAL_HEIGHT then
    self:reset()
    SoundManager:play_sound(SoundManager.sounds.hurt)
  end
end

function Ball:draw()
  love.graphics.draw(SPRITE_SHEET, self.current_quad, self.x, self.y)
  DEBUG.draw_hit_box(self)
end

return Ball

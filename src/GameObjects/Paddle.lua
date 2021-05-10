local Class = require 'lib.hump.class'
local SpriteManager = require 'src.SpriteManager'
local constants = require 'src.constants'
local keyboard = require 'src.keyboard'
local context = require 'src.StateMachine.states.PlayState.context'

local SPEED = 200
local SPRITE_SHEET = SpriteManager.images.breakout

local quads = SpriteManager:generate_paddle_quads(SPRITE_SHEET)

---@class Paddle
local Paddle = Class {}

function Paddle:init()
  self.current_quad = quads.blue_medium
  local _, _, quad_width, quad_height = self.current_quad:getViewport()

  self.x = (constants.VIRTUAL_WIDTH / 2) - (quad_width / 2)
  self.y = constants.VIRTUAL_HEIGHT - (quad_height * 2)
  self.w = quad_width
  self.h = quad_height
  self.dx = 0
end

local function calc_new_delta_positon(dt)
  if love.keyboard.isDown(keyboard.KEYS.LEFT) then
    return -SPEED * dt
  elseif love.keyboard.isDown(keyboard.KEYS.RIGHT) then
    return SPEED * dt
  else
    return 0
  end

  if keyboard.was_key_pressed(keyboard.KEYS.RETURN) then
    context.signal:emit(context.events.FIRE)
  end
end

local function calc_new_position(x, dx, width)
  local MAX_POS_X = constants.VIRTUAL_WIDTH - width
  local new_positon = x + dx
  return dx < 0 and math.max(0, new_positon) or math.min(MAX_POS_X, new_positon)
end

function Paddle:update(dt)
  self.dx = calc_new_delta_positon(dt)
  self.x = calc_new_position(self.x, self.dx, self.w)
end

function Paddle:draw()
  love.graphics.draw(SPRITE_SHEET, self.current_quad, self.x, self.y)
  DEBUG.draw_hit_box(self)
end

return Paddle

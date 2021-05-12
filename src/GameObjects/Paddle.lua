local Class = require 'lib.hump.class'
local constants = require 'src.constants'

local SPEED = 200
local SPRITE_SHEET = SPRITE_MANAGER.images.breakout
local quads = SPRITE_MANAGER:generate_paddle_quads(SPRITE_SHEET)

--- @class Paddle
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
  if love.keyboard.isDown(KEYBOARD.KEYS.LEFT) then
    return -SPEED * dt
  end

  if love.keyboard.isDown(KEYBOARD.KEYS.RIGHT) then
    return SPEED * dt
  end

  return 0
end

local function calc_new_position(x, dx, width)
  local MAX_POS_X = constants.VIRTUAL_WIDTH - width
  local new_positon = x + dx

  return dx < 0 and math.max(0, new_positon) or math.min(MAX_POS_X, new_positon)
end

--- Update Paddle
--- @param dt number
function Paddle:update(dt)
  self.dx = calc_new_delta_positon(dt)
  self.x = calc_new_position(self.x, self.dx, self.w)

  if KEYBOARD.was_key_pressed(KEYBOARD.KEYS.RETURN) then
    GAME_STATE.signal:emit(GAME_STATE.EVENTS.FIRE)
  end
end

function Paddle:draw()
  love.graphics.draw(SPRITE_SHEET, self.current_quad, self.x, self.y)

  DEBUG.draw_hit_box(self)
end

return Paddle

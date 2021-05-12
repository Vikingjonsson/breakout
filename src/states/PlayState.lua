local Class = require 'lib.hump.class'
local collision = require 'src.collision'
local keyboard = require 'src.keyboard'
local BaseState = require 'src.states.BaseState'
local Paddle = require 'src.GameObjects.Paddle'
local Ball = require 'src.GameObjects.Ball'
local Brick = require 'src.GameObjects.Brick'

--- @class PlayState
local PlayState = Class {__includes = BaseState}

function PlayState:init()
  self.paddle = Paddle() --- @type Paddle
  self.ball = Ball(0, 0) --- @type Ball
  self.brick = Brick(100, 100) --- @type Brick

  local initial_ball_x = self.paddle.x + self.paddle.w / 2 - self.ball.w / 2
  local initial_ball_y = self.paddle.y - self.ball.h * 2
  self.ball:set_position(initial_ball_x, initial_ball_y)

  GAME_STATE.on_fire(
    function()
      self.ball.is_fired = true
    end
  )
end

function PlayState:enter()
end

function PlayState:exit()
end

function PlayState:update(dt)
  if keyboard.was_key_pressed(KEYBOARD.KEYS.ESCAPE) then
    GAME_STATE.machine:change(GAME_STATE.STATES.START)
  end

  self.paddle:update(dt)
  self.ball:update(dt)

  if collision.check_collision_AABB(self.ball, self.paddle) then
    self.ball.dy = -self.ball.dy
    self.ball.y = self.ball.y - self.ball.h / 2
    SOUND_MANAGER:play_sound(SOUND_MANAGER.sounds.paddle_hit)
  end

  if collision.check_collision_AABB(self.ball, self.brick) then
    self.ball.dy = -self.ball.dy
    self.ball.y = self.ball.y - self.ball.h / 2
    SOUND_MANAGER:play_sound(SOUND_MANAGER.sounds.brick_hit_1)
  end

  if not self.ball.is_fired then
    local ball_x = self.paddle.x + self.paddle.w / 2 - self.ball.w / 2
    local ball_y = self.paddle.y - self.ball.h * 2
    self.ball:set_position(ball_x, ball_y)
  end
end

function PlayState:draw()
  self.paddle:draw()
  self.ball:draw()
  self.brick:draw()
end

return PlayState

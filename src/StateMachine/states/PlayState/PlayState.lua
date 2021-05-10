local Class = require 'lib.hump.class'
local SoundManager = require 'src.SoundManager'
local collision = require 'src.collision'
local Paddle = require 'src.GameObjects.Paddle'
local Ball = require 'src.GameObjects.Ball'
local Brick = require 'src.GameObjects.Brick'

local BaseState = require 'src.StateMachine.states.BaseState'
local context = require 'src.StateMachine.states.PlayState.context'

--- @class PlayState
local PlayState = Class {__includes = BaseState}

function PlayState:init()
  self.paddle = Paddle() --- @type Paddle
  self.ball = Ball(0, 0) --- @type Ball
  self.brick = Brick(100, 100) --- @type Brick

  local initial_ball_x = self.paddle.x + self.paddle.w / 2 - self.ball.w / 2
  local initial_ball_y = self.paddle.y - self.ball.h * 2
  self.ball:set_position(initial_ball_x, initial_ball_y)

  context.on_fire(
    function()
      self.ball.is_fired = true
    end
  )
end

--- @param state_machine StateMachine
function PlayState:enter(state_machine)
  self.machine = state_machine
end

function PlayState:exit()
end

function PlayState:update(dt)
  self.paddle:update(dt)
  self.ball:update(dt)

  if collision.check_collision_AABB(self.ball, self.paddle) then
    self.ball.dy = -self.ball.dy
    SoundManager:play_sound(SoundManager.sounds.paddle_hit)
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

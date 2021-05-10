local Class = require 'lib.hump.class'
local BaseState = require 'src.StateMachine.states.BaseState'
local keyboard = require 'src.keyboard'
local text = require 'src.text'
local constants = require 'src.constants'
local SoundManager = require 'src.SoundManager'

local highlight = 1

---@class StartState
local StartState = Class {__includes = BaseState}

function StartState:init(state_machine)
end

--- Executes when enters state
--- @param state_machine StateMachine
function StartState:enter(state_machine)
  self.machine = state_machine
end

function StartState:exit()
end

function StartState:update(dt)
  if keyboard.was_key_pressed('up') or keyboard.was_key_pressed('down') then
    highlight = highlight == 1 and 2 or 1
    SoundManager:play_sound(SoundManager.sounds.select)
  end

  if keyboard.was_key_pressed('return') or keyboard.was_key_pressed('enter') then
    SoundManager:play_sound(SoundManager.sounds.confirm)
    self.machine:change('play', self.machine)
  end
end

function StartState:draw()
  text.printf(
    'large',
    'BREAKOUT',
    0,
    constants.VIRTUAL_HEIGHT / 3 - 16,
    constants.VIRTUAL_WIDTH,
    'center'
  )

  text.printf(
    'medium',
    'Start',
    0,
    constants.VIRTUAL_HEIGHT / 2,
    constants.VIRTUAL_WIDTH,
    'center',
    (highlight == 1 and {1, 0, 0, 1})
  )

  text.printf(
    'medium',
    'Highscore',
    0,
    constants.VIRTUAL_HEIGHT / 2 + 24,
    constants.VIRTUAL_WIDTH,
    'center',
    (highlight == 2 and {1, 0, 0, 1})
  )
end

return StartState

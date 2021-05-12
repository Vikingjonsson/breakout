local Class = require 'lib.hump.class'

local text = require 'src.text'
local constants = require 'src.constants'
local BaseState = require 'src.states.BaseState'

local was_key_pressed = KEYBOARD.was_key_pressed
local highlight = 1

local function handle_input()
  if
    was_key_pressed(KEYBOARD.KEYS.ESCAPE) and
      GAME_STATE.machine:get_current_state() == GAME_STATE.STATES.START
   then
    love.event.quit(1)
  end

  if was_key_pressed(KEYBOARD.KEYS.UP) or was_key_pressed(KEYBOARD.KEYS.DOWN) then
    SOUND_MANAGER:play_sound(SOUND_MANAGER.sounds.select)
    highlight = highlight == 1 and 2 or 1
  end

  if KEYBOARD.was_key_pressed('return') or KEYBOARD.was_key_pressed('enter') then
    SOUND_MANAGER:play_sound(SOUND_MANAGER.sounds.confirm)

    if highlight == 1 then
      GAME_STATE.machine:change(GAME_STATE.STATES.PLAY)
    elseif highlight == 2 then
      GAME_STATE.machine:change(GAME_STATE.STATES.SCORE, {score = 0})
    end
  end
end

--- @class StartState
local StartState = Class {__includes = BaseState}

function StartState:init()
  love.filesystem.setIdentity('breakout')
end

--- Executes when enters state
function StartState:enter()
end

function StartState:exit()
end

function StartState:update(dt)
  handle_input()
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

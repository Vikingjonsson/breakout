local Signal = require 'lib.hump.signal'
local StateMachine = require 'src.StateMachine'
local StartState = require 'src.states.StartState'
local PlayState = require 'src.states.PlayState'
local HighScoreState = require 'src.states.HighScoreState'

local M = {}
M.signal = Signal.new()

M.STATES = {
  START = 'start',
  PLAY = 'play',
  SCORE = 'score'
}

M.EVENTS = {
  FIRE = 'fire',
  SELECT = 'select'
}

--- @param handler function
function M.on_fire(handler)
  M.signal:register(M.EVENTS.FIRE, handler)
end

--- @param handler function
function M.on_menu_select(handler)
  M.signal:register(M.EVENTS.SELECT, handler)
end

--- @type StateMachine
M.machine =
  StateMachine(
  {
    [M.STATES.START] = function()
      return StartState()
    end,
    [M.STATES.PLAY] = function()
      return PlayState()
    end,
    [M.STATES.SCORE] = function()
      return HighScoreState()
    end
  }
)

return M

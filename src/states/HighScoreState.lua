local Class = require 'lib.hump.class'
local BaseState = require 'src.states.BaseState'
local constants = require 'src.constants'
local keyboard = require 'src.keyboard'

local function parse_highscore(highscore)
  local parsed_highscore = {}

  for _, value in pairs(is_table(highscore) and highscore or {}) do
    local name, score = unpack(string.split(value, ':'))
    if name ~= nil and score ~= nil then
      table.insert(parsed_highscore, {name = name, score = score})
    end
  end

  return parsed_highscore
end

local function load_highscore()
  local highscore = {}

  if not love.filesystem.getInfo(constants.SAVE_FILE) then
    love.filesystem.write(constants.SAVE_FILE, '')
  end

  for line in love.filesystem.lines(constants.SAVE_FILE) do
    table.insert(highscore, line)
  end

  return parse_highscore(highscore)
end

--- @class HighScoreState
local HighScoreState = Class {__includes = BaseState}
local text = require 'src.text'

--- HighScoreState state constructor
function HighScoreState:init()
end

--- Fields:
--- * score number
--- @param params table<string, any>
function HighScoreState:enter(params)
  self.score = is_number(params.score) and params.score or 0
  self.highscore = table.slice(load_highscore(), 1, 5)
end

function HighScoreState:exit()
end

function HighScoreState:update(dt)
  if keyboard.was_key_pressed(KEYBOARD.KEYS.ESCAPE) then
    GAME_STATE.machine:change(GAME_STATE.STATES.START)
  end
end

function HighScoreState:draw()
  text.printf('large', 'Highscore!', 0, 10, constants.VIRTUAL_WIDTH, 'center')

  for index, value in ipairs(self.highscore) do
    local OFFSET = 80
    local GAP = 20 * (index - 1) + OFFSET

    text.printf(
      'medium',
      value.name .. '       ' .. value.score,
      0,
      index == 1 and OFFSET or GAP,
      constants.VIRTUAL_WIDTH,
      'center'
    )
  end
end

return HighScoreState

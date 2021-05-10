require 'src.globals'
if os.getenv('LOCAL_LUA_DEBUGGER_VSCODE') == '1' then
  DEBUG.IS_DEBUGGING = true
  require('lldebugger').start()
end

require 'src.utils'
local push = require 'lib.push.push'
local constants = require 'src.constants'
local keyboard = require 'src.keyboard'
local SoundManager = require 'src.SoundManager'
local StateMachine = require 'src.StateMachine.StateMachine'
local PlayState = require 'src.StateMachine.states.PlayState.PlayState'
local HighScoreState = require 'src.StateMachine.states.HighScoreState'
local StartState = require 'src.StateMachine.states.StartState'
local SpriteManager = require 'src.SpriteManager'

--- @type StateMachine
local game_state =
  StateMachine(
  {
    start = function()
      return StartState()
    end,
    play = function()
      return PlayState()
    end,
    score = function()
      return HighScoreState()
    end
  }
)

local STREACH_SIZE = 20
local BACKGROUND_WIDTH_SCALE_FACTOR =
  (STREACH_SIZE + constants.VIRTUAL_WIDTH) / SpriteManager.images.background:getWidth()

local BACKGROUND_HEIGHT_SCALE_FACTOR =
  (STREACH_SIZE + constants.VIRTUAL_HEIGHT) / SpriteManager.images.background:getHeight()

function love.resize(w, h)
  push:resize(w, h)
end

function love.keypressed(key)
  keyboard.add_pressed_keys(key)

  if key == 'escape' then
    love.event.quit(1)
  end
end

function love.load(args)
  for _, value in ipairs(args) do
    if value == 'debug' then
      DEBUG.IS_DEBUGGING = true
    end
  end

  math.randomseed(os.time())
  love.graphics.setDefaultFilter('nearest', 'nearest')
  love.window.setTitle('Breakout')

  push:setupScreen(
    constants.VIRTUAL_WIDTH,
    constants.VIRTUAL_HEIGHT,
    constants.WINDOW_WIDTH,
    constants.WINDOW_HEIGHT,
    {
      highdpi = false,
      fullscreen = false,
      resizable = true,
      vsync = true
    }
  )

  game_state:change('start', game_state)
  SoundManager:play_sound(SoundManager.music.music)
end

function love.update(dt)
  if IS_PAUSED then
    return
  end

  game_state:update(dt)
  keyboard.reset_pressed_keys()
end

function love.draw()
  push:start()

  love.graphics.draw(
    SpriteManager.images.background,
    -STREACH_SIZE / 2,
    -STREACH_SIZE / 2,
    nil,
    BACKGROUND_WIDTH_SCALE_FACTOR,
    BACKGROUND_HEIGHT_SCALE_FACTOR
  )

  game_state:draw()
  push:finish()

  DEBUG.display_fps()
end

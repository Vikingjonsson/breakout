require 'src.utils'
require 'src.globals'

KEYBOARD = require 'src.keyboard'
SPRITE_MANAGER = require 'src.SpriteManager'
SOUND_MANAGER = require 'src.SoundManager'
GAME_STATE = require 'src.states.gameState'

local push = require 'lib.push.push'
local constants = require 'src.constants'

if os.getenv('LOCAL_LUA_DEBUGGER_VSCODE') == '1' then
  DEBUG.IS_DEBUGGING = true
  require('lldebugger').start()
end

function love.resize(w, h)
  push:resize(w, h)
end

function love.keypressed(key)
  KEYBOARD.add_pressed_keys(key)
end

function love.load(args)
  -- DEBUG SETTINGS
  for _, value in ipairs(args) do
    if value == 'debug' then
      DEBUG.IS_DEBUGGING = true
    end
  end

  -- GAME SETUP
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

  SOUND_MANAGER:loop(SOUND_MANAGER.music.music)
  SOUND_MANAGER:play_sound(SOUND_MANAGER.music.music)

  GAME_STATE.machine:change(GAME_STATE.STATES.START)
end

function love.update(dt)
  if IS_PAUSED then
    return
  end

  -- GAME UPDATE
  GAME_STATE.machine:update(dt)
  KEYBOARD.reset_pressed_keys()
end

-- BACKGROUND RESIZE
local STREACH_SIZE = 20
local BACKGROUND_WIDTH_SCALE_FACTOR =
  (STREACH_SIZE + constants.VIRTUAL_WIDTH) / SPRITE_MANAGER.images.background:getWidth()
local BACKGROUND_HEIGHT_SCALE_FACTOR =
  (STREACH_SIZE + constants.VIRTUAL_HEIGHT) / SPRITE_MANAGER.images.background:getHeight()

function love.draw()
  push:start()
  -- DRAW BACKGROUND
  love.graphics.draw(
    SPRITE_MANAGER.images.background,
    -STREACH_SIZE / 2,
    -STREACH_SIZE / 2,
    nil,
    BACKGROUND_WIDTH_SCALE_FACTOR,
    BACKGROUND_HEIGHT_SCALE_FACTOR
  )

  -- DRAW GAME
  GAME_STATE.machine:draw()
  push:finish()

  DEBUG.display_fps()
end

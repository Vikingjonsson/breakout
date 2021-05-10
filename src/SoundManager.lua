local Class = require 'lib.hump.class'

local VOLUMES = {
  master = 0.1,
  music = 0.5,
  effect = 0.75
}

local SOUND_PATH = 'assets/sounds/'

--- @class SoundManager
local SoundManager = Class {}

--- State construtor
function SoundManager:init()
  self.volume = VOLUMES.master

  self.sounds = {
    paddle_hit = love.audio.newSource(SOUND_PATH .. 'paddle_hit.wav', 'static'),
    score = love.audio.newSource(SOUND_PATH .. 'score.wav', 'static'),
    wall_hit = love.audio.newSource(SOUND_PATH .. 'wall_hit.wav', 'static'),
    confirm = love.audio.newSource(SOUND_PATH .. 'confirm.wav', 'static'),
    select = love.audio.newSource(SOUND_PATH .. 'select.wav', 'static'),
    no_select = love.audio.newSource(SOUND_PATH .. 'no-select.wav', 'static'),
    brick_hit_1 = love.audio.newSource(SOUND_PATH .. 'brick-hit-1.wav', 'static'),
    brick_hit_2 = love.audio.newSource(SOUND_PATH .. 'brick-hit-2.wav', 'static'),
    hurt = love.audio.newSource(SOUND_PATH .. 'hurt.wav', 'static'),
    victory = love.audio.newSource(SOUND_PATH .. 'victory.wav', 'static'),
    recover = love.audio.newSource(SOUND_PATH .. 'recover.wav', 'static'),
    high_score = love.audio.newSource(SOUND_PATH .. 'high_score.wav', 'static'),
    pause = love.audio.newSource(SOUND_PATH .. 'pause.wav', 'static')
  }

  self.music = {
    music = love.audio.newSource(SOUND_PATH .. 'music.wav', 'static')
  }
end

--- Play sound
--- @param sound any SoundManger.sounds or SoundManager.music
function SoundManager:play_sound(sound)
  sound:setVolume(VOLUMES.master)
  love.audio.play(sound)
end

--- @type SoundManager
local instance = SoundManager()
return instance

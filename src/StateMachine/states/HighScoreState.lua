local Class = require 'lib.hump.class'
local BaseState = require 'src.StateMachine.states.BaseState'

--- @class HighScoreState
local HighScoreState = Class {__includes = BaseState}

--- HighScoreState state constructor
function HighScoreState:init()
end

function HighScoreState:enter()
end

function HighScoreState:exit()
end

function HighScoreState:update(dt)
end

function HighScoreState:draw()
end

return HighScoreState

local Class = require 'lib.hump.class'

--- @class BaseState
local BaseState = Class {}

--- State construtor
function BaseState:init()
end

--- Enter state
function BaseState:enter()
end

---Exit state
function BaseState:exit()
end

--- Update state
--- @param dt number
function BaseState:update(dt)
end

--- Draw state
function BaseState:draw()
end

return BaseState

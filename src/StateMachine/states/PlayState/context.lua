local Signal = require 'lib.hump.signal'

local M = {}
M.signal = Signal.new()
M.state = {}
M.events = {FIRE = 'fire'}

---@param handler function
function M.on_fire(handler)
  M.signal:register(M.events.FIRE, handler)
end

return M

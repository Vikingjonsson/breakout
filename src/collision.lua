local M = {}

---@param a table<string, number> representing a rectangle
---@param b table<string, number> representing a rectangle
---@return boolean result true if collision has happened otherwise false
function M.check_collision_AABB(a, b)
  local has_collision = a.x < b.x + b.w and a.y < b.y + b.h and b.x < a.x + a.w and b.y < a.y + a.h
  return has_collision
end

return M

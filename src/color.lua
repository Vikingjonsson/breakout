local M = {}

M.COLORS = {
  RED = {1, 0, 0, 1},
  GREEN = {0, 1, 0, 1},
  BLUE = {0, 0, 1, 1}
}

--- convert colors to Löve color space
--- @param red number 0-255
--- @param green number 0-255
--- @param blue number 0-255
--- @param alpha number 0-255
--- @return number[] {r,g,b,a}
function M.convert_color(red, green, blue, alpha)
  local MAX_VALUE = 255
  local function clamped_to_color_value(value)
    return math.clamp(0, value, MAX_VALUE)
  end

  return {
    clamped_to_color_value(red) / MAX_VALUE,
    clamped_to_color_value(green) / MAX_VALUE,
    clamped_to_color_value(blue) / MAX_VALUE,
    clamped_to_color_value(alpha) / MAX_VALUE
  }
end

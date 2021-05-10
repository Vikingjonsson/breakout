local M = {}

local FONTS_PATH = 'assets/fonts/'

local FONTS = {
  small = love.graphics.newFont(FONTS_PATH .. 'font.ttf', 8),
  medium = love.graphics.newFont(FONTS_PATH .. 'font.ttf', 16),
  large = love.graphics.newFont(FONTS_PATH .. 'font.ttf', 32)
}

--- Prints text
--- @param font_size string small | medium | large | huge
--- @param text string text to print
--- @param x number x-axis
--- @param y number y-axis
--- @param limit number max width
--- @param align number text alignment
--- @param color ?number[] [optional] [r, g, b, a] defaults to nil
function M.printf(font_size, text, x, y, limit, align, color)
  local previous_font = love.graphics.getFont()
  local r, g, b, a = love.graphics.getColor()

  if type(color) == 'table' and #color > 0 then
    love.graphics.setColor(unpack(color))
  end

  love.graphics.setFont(FONTS[font_size])
  love.graphics.printf(text, math.floor(x), math.floor(y), limit, align)
  love.graphics.setFont(previous_font)
  love.graphics.setColor(r, g, b, a)
end

return M

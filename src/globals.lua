IS_MUTED = true
IS_PAUSED = false

DEBUG = {}
DEBUG.IS_DEBUGGING = false

--- Prettier print values
--- @param value string value to print
--- @param tag ?string [optional] tag the log message
--- @param indent ?number [optional] space to indent log defaults to 2
function DEBUG.dump(value, tag, indent)
  local function print_divider()
    print('---------------------')
  end

  if not indent then
    indent = 2
  end

  if value == nil then
    print('Value is nil')
    print_divider()
    return
  end

  if type(value) == 'table' then
    for k, v in pairs(value) do
      local formatting = string.rep('  ', indent) .. k .. ': '
      if type(v) == 'table' then
        print(formatting)
        DEBUG.dump(v, indent + 1)
      elseif type(v) == 'boolean' then
        print(formatting .. tostring(v))
      else
        print(formatting .. v)
      end
    end
    print_divider()
    return
  end

  if type(value) ~= 'table' then
    if tag then
      print('Tag: ' .. tag)
    end
    print('Type: ' .. type(value))
    print('Value: ' .. value)
    print_divider()
    return
  end
end

--- Draw a rectangle hit box
--- @param hit_box table<string, number> x, y, w, h
function DEBUG.draw_hit_box(hit_box)
  if DEBUG.IS_DEBUGGING then
    local r, g, b, a = love.graphics.getColor()
    love.graphics.setColor(1, 0, 0, 0.5)
    love.graphics.rectangle('fill', hit_box.x, hit_box.y, hit_box.w, hit_box.h)
    love.graphics.setColor(r, g, b, a)
  end
end

--- Dispaly FPS
function DEBUG.display_fps()
  if DEBUG.IS_DEBUGGING then
    local r, g, b, a = love.graphics.getColor()
    love.graphics.setColor(1, 0, 0, 1)
    love.graphics.print('FPS: ' .. tostring(love.timer.getFPS()), 5, 5)
    love.graphics.setColor(r, g, b, a)
  end
end

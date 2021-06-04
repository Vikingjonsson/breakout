function table.slice(tbl, first, last)
  local sliced = {}
  local last_index = last > #tbl and #tbl or last
  local first_index = first > last and last or first

  for i = first_index or 1, last_index or #tbl, 1 do
    sliced[#sliced + 1] = tbl[i]
  end

  return sliced
end

function math.clamp(min, val, max)
  return math.max(min, math.min(val, max))
end

---@param s string
---@return string
function string.trim(s)
  local match = string.match
  return match(s, '^()%s*$') and '' or match(s, '^%s*(.*%S)')
end

function string.split(str, sep)
  if sep == nil then
    sep = '%s'
  end
  local t = {}
  for s in string.gmatch(str, '([^' .. sep .. ']+)') do
    table.insert(t, s)
  end
  return t
end

---@diagnostic disable: lowercase-global

function is_string(val)
  return type(val) == 'string'
end

function is_table(val)
  return type(val) == 'table'
end

function is_number(val)
  return type(val) == 'number'
end

function is_boolean(val)
  return type(val) == 'boolean'
end

---@diagnostic enable: lowercase-global

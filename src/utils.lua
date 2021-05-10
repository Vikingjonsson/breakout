function table.slice(tbl, first, last)
  local sliced = {}
  local last_index = last > #tbl and #tbl or last
  local first_index = first > last and last or first

  for i = first_index or 1, last_index or #tbl, 1 do
    sliced[#sliced + 1] = tbl[i]
  end

  return sliced
end

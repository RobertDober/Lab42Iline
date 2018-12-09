local splitter = {}

local function new() 
  return splitter
end

function splitter:split(list, fun, options)
  return vim.api.nvim_call_function(fun, {list[1]})
end


return { new = new }

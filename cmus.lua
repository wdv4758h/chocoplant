-- {{{ Grab environment
local setmetatable = setmetatable
-- }}}


-- cmus: provides Cmus playing status
-- vicious.widgets.cmus
local cmus = {}

function os.capture(cmd, raw)
  local f = assert(io.popen(cmd, 'r'))
  local s = assert(f:read('*a'))
  f:close()
  if raw then return s end
  s = string.gsub(s, '^%s+', '')
  s = string.gsub(s, '%s+$', '')
  s = string.gsub(s, '[\n\r]+', ' ')

  -- strip string to last /
  s = string.gsub(s, '.*/', '')

  -- remove Filename Extension
  s = string.gsub(s, '%.[^%.]+$', '')
  return s
end

-- {{{ Cmus widget type
local function worker(format, warg)
    return os.capture('cmus-remote -Q | head -2 | tail -1 | cut -b6-')
end
-- }}}

return setmetatable(cmus, { __call = function(_, ...) return worker(...) end })

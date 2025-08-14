local M = {}

M.patterns = {
  {
    type = 'function',
    pattern = '\\bdef(p)?\\s+%s\\s*[ ,\\(]',
    description = 'Function definition'
  },
  {
    type = 'variable',
    pattern = '\\s*%s\\s*=[^=\\n]+',
    description = 'Variable assignment'
  },
  {
    type = 'module',
    pattern = 'defmodule\\s+((\\w+\\.)*)%s\\s+',
    description = 'Module definition'
  },
  {
    type = 'protocol',
    pattern = 'defprotocol\\s+((\\w+\\.)*)%s\\s+',
    description = 'Protocol definition'
  }
}

function M.find_definitions(word)
  local matches = {}
  local cwd = vim.fn.getcwd()

  for _, pattern_def in ipairs(M.patterns) do
    local pattern = pattern_def.pattern:gsub('%%s', word)

    local cmd = string.format("rg -n '%s' --type elixir %s", pattern, cwd)
    local handle = io.popen(cmd)

    if handle then
      for line in handle:lines() do
        local file, line_num, content = line:match('^([^:]+):(%d+):(.*)$')
        if file and line_num and content then
          table.insert(matches, {
            file = file,
            line = tonumber(line_num),
            col = 0,
            content = vim.trim(content),
            type = pattern_def.type,
            description = pattern_def.description
          })
        end
      end
      handle:close()
    end
  end

  return matches
end

return M


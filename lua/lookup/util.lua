local M = {}

function M.find_definitions_with_patterns(word, patterns, rg_type)
  local matches = {}
  local seen = {}
  local cwd = vim.fn.getcwd()

  for _, pattern_def in ipairs(patterns) do
    local pattern = pattern_def.pattern:gsub('%%s', word)
    local cmd = string.format("rg -n '%s' --type %s %s", pattern, rg_type, cwd)
    local handle = io.popen(cmd)

    if handle then
      for line in handle:lines() do
        local file, line_num, content = line:match('^([^:]+):(%d+):(.*)$')
        if file and line_num and content then
          local key = file .. ':' .. line_num
          if not seen[key] then
            seen[key] = true
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
      end
      handle:close()
    end
  end

  return matches
end

return M


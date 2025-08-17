local M = {}

function M.show_matches(matches)
  local has_fzf_lua, fzf_lua = pcall(require, 'fzf-lua')

  if not has_fzf_lua then
    vim.notify('fzf-lua not found, falling back to vim.ui.select', vim.log.levels.WARN)
    M.fallback_picker(matches)
    return
  end

  local entries = {}
  for i, match in ipairs(matches) do
    local relative_file = vim.fn.fnamemodify(match.file, ':.')
    local entry = string.format('%s:%d: [%s] %s',
      relative_file,
      match.line,
      match.type,
      match.content
    )
    table.insert(entries, entry)
  end

  fzf_lua.fzf_exec(entries, {
    prompt = 'Select definition > ',
    actions = {
      ['default'] = function(selected)
        if selected and #selected > 0 then
          local idx = nil
          for i, entry in ipairs(entries) do
            if entry == selected[1] then
              idx = i
              break
            end
          end

          if idx then
            local match = matches[idx]
            vim.cmd('edit ' .. match.file)
            vim.api.nvim_win_set_cursor(0, { match.line, match.col or 0 })
          end
        end
      end
    }
  })
end

function M.fallback_picker(matches)
  local items = {}
  for _, match in ipairs(matches) do
    local relative_file = vim.fn.fnamemodify(match.file, ':.')
    table.insert(items, string.format('%s:%d: [%s] %s',
      relative_file,
      match.line,
      match.type,
      match.content
    ))
  end

  vim.ui.select(items, {
    prompt = 'Select definition:',
  }, function(choice, idx)
    if choice and idx then
      local match = matches[idx]
      vim.cmd('edit ' .. match.file)
      vim.api.nvim_win_set_cursor(0, { match.line, match.col or 0 })
    end
  end)
end

return M

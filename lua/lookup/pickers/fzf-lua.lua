local M = {}

function M.show_matches(matches)
  local has_fzf, fzf = pcall(require, 'fzf-lua')
  if not has_fzf then
    vim.notify('fzf-lua not found. Please install fzf-lua', vim.log.levels.ERROR)
    return
  end

  local entries = {}
  for _, match in ipairs(matches) do
    local entry = string.format('%s:%d:%d: %s', match.file, match.line, match.col or 0, match.content)
    table.insert(entries, entry)
  end

  fzf.fzf_exec(entries, {
    prompt = 'Jump to Definition> ',
    actions = {
      ['default'] = function(selected)
        if not selected or #selected == 0 then
          return
        end

        local entry = selected[1]
        local file, line_num, col_num = entry:match('^([^:]+):(%d+):(%d+):')

        if file and line_num then
          vim.cmd('edit ' .. file)
          vim.api.nvim_win_set_cursor(0, { tonumber(line_num), tonumber(col_num) or 0 })
        end
      end,
    },
  })
end

return M


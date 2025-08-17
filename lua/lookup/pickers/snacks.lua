local M = {}

function M.show_matches(matches)
  local has_snacks, snacks = pcall(require, 'snacks')
  if not has_snacks then
    vim.notify('snacks.nvim not found. Please install snacks.nvim', vim.log.levels.ERROR)
    return
  end

  local entries = {}
  for _, match in ipairs(matches) do
    table.insert(entries, {
      file = match.file,
      line = match.line,
      col = match.col or 0,
      text = match.content,
      display = string.format('%s:%d: %s', match.file, match.line, match.content),
    })
  end

  snacks.picker.pick({
    source = entries,
    format = function(item)
      return item.display
    end,
    confirm = function(item)
      if item then
        vim.cmd('edit ' .. item.file)
        vim.api.nvim_win_set_cursor(0, { item.line, item.col })
      end
    end,
    title = 'Jump to Definition',
  })
end

return M


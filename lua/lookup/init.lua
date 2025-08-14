local M = {}

local function setup_commands()
  vim.api.nvim_create_user_command('LookupDefinition', function()
    M.lookup_definition()
  end, { desc = 'Lookup definition under cursor' })
end

function M.setup(opts)
  opts = opts or {}
  setup_commands()
end

function M.lookup_definition()
  local word = vim.fn.expand('<cword>')
  if word == '' then
    vim.notify('No word under cursor', vim.log.levels.WARN)
    return
  end

  local filetype = vim.bo.filetype
  local lang_module = require('lookup.langs.' .. filetype)

  if not lang_module then
    vim.notify('Language ' .. filetype .. ' not supported', vim.log.levels.WARN)
    return
  end

  local matches = lang_module.find_definitions(word)

  if #matches == 0 then
    vim.notify('No definitions found for ' .. word, vim.log.levels.INFO)
  elseif #matches == 1 then
    local match = matches[1]
    vim.cmd('edit ' .. match.file)
    vim.api.nvim_win_set_cursor(0, { match.line, match.col or 0 })
  else
    require('lookup.picker').show_matches(matches)
  end
end

return M


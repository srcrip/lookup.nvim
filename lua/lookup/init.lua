local M = {}

M.config = {
  use_lsp = true,
  picker = 'telescope' -- 'telescope', 'fzf-lua', 'snacks', or 'builtin'
}

function M.setup(opts)
  opts = opts or {}
  M.config = vim.tbl_deep_extend('force', M.config, opts)
end

local function fallback_to_regex()
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
    M.show_picker(matches)
  end
end

function M.lookup_definition()
  if M.config.use_lsp then
    local clients = vim.lsp.get_active_clients({ bufnr = 0 })
    if #clients > 0 then
      -- Hook into vim.notify to detect LSP failure
      local original_notify = vim.notify
      local lsp_failed = false

      vim.notify = function(msg, level, opts)
        if type(msg) == 'string' and (msg:match('No information available') or msg:match('No locations found')) then
          lsp_failed = true
          return -- Don't show the failure message
        end
        return original_notify(msg, level, opts)
      end

      vim.lsp.buf.definition()

      -- Restore original notify after a short delay
      vim.defer_fn(function()
        vim.notify = original_notify
        if lsp_failed then
          fallback_to_regex()
        end
      end, 100)

      return
    end
  end

  fallback_to_regex()
end

function M.show_picker(matches)
  local picker_name = M.config.picker
  local picker_module = 'lookup.pickers.' .. picker_name
  
  local ok, picker = pcall(require, picker_module)
  if not ok then
    -- Fallback to builtin picker
    picker = require('lookup.pickers.builtin')
  end
  
  picker.show_matches(matches)
end

return M

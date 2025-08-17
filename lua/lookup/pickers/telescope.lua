local M = {}

function M.show_matches(matches)
  local has_telescope, telescope = pcall(require, 'telescope')
  if not has_telescope then
    vim.notify('Telescope not found. Please install telescope.nvim', vim.log.levels.ERROR)
    return
  end

  local pickers = require('telescope.pickers')
  local finders = require('telescope.finders')
  local conf = require('telescope.config').values
  local actions = require('telescope.actions')
  local action_state = require('telescope.actions.state')

  local function entry_maker(match)
    local display = string.format('%s:%d: %s', match.file, match.line, match.content)
    return {
      value = match,
      display = display,
      ordinal = display,
      filename = match.file,
      lnum = match.line,
      col = match.col or 0,
    }
  end

  pickers.new({}, {
    prompt_title = 'Jump to Definition',
    finder = finders.new_table {
      results = matches,
      entry_maker = entry_maker,
    },
    sorter = conf.generic_sorter({}),
    attach_mappings = function(prompt_bufnr, map)
      actions.select_default:replace(function()
        local selection = action_state.get_selected_entry()
        actions.close(prompt_bufnr)
        
        if selection then
          local match = selection.value
          vim.cmd('edit ' .. match.file)
          vim.api.nvim_win_set_cursor(0, { match.line, match.col or 0 })
        end
      end)
      return true
    end,
  }):find()
end

return M
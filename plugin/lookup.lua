if vim.g.loaded_lookup then
  return
end
vim.g.loaded_lookup = 1

require('lookup').setup()
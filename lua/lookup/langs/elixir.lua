local M = {}

M.rg_type = 'elixir'

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
  return require('lookup.util').find_definitions_with_patterns(word, M.patterns, M.rg_type)
end

return M

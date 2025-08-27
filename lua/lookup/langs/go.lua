local M = {}

M.rg_type = 'go'

M.patterns = {
  {
    type = 'function',
    pattern = 'func\\s+%s\\s*\\(',
    description = 'Function definition'
  },
  {
    type = 'function',
    pattern = 'func\\s+\\([^)]*\\)\\s+%s\\s*\\(',
    description = 'Method definition'
  },
  {
    type = 'variable',
    pattern = '\\s*\\b%s\\s*=[^=\\n]+',
    description = 'Variable assignment'
  },
  {
    type = 'variable',
    pattern = '\\s*\\b%s\\s*:=\\s*',
    description = 'Short variable declaration'
  },
  {
    type = 'type',
    pattern = 'type\\s+%s\\s+struct\\s*\\{',
    description = 'Struct definition'
  },
  {
    type = 'type',
    pattern = 'type\\s+%s\\s+interface\\s*\\{',
    description = 'Interface definition'
  },
  {
    type = 'type',
    pattern = 'type\\s+%s\\s+',
    description = 'Type alias'
  },
  {
    type = 'constant',
    pattern = 'const\\s+%s\\s*=',
    description = 'Constant definition'
  },
  {
    type = 'variable',
    pattern = 'var\\s+%s\\s+',
    description = 'Variable declaration'
  }
}

function M.find_definitions(word)
  return require('lookup.util').find_definitions_with_patterns(word, M.patterns, M.rg_type)
end

return M
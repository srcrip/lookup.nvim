local M = {}

M.rg_type = 'gdscript'

M.patterns = {
  {
    type = 'function',
    pattern = '^\\s*func\\s+%s\\s*\\(',
    description = 'Function definition'
  },
  {
    type = 'class',
    pattern = '^\\s*class\\s+%s\\b',
    description = 'Class definition'
  },
  {
    type = 'variable',
    pattern = '^\\s*var\\s+%s\\b',
    description = 'Variable declaration'
  },
  {
    type = 'constant',
    pattern = '^\\s*const\\s+%s\\s*=',
    description = 'Constant definition'
  },
  {
    type = 'signal',
    pattern = '^\\s*signal\\s+%s\\b',
    description = 'Signal definition'
  },
  {
    type = 'enum',
    pattern = '^\\s*enum\\s+%s\\b',
    description = 'Enum definition'
  },
  {
    type = 'export',
    pattern = '^\\s*export\\s+.*%s\\b',
    description = 'Exported variable'
  },
  {
    type = 'onready',
    pattern = '^\\s*onready\\s+var\\s+%s\\b',
    description = 'OnReady variable'
  },
  {
    type = 'tool',
    pattern = '^\\s*tool\\s+.*%s',
    description = 'Tool script'
  }
}

function M.find_definitions(word)
  return require('lookup.util').find_definitions_with_patterns(word, M.patterns, M.rg_type)
end

return M
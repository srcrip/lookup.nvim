local M = {}

M.rg_type = 'rust'

M.patterns = {
  {
    type = 'function',
    pattern = '\\bfn\\s+%s\\s*\\(',
    description = 'Function definition'
  },
  {
    type = 'macro',
    pattern = '\\bmacro_rules!\\s+%s',
    description = 'Macro definition'
  },
  {
    type = 'struct',
    pattern = '\\bstruct\\s+%s\\b',
    description = 'Struct definition'
  },
  {
    type = 'enum',
    pattern = '\\benum\\s+%s\\b',
    description = 'Enum definition'
  },
  {
    type = 'trait',
    pattern = '\\btrait\\s+%s\\b',
    description = 'Trait definition'
  },
  {
    type = 'type',
    pattern = '\\btype\\s+%s\\s*=',
    description = 'Type alias'
  },
  {
    type = 'impl',
    pattern = '\\bimpl\\s+.*%s',
    description = 'Implementation block'
  },
  {
    type = 'module',
    pattern = '\\bmod\\s+%s\\b',
    description = 'Module definition'
  },
  {
    type = 'variable',
    pattern = '\\blet\\s+%s\\b',
    description = 'Variable binding'
  },
  {
    type = 'constant',
    pattern = '\\bconst\\s+%s\\s*:',
    description = 'Constant definition'
  },
  {
    type = 'static',
    pattern = '\\bstatic\\s+%s\\s*:',
    description = 'Static variable'
  }
}

function M.find_definitions(word)
  return require('lookup.util').find_definitions_with_patterns(word, M.patterns, M.rg_type)
end

return M
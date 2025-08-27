local M = {}

M.rg_type = 'php'

M.patterns = {
  {
    type = 'function',
    pattern = 'function\\s+%s\\s*\\(',
    description = 'Function definition'
  },
  {
    type = 'method',
    pattern = '\\*\\s@method\\s+[^ \\t]+\\s+%s\\(',
    description = 'Method annotation'
  },
  {
    type = 'class',
    pattern = '\\bclass\\s+%s\\b',
    description = 'Class definition'
  },
  {
    type = 'interface',
    pattern = '\\binterface\\s+%s\\b',
    description = 'Interface definition'
  },
  {
    type = 'trait',
    pattern = '\\btrait\\s+%s\\b',
    description = 'Trait definition'
  },
  {
    type = 'variable',
    pattern = '\\$%s\\s*=',
    description = 'Variable assignment'
  },
  {
    type = 'constant',
    pattern = '\\bconst\\s+%s\\s*=',
    description = 'Class constant'
  },
  {
    type = 'constant',
    pattern = '\\bdefine\\s*\\(\\s*[\'"]%s[\'"]',
    description = 'Global constant'
  },
  {
    type = 'property',
    pattern = '^\\s*(?:public|private|protected|static)*\\s*\\$%s',
    description = 'Property definition'
  }
}

function M.find_definitions(word)
  return require('lookup.util').find_definitions_with_patterns(word, M.patterns, M.rg_type)
end

return M
local M = {}

M.rg_type = 'typescript'

M.patterns = {
  {
    type = 'function',
    pattern = '\\b%s\\s*\\(',
    description = 'Function definition'
  },
  {
    type = 'function',
    pattern = '\\b%s\\s*=\\s*function',
    description = 'Function assignment'
  },
  {
    type = 'function',
    pattern = '\\b%s\\s*[=:]\\s*.*=>',
    description = 'Arrow function'
  },
  {
    type = 'function',
    pattern = 'function\\s+%s\\b',
    description = 'Function declaration'
  },
  {
    type = 'class',
    pattern = 'class\\s+%s\\b',
    description = 'Class definition'
  },
  {
    type = 'interface',
    pattern = 'interface\\s+%s\\b',
    description = 'Interface definition'
  },
  {
    type = 'type',
    pattern = 'type\\s+%s\\s*=',
    description = 'Type alias definition'
  }
}

function M.find_definitions(word)
  return require('lookup.util').find_definitions_with_patterns(word, M.patterns, M.rg_type)
end

return M


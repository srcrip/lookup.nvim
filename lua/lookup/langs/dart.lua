local M = {}

M.rg_type = 'dart'

M.patterns = {
  {
    type = 'function',
    pattern = '\\b%s\\s*\\(',
    description = 'Function call or definition'
  },
  {
    type = 'class',
    pattern = '\\bclass\\s+%s\\b',
    description = 'Class definition'
  },
  {
    type = 'method',
    pattern = '^\\s*(?:[\\w<>\\[\\]]+\\s+)*%s\\s*\\(',
    description = 'Method definition'
  },
  {
    type = 'variable',
    pattern = '\\b(?:var|final|const)\\s+%s\\b',
    description = 'Variable declaration'
  },
  {
    type = 'variable',
    pattern = '^\\s*[\\w<>\\[\\]]+\\s+%s\\s*[;=]',
    description = 'Typed variable declaration'
  },
  {
    type = 'enum',
    pattern = '\\benum\\s+%s\\b',
    description = 'Enum definition'
  },
  {
    type = 'mixin',
    pattern = '\\bmixin\\s+%s\\b',
    description = 'Mixin definition'
  },
  {
    type = 'typedef',
    pattern = '\\btypedef\\s+.*%s',
    description = 'Type definition'
  },
  {
    type = 'constructor',
    pattern = '\\b%s\\s*\\(',
    description = 'Constructor'
  },
  {
    type = 'getter',
    pattern = '\\bget\\s+%s\\b',
    description = 'Getter method'
  },
  {
    type = 'setter',
    pattern = '\\bset\\s+%s\\s*\\(',
    description = 'Setter method'
  }
}

function M.find_definitions(word)
  return require('lookup.util').find_definitions_with_patterns(word, M.patterns, M.rg_type)
end

return M
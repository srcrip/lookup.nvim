local M = {}

M.rg_type = 'java'

M.patterns = {
  {
    type = 'method',
    pattern = '^\\s*(?:[\\w\\[\\]]+\\s+){1,3}%s\\s*\\(',
    description = 'Method definition'
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
    type = 'enum',
    pattern = '\\benum\\s+%s\\b',
    description = 'Enum definition'
  },
  {
    type = 'variable',
    pattern = '\\s*\\b%s\\s*=[^=\\n]+',
    description = 'Variable assignment'
  },
  {
    type = 'field',
    pattern = '^\\s*(?:private|public|protected|static|final)*\\s*[\\w<>\\[\\]]+\\s+%s\\s*[;=]',
    description = 'Field definition'
  },
  {
    type = 'constructor',
    pattern = '^\\s*(?:public|private|protected)?\\s*%s\\s*\\(',
    description = 'Constructor'
  },
  {
    type = 'annotation',
    pattern = '@%s',
    description = 'Annotation definition'
  }
}

function M.find_definitions(word)
  return require('lookup.util').find_definitions_with_patterns(word, M.patterns, M.rg_type)
end

return M
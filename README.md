# lookup.nvim

A Neovim plugin for jump-to-definition functionality inspired by [dumb-jump](https://github.com/jacktasia/dumb-jump) for Emacs. This plugin provides intelligent definition lookup with LSP-first approach and regex fallback using ripgrep for fast searching.

This package simply takes the [regexes from dumb-jump](https://github.com/jacktasia/dumb-jump/blob/42f97dea503367bf45c53a69de959177b06b0f59/dumb-jump.el) and reimplements them in Neovim lua, dumping them into a picker like FZF or Telescope.

This package is name `lookup.nvim` rather than `dumb-jump.nvim` because technically the goal is really a
reimplementation of the [Doom emacs package of the same name](https://docs.doomemacs.org/v21.12/modules/tools/lookup/).
This is a wrapper around `dumb-jump` itself and several other search providers. In accordance with that goal, this
package will first attempt an LSP search for the word under the cursor and then follow it up with the simple regex
lookup.

## Why?

LSP go to definition works great but is dependent on the quality of the LSP server implementation. Unfortunately, the
language I write the most of, Elixir, cannot jump to certain things (at time of writing) like the following `.heex` components:

```elixir
<.example_component>
  foo
</.example_component>
```

## Features

### Supported Languages

- [x] Elixir
- [x] JavaScript
- [x] TypeScript
- [x] React (JSX/TSX)
- [x] Vue
- [x] Go
- [x] Rust
- [x] Java
- [x] PHP
- [x] Dart
- [x] GDScript (Godot)

## Installation

### Using [lazy.nvim](https://github.com/folke/lazy.nvim)

```lua
{
  'srcrip/lookup.nvim',
  dependencies = {
    -- whichever picker you like
    'ibhagwan/fzf-lua',
    -- 'nvim-telescope/telescope.nvim',
    -- 'folke/snacks.nvim',
  },
  config = function()
    require('lookup').setup({
      use_lsp = true,           -- Try LSP first, fallback to regex
      picker = 'fzf-lua',     -- 'telescope', 'fzf-lua', 'snacks', 'builtin'
    })
  end,
}
```


## Usage

### Lua API

```lua
-- Jump to definition
require('lookup').lookup_definition()
```

### Keymaps

I personally am using `gd`:

```lua
-- Example keymap configurations
vim.keymap.set('n', 'gd', require('lookup').lookup_definition, { desc = 'Go to definition' })
```

## TODO

- [ ] Add support for more languages
- [ ] Ensure visual mode support
- [ ] Add unit tests
- [ ] Warn when LSP isn't available yet (it's really annoying that LSP/Neovim does not do this automatically)
- [ ] Enable configuration of searched directories (right now the plugin won't search stuff that's often hidden/gitignored like `node_modules` or other dependencies, but you may want to be able to jump to those))

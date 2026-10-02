~daniel/.config/nvim/
====================

```sh
git clone https://github.com/dmateos/config-neovim.git ~/.config/nvim
nvim   # lazy.nvim bootstraps itself; mason installs LSP servers/formatters
```

Plugins are managed by [lazy.nvim](https://github.com/folke/lazy.nvim) and
pinned in `lazy-lock.json` (`:Lazy update` to bump). Targets nvim 0.10+.

Optional: `apt install ripgrep fd-find` for Telescope grep / faster file search.

Layout:

- `init.lua` – leader + loads the rest
- `lua/config/` – options, keymaps, autocmds, lazy bootstrap
- `lua/plugins/` – plugin specs (ui, editor, lsp)
- `plugin/send-to-tmux.vim` – tslime-style send to tmux

Originally stolen and hacked from @pda's [dotvim](https://github.com/pda/dotvim).

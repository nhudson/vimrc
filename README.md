# neovim configuration

This is my [neovim](https://github.com/neovim/neovim) configuration.

Big thanks to [Allman](https://github.com/Allaman) for the inspiration and configuration layout, most of this is stolen from his [neovim](https://github.com/Allaman/nvim) repo

Currently this configuration is working on my Macbook Pro M1, but it does require a neovim dev build (0.8+)

## Change

I wanted to completely update my neovim/vim configuration from the old vimscript into something a bit more configurable with Lua. This will give me a chance to get up close with Lua and learn a bit about the language

## Features & Plugins

### General ⚙️

- Package management and plugin configuration via [Packer](https://github.com/wbthomason/packer.nvim)
- Mnemonic keyboard mappings via [which-key.nvim](https://github.com/folke/which-key.nvim); no more than three keystrokes for each keybinding
- Submodes powered by [Hydra.nvim](https://github.com/anuvyklack/hydra.nvim)
- Fully featured status line via [mini.nvim](https://github.com/echasnovski/mini.nvim)
- Terminal integration via [nvim-toggleterm.lua](https://github.com/akinsho/nvim-toggleterm.lua)
- Fancy notifications via [nvim-notify](https://github.com/rcarriga/nvim-notify)
- Better writing with [vale](https://vale.sh/) integration via [null-ls](https://github.com/jose-elias-alvarez/null-ls.nvim)
- Fast startup 🚀

### Navigation 🧭

- [Telescope.nvim](https://github.com/nvim-telescope/telescope.nvim) for all your search needs
- Project management with [Project.nvim](https://github.com/ahmedkhalf/project.nvim)
- File tree navigation/manipulation via [nvim-tree](https://github.com/kyazdani42/nvim-tree.lua)
- Convenient Tmux navigation with your home row via [Navigator.nvim](https://github.com/numToStr/Navigator.nvim)
- [LF](https://github.com/gokcehan/lf) integration via [lf.vim](https://github.com/ptzz/lf.vim) for a full featured file manager in Neovim
- Convenient jumping through windows with [nvim-window](https://gitlab.com/yorickpeterse/nvim-window)

### Coding 🖥️

- Auto completion powered by [nvim-cmp](https://github.com/hrsh7th/nvim-cmp)
- Built-in LSP configured via [nvim-lspconfig](https://github.com/neovim/nvim-lspconfig)
- Debugging for Go and Python via [nvim-dap](https://github.com/mfussenegger/nvim-dap) and friends
- [Treesitter](https://github.com/nvim-treesitter/nvim-treesitter) and [Tresitter-textobjects](https://github.com/nvim-treesitter/nvim-treesitter-textobjects) for your syntax needs
- Auto formatting via [null-ls.nvim](https://github.com/jose-elias-alvarez/null-ls.nvim)
- Excellent Go support via LSP and [go.nvim](https://github.com/ray-x/go.nvim) including sensible keybindings
- Git integration via [Neogit](https://github.com/TimUntersberger/neogit), [gitsigns](https://github.com/lewis6991/gitsigns.nvim), [git-blame](https://github.com/f-person/git-blame.nvim), and [gitui](https://github.com/extrawurst/gitui)
- Schema integration via LSPs for Kubernetes, package.json, github workflows, gitlab-ci.yml, kustomization.yaml, and more
- Always know where you are in your code via [nvim-navic](https://github.com/SmiteshP/nvim-navic)
- Outlining symbols with [symbols-outline.nvim](https://github.com/simrat39/symbols-outline.nvim)
- Snippets provided by [Luasnip](https://github.com/L3MON4D3/LuaSnip) and [friendly snippets](https://github.com/rafamadriz/friendly-snippets) with autocompletion
- Markdown help using [null-ls](https://github.com/jose-elias-alvarez/null-ls.nvim), [vale](https://vale.sh) and [markdown-preview](https://github.com/iamcco/markdown-preview.nvim) - Currently non Lua based
- Rust support (tbd)

## Structure

Each plugin to be installed is defined in `plugins.lua` and each plugin has its own configuration file (if necessary) in `lua/config/` which is loaded by packer.

```sh
.
├── after
│   └── ftplugin      # file specific settings
├── init.lua          # main entry point
├── lua
│   ├── config/       # each plugin configuration is in its own file
│   ├── autocmd.lua   # autocommands
│   ├── functions.lua # lua functions to extend functionality
│   ├── mappings.lua  # Vim keymaps definitions -> config/which.lua for more
│   ├── options.lua   # non plugin related (vim) options
│   ├── plugins.lua   # define plugins to be managed via Packer
│   └── user-conf.lua # parameters to configure some settings
├── plugin            # packer_compiled
├── snippets          # snippets directory (luasnip style)
└── spell             # my spell files linked from another repo
```

## Bindings

| Mode | key                    | binding                                                |
| ---- | ---------------------- | ------------------------------------------------------ |
| n    | space                  | Leader key                                             |
| n    | ⬆ ⬇ ⬅ ➡                | Resize panes                                           |
| n    | \<c-h \| j \| k \| l\> | Change pane focus (including Tmux panes)               |
| n    | \<leader\>Tab          | Switch to previously opened buffer                     |
| n    | \<Tab\>                | Switch to next buffer (bnext)                          |
| n    | \<S-Tab\>              | Switch to previous buffer (bprev)                      |
| n    | st                     | Visual selection with Treesitter hint textobject       |
| v    | sa                     | Add surrounding                                        |
| n    | sd                     | Delete surrounding                                     |
| n    | sr                     | Replace surrounding                                    |
| v    | ga                     | Easyalign                                              |
| n    | gcc                    | Toggle line comment                                    |
| n/v  | gc                     | Toggle line comment (works with movements like `gcip`) |
| n    | ss                     | Search 2 char forward (lightspeed)                     |
| n    | S                      | Search 2 char backward (lightspeed)                    |
| i/s  | \<c-j\>                | Luasnip expand/forward                                 |
| i/s  | \<c-k\>                | Luasnip backward                                       |
| i    | \<c-h\>                | Luasnip select choice                                  |
| n    | \<c-n\>                | Toggleterm (opens/hides a full terminal in Neovim)     |
| i    | \<c-l\>                | Move out of closing bracket                            |
| n    | \<CR\>                 | Start incremental selection                            |
| v    | \<Tab\>                | Increment selection                                    |
| v    | \<S-Tab\>              | Decrement selection                                    |

## Which-key leader key clusters

Mappings are clustered according to their topic/tool.

See `./lua/config/which.lua` for details.

| key | cluster                                                |
| --- | ------------------------------------------------------ |
| b   | Buffer management                                      |
| c   | Language specific actions (only in Go, e.g. run tests) |
| d   | Debugging                                              |
| f   | File management                                        |
| g   | Git actions                                            |
| l   | LSP integration (only when a LSP is attached)          |
| m   | Misc stuff                                             |
| q   | Quickfix                                               |
| s   | Searching                                              |
| w   | Window management                                      |
| x   | Languagetool integration                               |
| z   | Spell bindings                                         |

## User configuration (experimental)

The intention of my Neovim configuration was never to be a fully customizable "distribution" like LunarVim, SpaceVim, etc but from time to time I like to change my color scheme and the idea of making this configurable came to my mind. Based upon this idea I implemented some further lightweight configuration options that might be useful.

All options can be found in `./lua/user-conf.lua`.

## Remove plugins

Basically, you can remove unwanted plugins by just removing the appropriate line in `./lua/plugins.lua` and, if applicable, delete its configuration file in `./lua/config/`.

ℹ️ Keep in mind that some plugins are configured to work in conjunction with other plugins. For instance, autopairs is configured in `./lua/config/treesitter.lua`. For now there is no logic implemented that cross-checks such dependencies.

## Add plugins

If you want to follow my method adding a plugin is straight forward:

In `lua/plugins.lua` add the plugin to Packer. You are free to use a name for the configuration file (should be a valid filename).

```lua
use {"<Address-of-the-plugin>", config = get_config("<name-of-the-plugin>")}
```

Create `lua/config/<name-of-the-plugin>.lua` where you put the plugins settings. If your plugin does not require additional configuration or loading you can omit the config part.

Open another instance of Neovim (I always try to keep one running instance of Neovim open in case I messed up my config) and run `PackerSync`.

## Requirements

There are some tools that are required in order to use some features/plugins:

### Tools

- [ripgrep](https://github.com/BurntSushi/ripgrep)
- [fd](https://github.com/sharkdp/fd)
- [fzf](https://github.com/junegunn/fzf)
- [vale](https://vale.sh)

#### Vale configuration

Vale requires some setup, otherwise you will get error notifications when opening some files.

Install vale using your systems package manager

```
$ brew install vale
```

You have to set up a configuration in your `$HOME` directory. Here is an example configuration at `$HOME/.vale.ini`

```
StylesPath = .styles
MinAlertLevel = suggestion

Packages = Google, Readability, alex, proselint, Hugo
# Only Markdown and .txt files; change to whatever you're using.
[*.{md,txt}]
# List of styles to load.
BasedOnStyles = alex, proselint
```

Next we need to setup the `$HOME/.styles` directory and download the styles

```
$ mkdir ~/.styles
$ vale sync
```

### LSPs, Formatting, Linters, DAP

The following programs should be installed on your system so that the appropriate tools can be installed:

- Go
- Python
- NodeJs > 12
- Cargo

#### Go

Go related dependencies are managed by `go.nvim` and are installed by running `:GoInstallBinaries` (when a Go file is loaded). They are installed in your `$GOPATH`.

#### Rust

TBD

#### All other

All other dependencies are managed by [Mason](https://github.com/williamboman/mason.nvim) and [Mason tool installer](https://github.com/WhoIsSethDaniel/mason-tool-installer.nvim). Tools are installed by running `:MasonToolsInstall` (in `vim.fn.stdpath("data") .. "mason"`). [Mason requirements](https://github.com/williamboman/mason.nvim#requirements) must be available on your system.

For advanced spell checks via [vim-grammarous](https://github.com/rhysd/vim-grammarous) Java 8+ is required

local settings = require("user-conf")
local fn = vim.fn

-- Automatically install packer
local install_path = fn.stdpath "data" .. "/site/pack/packer/start/packer.nvim"

-- returns the require for use in `config` parameter of packer's use
-- expects the name of the config file
local function get_config(name)
  return string.format('require("config/%s")', name)
end

---@diagnostic disable-next-line: missing-parameter
if fn.empty(fn.glob(install_path)) > 0 then
  PACKER_BOOTSTRAP = fn.system {
    "git",
    "clone",
    "--depth",
    "1",
    "https://github.com/wbthomason/packer.nvim",
    install_path,
  }
  print "Installing packer close and reopen Neovim..."
  vim.cmd [[packadd packer.nvim]]
end

-- Autocommand that reloads neovim whenever you save the plugins.lua file
vim.cmd [[
  augroup packer_user_config
    autocmd!
    autocmd BufWritePost plugins.lua source <afile> | PackerSync
  augroup end
]]

-- Use a protected call so we don't error out on first use
local status_ok, packer = pcall(require, "packer")
if not status_ok then
  return
end

packer.init({
  ensure_dependencies = true,
  snapshot_path = fn.stdpath "config" .. "/snapshots", -- enable config snapshots
  enable = true, -- enable profiling via :PackerCompile profile=true
  threshold = 0, -- the amount in ms that a plugins load time must be over for it to be included in the profile
  max_jobs = 20, -- Limit the number of simultaneous jobs. nil means no limit. Set to 20 in order to prevent PackerSync form being "stuck" -> https://github.com/wbthomason/packer.nvim/issues/746
  -- Have packer use a popup window
  display = {
    open_fn = function()
      return require("packer.util").float({ border = "rounded" })
    end,
    prompt_border = "rounded", -- Border style of prompt popups.
  },
})

packer.startup(function(use)
  -- actual plugins list

  -- Plugin Mangager
  use({ "wbthomason/packer.nvim" }) -- Have packer manage itself

  if settings.theme == "gruvbox" then
    -- Gruvbox because it looks amazing
    use({ "ellisonleao/gruvbox.nvim", config = get_config("gruvbox") })
  else
    -- Gruvbox because it looks amazing
    use({ "ellisonleao/gruvbox.nvim", config = get_config("gruvbox") })
  end

  -- Lua Development
  use({ "nvim-lua/plenary.nvim" }) -- Useful lua functions used ny lots of plugins
  use({ "nvim-lua/popup.nvim" })
  use({ "christianchiarulli/lua-dev.nvim" })

  -- https://github.com/echasnovski/mini.nvim
  use({ "echasnovski/mini.nvim", config = get_config("mini") })

  -- https://github.com/akinsho/toggleterm.nvim
  use({ "akinsho/nvim-toggleterm.lua", config = get_config("toggleterm") })

  -- LSP
  -- https://github.com/jose-elias-alvarez/null-ls.nvim
  use({ "jose-elias-alvarez/null-ls.nvim" })
  --
  use({ "famiu/bufdelete.nvim" })
  use({ "neovim/nvim-lspconfig", config = get_config("lsp") })
  use({ "onsails/lspkind-nvim", requires = { "famiu/bufdelete.nvim" } })

  -- cmp setup
  use({
    "hrsh7th/nvim-cmp",
    requires = {
      "hrsh7th/cmp-nvim-lsp",
      "hrsh7th/cmp-buffer",
      "hrsh7th/cmp-path",
      "hrsh7th/cmp-cmdline",
      "f3fora/cmp-spell",
      "hrsh7th/cmp-calc",
      "lukas-reineke/cmp-rg",
      "hrsh7th/cmp-nvim-lsp-signature-help",
    },
    config = get_config("cmp"),
  })

  -- https://github.com/zbirenbaum/copilot.lua instead of github/copilot.vim
  -- use({ "github/copilot.vim" })
  use({ "zbirenbaum/copilot.lua", event = { "VimEnter" },
    module = "copilot",
    config = function()
    vim.defer_fn(function()
      require("config/copilot")
      end, 100)
    end,
  })
  use({ "zbirenbaum/copilot-cmp", config = get_config("cmp") })

  -- Rust
  use({ "christianchiarulli/rust-tools.nvim", branch = "modularize_and_inlay_rewrite" })
  use({ "Saecki/crates.nvim", after = { 'nvim-lua/plenary.nvim' }, config = get_config("crates") })

  -- Markdown
  use({ "iamcco/markdown-preview.nvim", run = "cd app && npm install", ft = "markdown" })

  -- nvim-navic
  use({ "SmiteshP/nvim-navic" })

  --
  use({ "folke/which-key.nvim", config = get_config("which-key") })

  -- golang setup
  -- ray-x/go.nvim
  use({ "ray-x/go.nvim", requires = "ray-x/guihua.lua", config = get_config("go"), ft = { "go" } })

  -- DAP for golang & python
  use({
    "mfussenegger/nvim-dap",
    requires = {
      "mfussenegger/nvim-dap-python",
      "leoluz/nvim-dap-go",
      "rcarriga/nvim-dap-ui",
      "theHamsta/nvim-dap-virtual-text",
    },
    config = function()
      require("config.dap").setup()
    end,
  })

  -- nvim-window
  use({ "https://gitlab.com/yorickpeterse/nvim-window.git", config = get_config("nvim-window"), })

  -- treesetters
    use({
    "nvim-treesitter/nvim-treesitter",
    config = get_config("treesitter"),
    run = ":TSUpdate",
  })

  use("nvim-treesitter/nvim-treesitter-textobjects")

  use("RRethy/nvim-treesitter-endwise")

  -- snippets
  use({ "rafamadriz/friendly-snippets" })
  use({
    "L3MON4D3/LuaSnip",
    requires = "saadparwaiz1/cmp_luasnip",
    config = get_config("luasnip"),
  })

  --
  use({ "williamboman/mason.nvim",
    requires = { "williamboman/mason-lspconfig.nvim", "WhoIsSethDaniel/mason-tool-installer.nvim" },
    config = get_config("mason"),
  })


end)

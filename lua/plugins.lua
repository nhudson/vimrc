local settings = require("user-conf")
local fn = vim.fn

local install_path = fn.stdpath("data") .. "/site/pack/packer/start/packer.nvim"

-- returns the require for use in `config` parameter of packer's use
-- expects the name of the config file
local function get_config(name)
  return string.format('require("config/%s")', name)
end

-- bootstrap packer if not installed
if fn.empty(fn.glob(install_path)) > 0 then
  fn.system({
    "git",
    "clone",
    "https://github.com/wbthomason/packer.nvim",
    install_path,
  })
  print("Installing packer...")
  vim.api.nvim_command("packadd packer.nvim")
end

-- initialize and configure packer
local packer = require("packer")

packer.init({
  enable = true, -- enable profiling via :PackerCompile profile=true
  threshold = 0, -- the amount in ms that a plugins load time must be over for it to be included in the profile
  max_jobs = 20, -- Limit the number of simultaneous jobs. nil means no limit. Set to 20 in order to prevent PackerSync form being "stuck" -> https://github.com/wbthomason/packer.nvim/issues/746
  -- Have packer use a popup window
  display = {
    open_fn = function()
      return require("packer.util").float({ border = "rounded" })
    end,
  },
})

packer.startup(function(use)
  -- actual plugins list
  use("wbthomason/packer.nvim")

  use({
    "nvim-telescope/telescope.nvim",
    requires = { { "nvim-lua/popup.nvim" }, { "nvim-lua/plenary.nvim" } },
    config = get_config("telescope"),
  })

  use({ "jvgrootveld/telescope-zoxide" })
  use({ "crispgm/telescope-heading.nvim" })
  use({ "nvim-telescope/telescope-symbols.nvim" })
  use({ "nvim-telescope/telescope-file-browser.nvim" })
  use({ "nvim-telescope/telescope-packer.nvim" })
  use({ "nvim-telescope/telescope-ui-select.nvim" })
  use({ "ptethng/telescope-makefile" })

  use({
    "nvim-neo-tree/neo-tree.nvim",
    branch = "v2.x",
    requires = {
      {
        -- only needed if you want to use the commands with "_with_window_picker" suffix
        "s1n7ax/nvim-window-picker",
        config = get_config("nvim-window-picker"),
      },
      "nvim-lua/plenary.nvim",
      "kyazdani42/nvim-web-devicons",
      "MunifTanjim/nui.nvim",
    },
    config = get_config("neotree"),
  })

  --use({ "kyazdani42/nvim-tree.lua", config = get_config("nvim-tree") })

  use({ "numToStr/Navigator.nvim", config = get_config("navigator") })

  use({ "windwp/nvim-autopairs", config = get_config("nvim-autopairs") })

  use({
    "nvim-treesitter/nvim-treesitter",
    config = get_config("treesitter"),
    run = ":TSUpdate",
  })

  use("nvim-treesitter/nvim-treesitter-textobjects")

  use("RRethy/nvim-treesitter-endwise")

  use({
    "hrsh7th/nvim-cmp",
    requires = {
      "hrsh7th/cmp-nvim-lsp",
      "hrsh7th/cmp-buffer",
      "hrsh7th/cmp-path",
      "hrsh7th/cmp-cmdline",
      "hrsh7th/cmp-calc",
      "lukas-reineke/cmp-rg",
      "hrsh7th/cmp-nvim-lsp-signature-help",
    },
    config = get_config("cmp"),
  })

  use({ "rafamadriz/friendly-snippets" })
  use({
    "L3MON4D3/LuaSnip",
    requires = "saadparwaiz1/cmp_luasnip",
    config = get_config("luasnip"),
  })

  use({
    "TimUntersberger/neogit",
    requires = {
      "nvim-lua/plenary.nvim",
      {
        "sindrets/diffview.nvim",
        cmd = {
          "DiffviewOpen",
          "DiffviewClose",
          "DiffviewToggleFiles",
          "DiffviewFocusFiles",
        },
        config = get_config("diffview"),
      },
    },
    cmd = "Neogit",
    config = get_config("neogit"),
  })

  use({ "f-person/git-blame.nvim", config = get_config("git-blame") })

  use({
    "lewis6991/gitsigns.nvim",
    requires = { "nvim-lua/plenary.nvim" },
    config = get_config("gitsigns"),
  })

  use({ "tpope/vim-fugitive" }) -- yeah this is not lua but one of the best Vim plugins ever

  use("p00f/nvim-ts-rainbow")

  use({
    "kevinhwang91/nvim-bqf",
    requires = {
      "junegunn/fzf",
      module = "nvim-bqf",
    },
    ft = "qf",
    config = get_config("nvim-bqf"),
  })

  use({ "neovim/nvim-lspconfig", config = get_config("lsp") })

  use({ "onsails/lspkind-nvim" })

  use({
    "jose-elias-alvarez/null-ls.nvim",
    requires = { { "nvim-lua/plenary.nvim" } },
    config = get_config("null-ls"),
  })

  use({
    "simrat39/symbols-outline.nvim",
    cmd = { "SymbolsOutline" },
    config = get_config("symbols"),
  })

  use({
    "lukas-reineke/indent-blankline.nvim",
    event = "BufReadPre",
    config = get_config("indent-blankline"),
  })

  use({
    "akinsho/nvim-toggleterm.lua",
    config = get_config("toggleterm"),
  })

  -- TODO: switch to https://github.com/folke/todo-comments.nvim ?
  use({
    "folke/todo-comments.nvim",
    requires = "nvim-lua/plenary.nvim",
    config = get_config("todo"),
  })

  use({ "ahmedkhalf/project.nvim", config = get_config("project") })

  use({ "folke/which-key.nvim", config = get_config("which-key") })

  use({ "junegunn/vim-easy-align", cmd = "EasyAlign" }) -- no lua alternative, https://github.com/Vonr/align.nvim not working for me

  use({ "rhysd/vim-grammarous", cmd = "GrammarousCheck" })

  use({ "RRethy/vim-illuminate", config = get_config("illuminate") })

  --use({
  --  "ptzz/lf.vim",
  --  requires = "voldikss/vim-floaterm",
  --  config = get_config("lf"),
  --})

  if settings.theme == "gruvbox" then
    use({ "ellisonleao/gruvbox.nvim", config = get_config("gruvbox") })
  elseif settings.theme == "gruvbox-flat" then
    use({ "eddyekofo94/gruvbox-flat.nvim", config = get_config("gruvbox-flat") })
  elseif settings.theme == "tundra" then
    use({ "sam4llis/nvim-tundra", config = get_config("tundra") })
  else
    use({ "ellisonleao/gruvbox.nvim", config = get_config("gruvbox") })
  end

  use({ "tweekmonster/startuptime.vim" })

  use({ "ray-x/go.nvim", requires = "ray-x/guihua.lua", config = get_config("go"), ft = { "go" } })

  use({ "LudoPinelli/comment-box.nvim", config = get_config("comment-box") })

  use({ "rcarriga/nvim-notify", config = get_config("notify") })

  use({ "echasnovski/mini.nvim", branch = "stable", config = get_config("mini") })

  use({
    "waylonwalker/Telegraph.nvim",
    config = function()
      require("telegraph").setup({})
    end,
  })

  use({ "edluffy/specs.nvim", config = get_config("specs") })

  use({ "mfussenegger/nvim-ts-hint-textobject" })

  use({
    "goolord/alpha-nvim",
    requires = { "kyazdani42/nvim-web-devicons" },
    config = get_config("alpha-nvim"),
  })

  use({ "SmiteshP/nvim-navic" })

  use({
    "j-hui/fidget.nvim",
    config = function()
      require("fidget").setup({})
    end,
  })

  use({
    "kevinhwang91/nvim-ufo",
    requires = "kevinhwang91/promise-async",
    config = function()
      require("ufo").setup()
    end,
  })

  use({
    "https://gitlab.com/yorickpeterse/nvim-pqf.git",
    config = function()
      require("pqf").setup()
    end,
  })

  use({ "vimpostor/vim-tpipeline", disable = settings.disable_tmux_statusline_integration })

  use({
    "anuvyklack/hydra.nvim",
    requires = "anuvyklack/keymap-layer.nvim", -- needed only for pink hydras
    config = get_config("hydra"),
  })

  use({
    "windwp/nvim-ts-autotag",
    config = function()
      require("nvim-ts-autotag").setup()
    end,
  })

  use({
    "williamboman/mason.nvim",
    requires = { "williamboman/mason-lspconfig.nvim", "WhoIsSethDaniel/mason-tool-installer.nvim" },
    config = get_config("mason"),
  })

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

  use({
    "max397574/colortils.nvim",
    cmd = "Colortils",
    config = function()
      require("colortils").setup()
    end,
  })

  use({
    "aarondiel/spread.nvim",
    after = "nvim-treesitter",
    config = get_config("spread"),
  })

  -- NOTE: use https://github.com/Akianonymus/nvim-colorizer.lua ?
  -- NOTE: use https://github.com/NvChad/nvim-colorizer.lua ?
  use({
    "norcalli/nvim-colorizer.lua",
    ft = { "scss", "css", "html" },
    config = function()
      require("colorizer").setup()
    end,
    disable = settings.disable_colorizer,
  })

  -- Markdown
  use({ "iamcco/markdown-preview.nvim", run = "cd app && npm install", ft = "markdown" })

  -- Rust
  use({ "simrat39/rust-tools.nvim" })
  --use({ "christianchiarulli/rust-tools.nvim", branch = "modularize_and_inlay_rewrite" })
  --use({ "Saecki/crates.nvim", after = { "nvim-lua/plenary.nvim" }, config = get_config("crates") })

  -- Install Github Copilot
  use({ "github/copilot.vim", config = get_config("copilot") })
  --  use({
  --    "zbirenbaum/copilot.lua",
  --    event = { "VimEnter" },
  --    config = function()
  --      vim.defer_fn(function()
  --        require("config.copilot")
  --      end, 100)
  --    end,
  --  })
  --  use({
  --    "zbirenbaum/copilot-cmp",
  --    after = "copilot.lua",
  --    config = function()
  --      require("copilot_cmp").setup()
  --    end,
  --  })
end)

-- TODO: ????
-- use {"lukas-reineke/headlines.nvim", config = get_config("headlines")}
-- https://github.com/glepnir/lspsaga.nvim
-- use 'glepnir/lspsaga.nvim'
-- TODO:
-- use({
--   "someone-stole-my-name/yaml-companion.nvim",
--   requires = {
--     { "neovim/nvim-lspconfig" },
--     { "nvim-lua/plenary.nvim" },
--     { "nvim-telescope/telescope.nvim" },
--   },
--   config = function()
--     require("telescope").load_extension("yaml_schema")
--   end,
-- })

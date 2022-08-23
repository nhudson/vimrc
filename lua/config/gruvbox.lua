local gruvbox = require("gruvbox")
local o = vim.opt

gruvbox.setup({
  undercurl = true,
  underline = true,
  bold = true,
  italic = true,
  strikethrough = true,
  invert_selection = false,
  invert_signs = false,
  invert_tabline = false,
  invert_intend_guides = false,
  inverse = true, -- invert background for search, diffs, statuslines and errors
  contrast = "", -- can be "hard", "soft" or empty string
  overrides = {},
})
-- set dark backgroud
o.background = "dark"
-- load colorscheme
vim.cmd("colorscheme gruvbox")

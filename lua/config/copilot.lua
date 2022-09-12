-- use this only with https://github.com/github/copilot.vim
vim.g.copilot_filetypes = {
  ["*"] = false,
}

vim.cmd [[
  imap <silent><script><expr> <C-A> copilot#Accept("\<CR>")
  let g:copilot_no_tab_map = v:true
]]

-- setup zbirenbaum/copilot.lua
--local copilot = require("copilot")
--
--copilot.setup({
--  panel = {
--    enabled = false,
--  },
--  copilot_node_command = vim.fn.expand("$HOME") .. "/Downloads/node-v16.16.0/bin/node",
--  ft_disable = { "markdown" },
--  server_opts_overrrides = {
--    -- trace = "verbose"
--    settings = {
--      advanced = {
--        -- listCount = 10, -- #completions for panel
--        inlineSuggestCount = 3, -- #completions for getCompletions
--      },
--    },
--  },
--})

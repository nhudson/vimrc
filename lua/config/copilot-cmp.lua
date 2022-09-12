-- setup zbirenbaum/copilot-cmp.lua
local copilot_cmp = require("copilot_cmp")

copilot_cmp.setup({
  method = "getCompletionsCycling",
  force_autofmt = false,
  formatters = {
    label = require("copilot_cmp.format").format_label_text,
    insert_text = require("copilot_cmp.format").format_label_text,
    preview = require("copilot_cmp.format").deindent,
  },
})

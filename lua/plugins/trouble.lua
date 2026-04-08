-- 诊断列表
return {
  "folke/trouble.nvim",
  cmd = "Trouble",
  opts = {},
  keys = {
    { ";xx", "<cmd>Trouble diagnostics toggle<cr>", desc = "诊断列表" },
    { ";xX", "<cmd>Trouble diagnostics toggle filter.buf=0<cr>", desc = "当前文件诊断" },
    { ";xl", "<cmd>Trouble loclist toggle<cr>", desc = "Location List" },
    { ";xq", "<cmd>Trouble qflist toggle<cr>", desc = "Quickfix List" },
  },
}
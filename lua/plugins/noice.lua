-- 命令行美化
return {
  "folke/noice.nvim",
  event = "VeryLazy",
  dependencies = {
    "MunifTanjim/nui.nvim",
    "rcarriga/nvim-notify",
  },
  opts = {
    lsp = {
      -- 覆盖 markdown 渲染
      override = {
        ["vim.lsp.util.convert_input_to_markdown_lines"] = true,
        ["vim.lsp.util.stylize_markdown"] = true,
        ["cmp.entry.get_documentation"] = true,
      },
    },
    -- 命令行
    cmdline = {
      view = "cmdline_popup", -- 弹窗样式
      format = {
        cmdline = { pattern = "^:", icon = "", lang = "vim" },
        search_down = { kind = "search", pattern = "^/", icon = " ", lang = "regex" },
        search_up = { kind = "search", pattern = "^%?", icon = " ", lang = "regex" },
        filter = { pattern = "^:%s*!", icon = "$", lang = "bash" },
        lua = { pattern = "^:%s*lua%s+", icon = "", lang = "lua" },
        help = { pattern = "^:%s*he?l?p?%s+", icon = "" },
      },
    },
    presets = {
      bottom_search = true, -- 底部搜索栏
      command_palette = true, -- 命令面板样式
      long_message_to_split = true, -- 长消息发送到 split
      inc_rename = true, -- 增量重命名
      lsp_doc_border = true, -- LSP 文档边框
    },
  },
}
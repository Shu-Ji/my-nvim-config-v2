-- 工具插件
return {
  -- Mason: LSP/DAP/Linter/Formatters 安装器
  {
    "williamboman/mason.nvim",
    build = ":MasonUpdate",
    opts = {},
  },
  {
    "williamboman/mason-lspconfig.nvim",
    dependencies = { "neovim/nvim-lspconfig" },
    opts = {
      ensure_installed = {
        "ts_ls",       -- TypeScript/JavaScript
        "pyright",     -- Python
        "rust_analyzer", -- Rust
        "lua_ls",      -- Lua
        "tailwindcss", -- Tailwind CSS
        "jsonls",      -- JSON
      },
    },
  },

  -- DAP (调试)
  {
    "mfussenegger/nvim-dap",
    keys = {
      { ";dd", "<cmd>DapToggleBreakpoint<cr>", desc = "断点" },
      { ";dc", "<cmd>DapContinue<cr>", desc = "继续" },
      { ";ds", "<cmd>DapStepOver<cr>", desc = "单步" },
    },
  },
  {
    "rcarriga/nvim-dap-ui",
    dependencies = { "mfussenegger/nvim-dap", "nvim-neotest/nvim-nio" },
    opts = {},
    keys = {
      { ";du", function() require("dapui").toggle() end, desc = "调试 UI" },
    },
  },

  -- 常用依赖
  { "nvim-lua/plenary.nvim", lazy = true },
  { "nvim-tree/nvim-web-devicons", lazy = true },
}
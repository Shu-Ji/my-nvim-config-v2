-- 编辑器增强
return {
  -- 注释
  {
    "numToStr/Comment.nvim",
    keys = {
      { ";<Space>", mode = { "n", "x" }, desc = "切换注释" },
      { "gc", mode = { "n", "x" }, desc = "行注释" },
      { "gb", mode = { "n", "x" }, desc = "块注释" },
    },
    opts = {
      mappings = {
        basic = false,
        extra = false,
      },
    },
    config = function(_, opts)
      local comment = require("Comment")
      comment.setup(opts)
      local ft = require("Comment.ft")
      ft.set("lua", { "--%s", "--[[%s]]" })

      -- 自定义快捷键
      vim.keymap.set("n", ";<Space>", function()
        return require("Comment.api").toggle.linewise.current()
      end, { desc = "切换注释" })
      vim.keymap.set("x", ";<Space>", function()
        local esc = vim.api.nvim_replace_termcodes("<ESC>", true, false, true)
        vim.api.nvim_feedkeys(esc, "nx", false)
        return require("Comment.api").toggle.linewise(vim.fn.visualmode())
      end, { desc = "切换注释" })
    end,
  },

  -- Git 状态
  {
    "lewis6991/gitsigns.nvim",
    event = { "BufReadPre", "BufNewFile" },
    opts = {
      signs = {
        add = { text = "+" },
        change = { text = "~" },
        delete = { text = "_" },
        topdelete = { text = "‾" },
        changedelete = { text = "~" },
      },
      current_line_blame = true,
      current_line_blame_opts = {
        virt_text_pos = "eol",
      },
    },
    keys = {
      { ";g", group = "Git" },
      { ";gs", "<cmd>Gitsigns stage_hunk<cr>", desc = "暂存 Hunk" },
      { ";gr", "<cmd>Gitsigns reset_hunk<cr>", desc = "重置 Hunk" },
      { ";gu", "<cmd>Gitsigns undo_stage_hunk<cr>", desc = "撤销暂存" },
      { ";gp", "<cmd>Gitsigns preview_hunk<cr>", desc = "预览 Hunk" },
      { ";gb", "<cmd>Gitsigns blame_line<cr>", desc = "Blame" },
    },
  },

  -- 代码格式化
  {
    "stevearc/conform.nvim",
    event = { "BufWritePre" },
    cmd = "ConformInfo",
    opts = {
      formatters_by_ft = {
        javascript = { "prettier" },
        javascriptreact = { "prettier" },
        typescript = { "prettier" },
        typescriptreact = { "prettier" },
        vue = { "prettier" },
        css = { "prettier" },
        scss = { "prettier" },
        html = { "prettier" },
        json = { "prettier" },
        yaml = { "prettier" },
        markdown = { "prettier" },
        python = { "ruff_format", "ruff_fix" },
        rust = { "rustfmt" },
        lua = { "stylua" },
      },
      format_on_save = {
        timeout_ms = 500,
        lsp_fallback = true,
      },
    },
  },

  -- 快速跳转
  {
    "folke/flash.nvim",
    event = "VeryLazy",
    opts = {},
    keys = {
      { "s", mode = { "n", "x", "o" }, function() require("flash").jump() end, desc = "快速跳转 (当前屏幕)" },
      { "S", mode = { "n", "x", "o" }, function() require("flash").treesitter() end, desc = "Treesitter 跳转" },
      { ";s", mode = { "n", "x", "o" }, function() require("flash").jump({ search = { mode = "search", max_length = 0 } }) end, desc = "搜索跳转 (全文件)" },
    },
  },

  -- 代码大纲
  {
    "stevearc/aerial.nvim",
    opts = {
      layout = { default_direction = "right" },
    },
    dependencies = {
      "nvim-treesitter/nvim-treesitter",
      "nvim-tree/nvim-web-devicons",
    },
  },

  -- 自动括号
  {
    "windwp/nvim-autopairs",
    event = "InsertEnter",
    opts = {
      check_ts = true,
    },
  },

  -- 环绕操作
  {
    "kylechui/nvim-surround",
    version = "*",
    event = "VeryLazy",
    opts = {},
  },

  -- TODO 高亮
  {
    "folke/todo-comments.nvim",
    dependencies = "nvim-lua/plenary.nvim",
    opts = {},
  },

  -- 终端
  {
    "akinsho/toggleterm.nvim",
    version = "*",
    opts = {
      size = 20,
      open_mapping = [[<c-\>]],
      direction = "float",
      float_opts = {
        border = "curved",
      },
    },
  },

  -- 撤销历史可视化
  {
    "mbbill/undotree",
    keys = {
      { ";u", "<cmd>UndotreeToggle<cr>", desc = "撤销历史" },
    },
  },

  -- 编辑器配置支持
  {
    "editorconfig/editorconfig-vim",
    event = { "BufReadPre", "BufNewFile" },
  },
}
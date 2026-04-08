-- 插件配置
require("lazy").setup({
  -- 主题
  {
    "folke/tokyonight.nvim",
    lazy = false,
    priority = 1000,
    opts = {
      style = "night",
      transparent = false,
      styles = {
        sidebars = "dark",
        floats = "dark",
      },
    },
  },

  -- LSP 配置
  {
    "neovim/nvim-lspconfig",
    dependencies = {
      "hrsh7th/cmp-nvim-lsp",
      { "j-hui/fidget.nvim", opts = {} },
    },
    config = function()
      require("config.lsp")
    end,
  },

  -- 补全
  {
    "hrsh7th/nvim-cmp",
    event = "InsertEnter",
    dependencies = {
      "hrsh7th/cmp-nvim-lsp",
      "hrsh7th/cmp-buffer",
      "hrsh7th/cmp-path",
      "hrsh7th/cmp-cmdline",
      "saadparwaiz1/cmp_luasnip",
      {
        "L3MON4D3/LuaSnip",
        build = "make install_jsregexp",
        dependencies = {
          "rafamadriz/friendly-snippets",
          config = function()
            require("luasnip.loaders.from_vscode").lazy_load()
          end,
        },
      },
    },
    config = function()
      require("config.cmp")
    end,
  },

  -- Treesitter
  {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    config = function()
      require("config.treesitter")
    end,
  },

  -- 文件树 (类似 VSCode)
  {
    "nvim-neo-tree/neo-tree.nvim",
    branch = "v3.x",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-tree/nvim-web-devicons",
      "MunifTanjim/nui.nvim",
    },
    cmd = "Neotree",
    keys = {
      { ";n", "<cmd>Neotree toggle<cr>", desc = "文件树" },
      { ";N", "<cmd>Neotree reveal<cr>", desc = "定位当前文件" },
    },
    opts = {
      filesystem = {
        window = {
          mappings = {
            ["h"] = "toggle_hidden",
            ["l"] = "open",
          },
        },
        filtered_items = {
          visible = false,
          hide_dotfiles = false,
          hide_gitignored = true,
        },
      },
    },
  },

  -- 模糊查找 (类似 VSCode Cmd+P)
  {
    "nvim-telescope/telescope.nvim",
    branch = "0.1.x",
    dependencies = {
      "nvim-lua/plenary.nvim",
      {
        "nvim-telescope/telescope-fzf-native.nvim",
        build = "make",
        cond = function()
          return vim.fn.executable("make") == 1
        end,
      },
    },
    config = function()
      require("config.telescope")
    end,
  },

  -- 状态栏
  {
    "nvim-lualine/lualine.nvim",
    event = "VeryLazy",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    opts = {
      options = {
        theme = "tokyonight",
        component_separators = { left = "|", right = "|" },
        section_separators = { left = "", right = "" },
      },
      sections = {
        lualine_a = { "mode" },
        lualine_b = { "branch", "diff" },
        lualine_c = { { "filename", path = 1 } },
        lualine_x = { "diagnostics", "encoding", "filetype" },
        lualine_y = { "progress" },
        lualine_z = { "location" },
      },
    },
  },

  -- Buffer 标签页 (顶部)
  {
    "akinsho/bufferline.nvim",
    version = "*",
    dependencies = "nvim-tree/nvim-web-devicons",
    opts = {
      options = {
        mode = "tabs",
        diagnostics = "nvim_lsp",
        separator_style = "slant",
        show_buffer_close_icons = false,
        show_close_icon = false,
      },
    },
    keys = {
      { "<Left>", "<cmd>BufferLineCyclePrev<cr>", desc = "上一个 Tab" },
      { "<Right>", "<cmd>BufferLineCycleNext<cr>", desc = "下一个 Tab" },
      { ";bd", "<cmd>tabclose<cr>", desc = "关闭 Tab" },
      { ";tn", "<cmd>tabnew<cr>", desc = "新建 Tab" },
    },
  },

  -- 快捷键提示
  {
    "folke/which-key.nvim",
    event = "VeryLazy",
    init = function()
      vim.o.timeout = true
      vim.o.timeoutlen = 300
    end,
    opts = {
      plugins = { spelling = true },
      win = { border = "single" },
    },
    config = function()
      local wk = require("which-key")
      wk.add({
        { ";", group = "leader" },
        { ";f", group = "查找" },
        { ";g", group = "Git" },
        { ";l", group = "LSP" },
        { ";t", group = "Tab/Toggle" },
        { ";d", desc = "跳转定义", cmd = "<cmd>lua vim.lsp.buf.definition()<cr>" },
        { ";r", desc = "重命名", cmd = "<cmd>lua vim.lsp.buf.rename()<cr>" },
        { ";R", desc = "引用", cmd = "<cmd>Telescope lsp_references<cr>" },
        { ";a", desc = "代码操作", cmd = "<cmd>lua vim.lsp.buf.code_action()<cr>" },
        { ";o", desc = "文档大纲", cmd = "<cmd>AerialToggle!<cr>" },
        { ";w", desc = "保存", cmd = "<cmd>w<cr>" },
        { ";q", desc = "退出", cmd = "<cmd>q<cr>" },
        { ";/", desc = "取消高亮", cmd = "<cmd>nohlsearch<cr>" },
        { ";p", desc = "查找文件", cmd = "<cmd>Telescope find_files<cr>" },
        { ";F", desc = "全局搜索", cmd = "<cmd>Telescope live_grep<cr>" },
        { ";b", desc = "查找 Buffer", cmd = "<cmd>Telescope buffers<cr>" },
        { ";h", desc = "帮助", cmd = "<cmd>Telescope help_tags<cr>" },
        { ";s", desc = "重载配置", cmd = "<cmd>source $MYVIMRC<cr>" },
        { ";ee", desc = "编辑配置", cmd = "<cmd>e $MYVIMRC<cr>" },
        { ";m", desc = "格式化", cmd = "<cmd>lua require('conform').format()<cr>" },
        { ";k", desc = "上一个诊断", cmd = "<cmd>lua vim.diagnostic.goto_prev()<cr>" },
        { ";j", desc = "下一个诊断", cmd = "<cmd>lua vim.diagnostic.goto_next()<cr>" },
        { ";E", desc = "诊断列表", cmd = "<cmd>Telescope diagnostics<cr>" },
        { ";;", desc = "快捷键列表", cmd = "<cmd>WhichKey<cr>" },
      })
    end,
  },

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

  -- 快速跳转 (类似 JetBrains 的 Search Everywhere)
  {
    "folke/flash.nvim",
    event = "VeryLazy",
    opts = {},
    keys = {
      { ";j", mode = { "n", "x", "o" }, function() require("flash").jump() end, desc = "跳转" },
      { ";J", mode = { "n", "o" }, function() require("flash").treesitter() end, desc = "Treesitter 跳转" },
    },
  },

  -- 代码大纲 (类似 JetBrains 的 Structure View)
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

  -- 缩进线
  {
    "lukas-reineke/indent-blankline.nvim",
    main = "ibl",
    opts = {
      indent = { char = "│" },
      scope = { enabled = true },
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

  -- 环绕操作 (替代 vim-surround)
  {
    "kylechui/nvim-surround",
    version = "*",
    event = "VeryLazy",
    opts = {},
  },

  -- 括号高亮
  {
    "HiPhish/rainbow-delimiters.nvim",
    event = "VeryLazy",
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

  -- 通知美化
  {
    "rcarriga/nvim-notify",
    opts = {
      timeout = 3000,
      max_height = function()
        return math.floor(vim.o.lines * 0.75)
      end,
      max_width = function()
        return math.floor(vim.o.columns * 0.75)
      end,
    },
    config = function(_, opts)
      vim.notify = require("notify").notify
      require("notify").setup(opts)
    end,
  },

  -- 常用依赖
  { "nvim-lua/plenary.nvim", lazy = true },
  { "nvim-tree/nvim-web-devicons", lazy = true },

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
        "typescript-language-server",
        "pyright",
        "rust-analyzer",
        "lua-language-server",
        "tailwindcss-language-server",
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

  -- 惰载插件本身
  { "folke/lazy.nvim", version = "*" },
})
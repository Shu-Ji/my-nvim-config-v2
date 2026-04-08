-- UI 插件
return {
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
        { ";w", desc = "保存", cmd = "<cmd>w<cr>" },
        { ";q", desc = "退出", cmd = "<cmd>q<cr>" },
        { ";/", desc = "取消高亮", cmd = "<cmd>nohlsearch<cr>" },
        { ";p", desc = "查找文件", cmd = "<cmd>Telescope find_files<cr>" },
        { ";F", desc = "全局搜索", cmd = "<cmd>Telescope live_grep<cr>" },
        { ";b", desc = "查找 Buffer", cmd = "<cmd>Telescope buffers<cr>" },
        { ";h", desc = "帮助", cmd = "<cmd>Telescope help_tags<cr>" },
        { ";s", desc = "重载配置", cmd = "<cmd>source $MYVIMRC<cr>" },
        { ";ee", desc = "编辑配置", cmd = "<cmd>e $MYVIMRC<cr>" },
        { ";;", desc = "快捷键列表", cmd = "<cmd>WhichKey<cr>" },
      })
    end,
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

  -- 括号高亮
  {
    "HiPhish/rainbow-delimiters.nvim",
    event = "VeryLazy",
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
}
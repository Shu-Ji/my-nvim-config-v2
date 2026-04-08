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
    lazy = false, -- 禁用懒加载
    dependencies = "nvim-tree/nvim-web-devicons",
    opts = {
      options = {
        mode = "buffers", -- 显示所有 buffer
        diagnostics = "nvim_lsp",
        separator_style = "slant",
        show_buffer_close_icons = true,
        show_close_icon = false,
        offsets = {
          {
            filetype = "neo-tree",
            text = "文件",
            text_align = "left",
            separator = true,
          },
        },
      },
    },
    keys = {
      { "<Tab>", "<cmd>BufferLineCycleNext<cr>", desc = "下一个 Buffer" },
      { "<S-Tab>", "<cmd>BufferLineCyclePrev<cr>", desc = "上一个 Buffer" },
      { ";bd", "<cmd>bdelete<cr>", desc = "关闭 Buffer" },
      { ";bl", "<cmd>BufferLineCloseRight<cr>", desc = "关闭右侧 Buffer" },
      { ";bh", "<cmd>BufferLineCloseLeft<cr>", desc = "关闭左侧 Buffer" },
      { ";bp", "<cmd>BufferLineTogglePin<cr>", desc = "固定 Buffer" },
      { ";1", "<cmd>BufferLineGoToBuffer 1<cr>", desc = "跳转到 Buffer 1" },
      { ";2", "<cmd>BufferLineGoToBuffer 2<cr>", desc = "跳转到 Buffer 2" },
      { ";3", "<cmd>BufferLineGoToBuffer 3<cr>", desc = "跳转到 Buffer 3" },
      { ";4", "<cmd>BufferLineGoToBuffer 4<cr>", desc = "跳转到 Buffer 4" },
      { ";5", "<cmd>BufferLineGoToBuffer 5<cr>", desc = "跳转到 Buffer 5" },
      { ";6", "<cmd>BufferLineGoToBuffer 6<cr>", desc = "跳转到 Buffer 6" },
      { ";7", "<cmd>BufferLineGoToBuffer 7<cr>", desc = "跳转到 Buffer 7" },
      { ";8", "<cmd>BufferLineGoToBuffer 8<cr>", desc = "跳转到 Buffer 8" },
      { ";9", "<cmd>BufferLineGoToBuffer 9<cr>", desc = "跳转到 Buffer 9" },
      { ";$", "<cmd>BufferLineGoToBuffer -1<cr>", desc = "跳转到最后 Buffer" },
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
        { ";g", group = "Git" },
        { ";x", group = "诊断" },
        { ";b", group = "Buffer" },
        { ";w", desc = "保存", cmd = "<cmd>w<cr>" },
        { ";q", desc = "退出全部", cmd = "<cmd>qa<cr>" },
        { ";/", desc = "取消高亮", cmd = "<cmd>nohlsearch<cr>" },
        { ";p", desc = "查找文件", cmd = "<cmd>Telescope find_files<cr>" },
        { ";F", desc = "全局搜索", cmd = "<cmd>Telescope live_grep<cr>" },
        { ";h", desc = "帮助", cmd = "<cmd>Telescope help_tags<cr>" },
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
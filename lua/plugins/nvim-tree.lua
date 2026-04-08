-- 文件树 (左侧文件浏览器)
return {
  "nvim-tree/nvim-tree.lua",
  dependencies = { "nvim-tree/nvim-web-devicons" },
  lazy = false,
  config = function()
    require("nvim-tree").setup({
      view = {
        width = 35,
        side = "left",
        preserve_window_proportions = true,
      },
      renderer = {
        group_empty = true,
        highlight_git = true,
        full_name = true,
        indent_width = 2,
        indent_markers = {
          enable = true,
        },
        icons = {
          show = {
            file = true,
            folder = true,
            folder_arrow = true,
            git = true,
          },
        },
      },
      filters = {
        dotfiles = false,
        custom = { ".git", "node_modules", ".cache", "__pycache__", ".DS_Store" },
      },
      git = {
        enable = true,
        ignore = false,
      },
      actions = {
        open_file = {
          quit_on_open = false,
          resize_window = true,
          window_picker = {
            enable = true,
          },
        },
      },
    })

    -- 启动时自动打开，光标保持在文件 buffer
    vim.api.nvim_create_autocmd("VimEnter", {
      group = vim.api.nvim_create_augroup("NvimTreeOnEnter", { clear = true }),
      callback = function()
        vim.defer_fn(function()
          vim.cmd("NvimTreeOpen")
          vim.cmd("wincmd l") -- 光标移动到右侧窗口
        end, 100)
      end,
    })
  end,
  keys = {
    { ";e", "<cmd>NvimTreeToggle<cr>", desc = "文件树" },
    { ";o", "<cmd>NvimTreeFocus<cr>", desc = "聚焦文件树" },
    { ";E", "<cmd>NvimTreeFindFile<cr>", desc = "定位当前文件" },
    { "<F2>", "<cmd>NvimTreeToggle<cr>", desc = "文件树" },
  },
}
-- 文件树 (类似 VSCode)
return {
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
}
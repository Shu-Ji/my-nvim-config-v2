-- 文件树 (类似 VSCode)
return {
  "nvim-neo-tree/neo-tree.nvim",
  branch = "v3.x",
  dependencies = {
    "nvim-lua/plenary.nvim",
    "nvim-tree/nvim-web-devicons",
    "MunifTanjim/nui.nvim",
  },
  lazy = false, -- 禁用懒加载
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
  config = function(_, opts)
    require("neo-tree").setup(opts)
    -- 启动时自动打开文件树
    vim.api.nvim_create_autocmd("VimEnter", {
      group = vim.api.nvim_create_augroup("NeotreeOnEnter", { clear = true }),
      callback = function()
        -- 延迟执行确保 UI 加载完成
        vim.defer_fn(function()
          vim.cmd("Neotree show")
        end, 100)
      end,
    })
  end,
}
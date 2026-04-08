-- Telescope 配置
local telescope = require("telescope")
local actions = require("telescope.actions")
local builtin = require("telescope.builtin")

telescope.setup({
  defaults = {
    preview = {
      treesitter = false, -- 禁用 treesitter preview (Neovim 0.12 API 变化)
    },
    mappings = {
      i = {
        ["<C-j>"] = actions.move_selection_next,
        ["<C-k>"] = actions.move_selection_previous,
        ["<C-q>"] = actions.send_to_qflist,
        ["<Esc>"] = actions.close,
      },
      n = {
        ["q"] = actions.close,
      },
    },
    vimgrep_arguments = {
      "rg",
      "--color=never",
      "--no-heading",
      "--with-filename",
      "--line-number",
      "--column",
      "--smart-case",
      "--hidden",
      "--glob=!**/.git/*",
    },
    prompt_prefix = "> ",
    selection_caret = "> ",
    layout_config = {
      horizontal = { width = 0.9, height = 0.8 },
      vertical = { width = 0.9, height = 0.8 },
    },
  },
  extensions = {
    fzf = {
      fuzzy = true,
      override_generic_sorter = true,
      override_file_sorter = true,
    },
  },
  pickers = {
    find_files = {
      hidden = true,
      find_command = { "rg", "--files", "--hidden", "--glob", "!**/.git/*" },
    },
  },
})

-- 加载扩展
pcall(telescope.load_extension, "fzf")

-- 快捷键
vim.keymap.set("n", ";p", builtin.find_files, { desc = "查找文件" })
vim.keymap.set("n", ";F", builtin.live_grep, { desc = "全局搜索" })
vim.keymap.set("n", ";b", builtin.buffers, { desc = "查找 Buffer" })
vim.keymap.set("n", ";h", builtin.help_tags, { desc = "帮助" })
vim.keymap.set("n", ";o", builtin.oldfiles, { desc = "最近文件" })
vim.keymap.set("n", ";/", builtin.current_buffer_fuzzy_find, { desc = "当前文件搜索" })
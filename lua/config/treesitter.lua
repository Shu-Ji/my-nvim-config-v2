-- Treesitter 配置
require("nvim-treesitter.configs").setup({
  -- 安装的语言
  ensure_installed = {
    "bash",
    "css",
    "html",
    "javascript",
    "json",
    "lua",
    "markdown",
    "python",
    "rust",
    "scss",
    "typescript",
    "tsx",
    "vue",
    "yaml",
    "toml",
    "regex",
    "vim",
    "vimdoc",
  },

  -- 自动安装
  auto_install = true,

  -- 高亮
  highlight = {
    enable = true,
    additional_vim_regex_highlighting = false,
  },

  -- 缩进
  indent = {
    enable = true,
  },

  -- 选择
  incremental_selection = {
    enable = true,
    keymaps = {
      init_selection = "<CR>",
      node_incremental = "<CR>",
      scope_incremental = "<S-CR>",
      node_decremental = "<BS>",
    },
  },

  -- 上下文注释
  context_commentstring = {
    enable = true,
    enable_autocmd = false,
  },
})
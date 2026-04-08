-- 基础配置
vim.g.mapleader = ";"
vim.g.maplocalleader = ";"

-- 禁用不需要的 provider (Lua 生态不需要)
vim.g.loaded_ruby_provider = 0
vim.g.loaded_perl_provider = 0
vim.g.loaded_python3_provider = 0

-- 基础选项
local opt = vim.opt
opt.number = true
opt.relativenumber = true
opt.tabstop = 4
opt.shiftwidth = 4
opt.expandtab = true
opt.smartindent = true
opt.wrap = false
opt.ignorecase = true
opt.smartcase = true
opt.scrolloff = 8
opt.sidescrolloff = 8
opt.cursorline = true
opt.signcolumn = "yes"
opt.splitbelow = true
opt.splitright = true
opt.termguicolors = true
opt.timeoutlen = 300
opt.updatetime = 250
opt.undofile = true
opt.backup = false
opt.swapfile = false
opt.foldlevelstart = 99
opt.completeopt = "menu,menuone,noselect"
opt.cmdheight = 1
opt.list = true
opt.listchars = { tab = "» ", trail = "·", nbsp = "␣" }
opt.fillchars = { fold = " ", diff = " ", eob = " " }

-- 引导 lazy.nvim
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable",
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

-- 加载插件
require("lazy").setup("plugins", {
  install = { colorscheme = { "tokyonight" } },
  checker = { enabled = true },
  performance = {
    rtp = {
      disabled_plugins = {
        "gzip",
        "tarPlugin",
        "tohtml",
        "tutor",
        "zipPlugin",
      },
    },
  },
})

-- 主题 (插件加载后)
vim.cmd("colorscheme tokyonight")

-- 快捷键
require("config.keymaps")
-- 自动命令
require("config.autocmds")
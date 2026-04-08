-- Treesitter 配置 (新 API)

-- 安装 parsers
local parsers = {
  "bash",
  "css",
  "html",
  "javascript",
  "json",
  "lua",
  "markdown",
  "markdown_inline",
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
  "query",
}

-- 安装缺失的 parsers
local ts = require("nvim-treesitter")
local installed = ts.get_installed()
local to_install = {}
for _, parser in ipairs(parsers) do
  if not vim.list_contains(installed, parser) then
    table.insert(to_install, parser)
  end
end
if #to_install > 0 then
  ts.install(to_install)
end

-- 启用 treesitter 功能
vim.api.nvim_create_autocmd("FileType", {
  callback = function()
    local ft = vim.bo.filetype
    local lang = vim.treesitter.language.get_lang(ft) or ft
    local ok = pcall(vim.treesitter.language.inspect, lang)
    if ok then
      -- 高亮
      vim.treesitter.start()
      -- 折叠
      vim.wo.foldexpr = "v:lua.vim.treesitter.foldexpr()"
      vim.wo.foldmethod = "expr"
      -- 缩进
      vim.bo.indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
    end
  end,
})
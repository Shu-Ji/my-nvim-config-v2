-- LSP 配置
local lspconfig = require("lspconfig")
local util = lspconfig.util

-- 诊断符号
local signs = { Error = "✘", Warn = "⚠", Hint = "➤", Info = "i" }
for type, icon in pairs(signs) do
  local hl = "DiagnosticSign" .. type
  vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = hl })
end

-- 诊断配置
vim.diagnostic.config({
  virtual_text = true,
  signs = true,
  update_in_insert = false,
  underline = true,
  severity_sort = true,
  float = {
    border = "single",
    source = "always",
  },
})

-- LSP 键盘映射
local on_attach = function(client, bufnr)
  local map = function(keys, func, desc)
    vim.keymap.set("n", keys, func, { buffer = bufnr, desc = desc })
  end

  -- JetBrains 风格 LSP 快捷键
  map(";d", vim.lsp.buf.definition, "跳转定义")
  map(";D", vim.lsp.buf.declaration, "跳转声明")
  map(";i", vim.lsp.buf.implementation, "跳转实现")
  map(";t", vim.lsp.buf.type_definition, "跳转类型定义")
  map(";r", vim.lsp.buf.rename, "重命名")
  map(";a", vim.lsp.buf.code_action, "代码操作")
  map(";R", "<cmd>Telescope lsp_references<cr>", "查找引用")
  map(";s", "<cmd>Telescope lsp_document_symbols<cr>", "文档符号")
  map(";S", "<cmd>Telescope lsp_dynamic_workspace_symbols<cr>", "工作区符号")
  map("K", vim.lsp.buf.hover, "文档悬浮")
  map(";k", vim.diagnostic.goto_prev, "上一个诊断")
  map(";j", vim.diagnostic.goto_next, "下一个诊断")
  map(";E", "<cmd>Telescope diagnostics bufnr=0<cr>", "诊断列表")
  map(";m", function()
    require("conform").format({ bufnr = bufnr })
  end, "格式化")

  -- 禁用某些客户端的格式化 (使用 conform.nvim)
  client.server_capabilities.documentFormattingProvider = false
  client.server_capabilities.documentRangeFormattingProvider = false
end

-- 补全能力
local capabilities = require("cmp_nvim_lsp").default_capabilities()

-- 语言服务器配置
lspconfig.lua_ls.setup({
  on_attach = on_attach,
  capabilities = capabilities,
  settings = {
    Lua = {
      diagnostics = { globals = { "vim" } },
      workspace = { library = vim.api.nvim_get_runtime_file("", true) },
      telemetry = { enable = false },
    },
  },
})

lspconfig.ts_ls.setup({
  on_attach = on_attach,
  capabilities = capabilities,
  filetypes = { "javascript", "javascriptreact", "typescript", "typescriptreact", "vue" },
  root_dir = util.root_pattern("package.json", "tsconfig.json", "jsconfig.json", ".git"),
})

lspconfig.pyright.setup({
  on_attach = on_attach,
  capabilities = capabilities,
  settings = {
    python = {
      analysis = {
        typeCheckingMode = "basic",
        autoSearchPaths = true,
      },
    },
  },
})

lspconfig.rust_analyzer.setup({
  on_attach = on_attach,
  capabilities = capabilities,
  settings = {
    ["rust-analyzer"] = {
      checkOnSave = {
        command = "clippy",
      },
    },
  },
})

lspconfig.tailwindcss.setup({
  on_attach = on_attach,
  capabilities = capabilities,
  filetypes = { "html", "css", "scss", "javascriptreact", "typescriptreact", "vue" },
})
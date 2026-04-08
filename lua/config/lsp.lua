-- LSP 配置 (Neovim 0.12+ 新 API)

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

-- LSP Attach 自动命令 (替代 on_attach)
vim.api.nvim_create_autocmd("LspAttach", {
  group = vim.api.nvim_create_augroup("LspKeymaps", { clear = true }),
  callback = function(ev)
    local bufnr = ev.buf
    local client = vim.lsp.get_client_by_id(ev.data.client_id)

    local map = function(keys, func, desc)
      vim.keymap.set("n", keys, func, { buffer = bufnr, desc = desc })
    end

    -- LSP 快捷键
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
    if client then
      client.server_capabilities.documentFormattingProvider = false
      client.server_capabilities.documentRangeFormattingProvider = false
    end
  end,
})

-- 补全能力
local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities = vim.tbl_deep_extend("force", capabilities, require("cmp_nvim_lsp").default_capabilities())

-- 使用新的 vim.lsp.config API
vim.lsp.config("lua_ls", {
  cmd = { "lua-language-server" },
  filetypes = { "lua" },
  root_markers = { ".luarc.json", ".luarc.jsonc", ".git" },
  capabilities = capabilities,
  settings = {
    Lua = {
      diagnostics = { globals = { "vim" } },
      workspace = { library = vim.api.nvim_get_runtime_file("", true) },
      telemetry = { enable = false },
    },
  },
})

vim.lsp.config("ts_ls", {
  cmd = { "typescript-language-server", "--stdio" },
  filetypes = { "javascript", "javascriptreact", "typescript", "typescriptreact", "vue" },
  root_markers = { "package.json", "tsconfig.json", "jsconfig.json", ".git" },
  capabilities = capabilities,
})

vim.lsp.config("pyright", {
  cmd = { "pyright-langserver", "--stdio" },
  filetypes = { "python" },
  root_markers = { "pyrightconfig.json", "pyproject.toml", ".git" },
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

vim.lsp.config("rust_analyzer", {
  cmd = { "rust-analyzer" },
  filetypes = { "rust" },
  root_markers = { "Cargo.toml", ".git" },
  capabilities = capabilities,
  settings = {
    ["rust-analyzer"] = {
      check = {
        command = "clippy",
      },
    },
  },
})

vim.lsp.config("tailwindcss", {
  cmd = { "tailwindcss-language-server", "--stdio" },
  filetypes = { "html", "css", "scss", "javascriptreact", "typescriptreact", "vue" },
  root_markers = { "tailwind.config.js", "tailwind.config.ts", "postcss.config.js", ".git" },
  capabilities = capabilities,
})

-- 启用所有配置的 LSP
vim.lsp.enable({ "lua_ls", "ts_ls", "pyright", "rust_analyzer", "tailwindcss" })
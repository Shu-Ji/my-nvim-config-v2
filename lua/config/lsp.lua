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

-- LSP 快捷键和格式化禁用
vim.api.nvim_create_autocmd("LspAttach", {
  group = vim.api.nvim_create_augroup("LspKeymaps", { clear = true }),
  callback = function(ev)
    local bufnr = ev.buf
    local client = vim.lsp.get_client_by_id(ev.data.client_id)

    -- LSP 快捷键
    local opts = { buffer = bufnr }
    vim.keymap.set("n", "gd", vim.lsp.buf.definition, { buffer = bufnr, desc = "跳转定义" })
    vim.keymap.set("n", "gD", vim.lsp.buf.declaration, { buffer = bufnr, desc = "跳转声明" })
    vim.keymap.set("n", "gr", vim.lsp.buf.references, { buffer = bufnr, desc = "查找引用" })
    vim.keymap.set("n", "gi", vim.lsp.buf.implementation, { buffer = bufnr, desc = "跳转实现" })
    -- K 键由 nvim-ufo 处理（预览折叠或悬停文档）
    vim.keymap.set("n", ";rn", vim.lsp.buf.rename, { buffer = bufnr, desc = "重命名" })
    vim.keymap.set("n", ";ca", vim.lsp.buf.code_action, { buffer = bufnr, desc = "代码操作" })
    vim.keymap.set("n", ";f", function()
      require("conform").format({ bufnr = bufnr })
    end, { buffer = bufnr, desc = "格式化" })
    vim.keymap.set("n", "[d", vim.diagnostic.goto_prev, { buffer = bufnr, desc = "上一个诊断" })
    vim.keymap.set("n", "]d", vim.diagnostic.goto_next, { buffer = bufnr, desc = "下一个诊断" })

    -- 禁用 LSP 格式化 (使用 conform.nvim)
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

vim.lsp.config("jsonls", {
  cmd = { "vscode-json-language-server", "--stdio" },
  filetypes = { "json", "jsonc" },
  root_markers = { ".git" },
  capabilities = capabilities,
  init_options = {
    provideFormatter = true,
  },
})

-- 启用所有配置的 LSP
vim.lsp.enable({ "lua_ls", "ts_ls", "pyright", "rust_analyzer", "tailwindcss", "jsonls" })
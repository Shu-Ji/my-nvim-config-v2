-- Rust 支持
return {
  -- Rust 语法高亮和格式化
  {
    "rust-lang/rust.vim",
    ft = "rust",
    init = function()
      vim.g.rustfmt_autosave = 1 -- 保存时自动格式化
    end,
  },

  -- Cargo.toml 补全
  {
    "saecki/crates.nvim",
    ft = { "toml", "rust" },
    event = { "BufRead Cargo.toml" },
    opts = {
      completion = {
        cmp = { enabled = true },
        crates = {
          enabled = true,
        },
      },
      lsp = {
        enabled = true,
        actions = true,
        completion = true,
        hover = true,
      },
    },
  },
}
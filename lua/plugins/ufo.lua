-- 代码折叠增强
return {
  "kevinhwang91/nvim-ufo",
  dependencies = {
    "kevinhwang91/promise-async",
  },
  event = "VeryLazy",
  opts = {
    provider_selector = function()
      return { "treesitter", "indent" }
    end,
  },
  config = function(_, opts)
    require("ufo").setup(opts)

    -- 折叠快捷键
    vim.o.foldcolumn = "1" -- 显示折叠列
    vim.o.foldlevel = 99 -- 默认展开
    vim.o.foldlevelstart = 99
    vim.o.foldenable = true

    -- 快捷键
    vim.keymap.set("n", "zR", require("ufo").openAllFolds, { desc = "展开所有" })
    vim.keymap.set("n", "zM", require("ufo").closeAllFolds, { desc = "折叠所有" })
    vim.keymap.set("n", "zr", require("ufo").openFoldsExceptKinds, { desc = "展开" })
    vim.keymap.set("n", "zm", require("ufo").closeFoldsWith, { desc = "折叠" })
  end,
}
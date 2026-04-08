-- 代码折叠增强
return {
  "kevinhwang91/nvim-ufo",
  dependencies = {
    "kevinhwang91/promise-async",
  },
  event = "VeryLazy",
  config = function()
    vim.o.foldcolumn = "1" -- 显示折叠列
    vim.o.foldlevel = 99 -- 默认展开
    vim.o.foldlevelstart = 99
    vim.o.foldenable = true

    require("ufo").setup({
      -- 智能选择 provider
      provider_selector = function(bufnr, filetype, buftype)
        -- JSON 文件使用 indent，其他用 treesitter + indent
        if filetype == "json" then
          return { "indent" }
        end
        return { "treesitter", "indent" }
      end,
      -- 自定义折叠显示：显示折叠行数
      fold_virt_text_handler = function(virtText, lnum, endLnum, width, truncate)
        local newVirtText = {}
        local suffix = (" 󰁂 %d "):format(endLnum - lnum)
        local sufWidth = vim.fn.strdisplaywidth(suffix)
        local targetWidth = width - sufWidth
        local curWidth = 0
        for _, chunk in ipairs(virtText) do
          local chunkText = chunk[1]
          local chunkWidth = vim.fn.strdisplaywidth(chunkText)
          if targetWidth > curWidth + chunkWidth then
            table.insert(newVirtText, chunk)
          else
            chunkText = truncate(chunkText, targetWidth - curWidth)
            local hlGroup = chunk[2]
            table.insert(newVirtText, { chunkText, hlGroup })
            chunkWidth = vim.fn.strdisplaywidth(chunkText)
            if curWidth + chunkWidth < targetWidth then
              suffix = suffix .. (" "):rep(targetWidth - curWidth - chunkWidth)
            end
            break
          end
          curWidth = curWidth + chunkWidth
        end
        table.insert(newVirtText, { suffix, "MoreMsg" })
        return newVirtText
      end,
    })

    -- 快捷键
    vim.keymap.set("n", "zR", require("ufo").openAllFolds, { desc = "展开所有" })
    vim.keymap.set("n", "zM", require("ufo").closeAllFolds, { desc = "折叠所有" })
    vim.keymap.set("n", "zr", require("ufo").openFoldsExceptKinds, { desc = "展开" })
    vim.keymap.set("n", "zm", require("ufo").closeFoldsWith, { desc = "折叠" })
    -- K 键：折叠时预览，否则显示悬停文档
    vim.keymap.set("n", "K", function()
      local winid = require("ufo").peekFoldedLinesUnderCursor()
      if not winid then
        vim.lsp.buf.hover()
      end
    end, { desc = "预览折叠或悬停文档" })
  end,
}
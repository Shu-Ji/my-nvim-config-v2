-- 自动命令
local autocmd = vim.api.nvim_create_autocmd
local augroup = vim.api.nvim_create_augroup

-- 窗口聚焦时切换行号样式
augroup("LineNumber", { clear = true })
autocmd("FocusLost", { group = "LineNumber", command = "set number" })
autocmd("FocusGained", { group = "LineNumber", command = "set relativenumber" })
autocmd("InsertEnter", { group = "LineNumber", command = "set norelativenumber | set number" })
autocmd("InsertLeave", { group = "LineNumber", command = "set relativenumber" })

-- 记住上次光标位置
augroup("LastLocation", { clear = true })
autocmd("BufReadPost", {
  group = "LastLocation",
  callback = function()
    local mark = vim.api.nvim_buf_get_mark(0, '"')
    local lcount = vim.api.nvim_buf_line_count(0)
    if mark[1] > 0 and mark[1] <= lcount then
      vim.api.nvim_win_set_cursor(0, mark)
    end
  end,
})

-- 关闭补全窗口
augroup("ClosePreview", { clear = true })
autocmd("InsertLeave", {
  group = "ClosePreview",
  callback = function()
    if vim.fn.pumvisible() == 0 then
      vim.cmd("pclose")
    end
  end,
})

-- 禁用 JSON 缩进线
autocmd("FileType", { pattern = "json", command = "IBLDisable" })

-- JSX 文件类型
augroup("FiletypeGroup", { clear = true })
autocmd("BufNewFile", { group = "FiletypeGroup", pattern = "*.jsx", command = "set filetype=javascriptreact" })
autocmd("BufRead", { group = "FiletypeGroup", pattern = "*.jsx", command = "set filetype=javascriptreact" })
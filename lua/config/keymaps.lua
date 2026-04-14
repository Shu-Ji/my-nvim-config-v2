-- 快捷键配置
local map = vim.keymap.set

-- 基础快捷键
map("n", ";w", "<cmd>w<cr>", { desc = "保存" })
map("n", ";q", "<cmd>qa<cr>", { desc = "退出全部" })
map("n", ";/", "<cmd>nohlsearch<cr>", { desc = "取消高亮" })

-- 插入模式
map("i", "jj", "<Esc>", { desc = "退出插入" })
map("i", "<C-a>", "<C-o>^", { desc = "行首" })
map("i", "<C-e>", "<C-o>$", { desc = "行尾" })

-- 行首行尾
map("n", "H", "^", { desc = "行首" })
map("n", "L", "$", { desc = "行尾" })
map("v", "H", "^", { desc = "行首" })
map("v", "L", "$", { desc = "行尾" })

-- 窗口移动
map("n", "<C-h>", "<C-w>h", { desc = "左窗口" })
map("n", "<C-j>", "<C-w>j", { desc = "下窗口" })
map("n", "<C-k>", "<C-w>k", { desc = "上窗口" })
map("n", "<C-l>", "<C-w>l", { desc = "右窗口" })

-- 终端模式
map("t", "<C-h>", "<C-\\><C-n><C-w>h", { desc = "左窗口" })
map("t", "<C-j>", "<C-\\><C-n><C-w>j", { desc = "下窗口" })
map("t", "<C-k>", "<C-\\><C-n><C-w>k", { desc = "上窗口" })
map("t", "<C-l>", "<C-\\><C-n><C-w>l", { desc = "右窗口" })
map("t", "<Esc>", "<C-\\><C-n>", { desc = "退出终端" })

-- 缩进
map("v", "<", "<gv", { desc = "减少缩进" })
map("v", ">", ">gv", { desc = "增加缩进" })

-- 折叠
map("n", "<Space>", "za", { desc = "切换折叠" })

-- 行号切换
map("n", "<F2>", function()
  if vim.opt.relativenumber:get() or vim.opt.number:get() then
    vim.opt.relativenumber = false
    vim.opt.number = false
  else
    vim.opt.number = true
    vim.opt.relativenumber = true
  end
end, { desc = "切换行号" })
map("n", "<F3>", "<cmd>IBLToggle<cr>", { desc = "切换缩进线" })
map("n", "<F4>", "<cmd>set wrap! wrap?<cr>", { desc = "切换折行" })

-- 上下添加空行
map("n", "t", "o<ESC>k", { desc = "下方添加空行" })
map("n", "T", "O<ESC>j", { desc = "上方添加空行" })

-- Redo
map("n", "U", "<C-r>", { desc = "Redo" })

-- 运行文件
vim.api.nvim_create_user_command("Run", function()
  local ft = vim.bo.filetype
  local file = vim.fn.expand("%")
  local cmds = {
    python = "python -u " .. file,
    javascript = "node " .. file,
    typescript = "tsc " .. file,
    sh = "bash " .. file,
    rust = "cargo run",
  }
  if cmds[ft] then
    vim.cmd("! " .. cmds[ft])
  end
end, {})
map("n", ";r", "<cmd>Run<cr>", { desc = "运行" })

-- 删除不进入剪贴板
map("x", "d", '"_d', { desc = "删除不复制" })
map("x", "c", '"_dc', { desc = "修改不复制" })

-- 自动命令
local autocmd = vim.api.nvim_create_autocmd
local augroup = vim.api.nvim_create_augroup

local function parse_version(version)
  local cleaned = version:gsub("^v", "")
  local major, minor, patch = cleaned:match("^(%d+)%.(%d+)%.(%d+)")
  if not major then
    return nil
  end

  return {
    major = tonumber(major),
    minor = tonumber(minor),
    patch = tonumber(patch),
  }
end

local function is_newer_version(latest, current)
  if latest.major ~= current.major then
    return latest.major > current.major
  end
  if latest.minor ~= current.minor then
    return latest.minor > current.minor
  end
  return latest.patch > current.patch
end

local function get_neovim_update_command()
  if vim.fn.executable("brew") == 1 then
    return "brew upgrade neovim"
  end
  if vim.fn.executable("apt") == 1 then
    return "sudo apt update && sudo apt install -y neovim"
  end
  if vim.fn.executable("pacman") == 1 then
    return "sudo pacman -Syu neovim"
  end
  if vim.fn.executable("dnf") == 1 then
    return "sudo dnf upgrade neovim"
  end
  return "请用你的包管理器升级 neovim"
end

local function check_neovim_update()
  local current = parse_version(vim.version().major .. "." .. vim.version().minor .. "." .. vim.version().patch)
  if not current then
    return
  end

  vim.system({
    "curl",
    "-fsSL",
    "https://api.github.com/repos/neovim/neovim/releases/latest",
  }, { text = true }, function(result)
    if result.code ~= 0 or not result.stdout then
      return
    end

    local ok, data = pcall(vim.json.decode, result.stdout)
    if not ok or type(data) ~= "table" or type(data.tag_name) ~= "string" then
      return
    end

    local latest = parse_version(data.tag_name)
    if not latest or not is_newer_version(latest, current) then
      return
    end

    vim.schedule(function()
      local update_cmd = get_neovim_update_command()
      vim.notify(
        string.format(
          "Neovim 有新版本：当前 v%d.%d.%d，最新 %s\n更新命令：%s",
          current.major,
          current.minor,
          current.patch,
          data.tag_name,
          update_cmd
        ),
        vim.log.levels.INFO,
        { title = "Neovim Update", timeout = 8000 }
      )
    end)
  end)
end

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


-- JSX 文件类型
augroup("FiletypeGroup", { clear = true })
autocmd("BufNewFile", { group = "FiletypeGroup", pattern = "*.jsx", command = "set filetype=javascriptreact" })
autocmd("BufRead", { group = "FiletypeGroup", pattern = "*.jsx", command = "set filetype=javascriptreact" })

-- 启动后自动更新插件，避免阻塞首屏
augroup("LazyAutoUpdate", { clear = true })
autocmd("VimEnter", {
  group = "LazyAutoUpdate",
  once = true,
  callback = function()
    vim.defer_fn(function()
      local ok, lazy = pcall(require, "lazy")
      if ok then
        lazy.update({ show = false })
      end
    end, 1000)
  end,
})

-- 启动后轻量检查 Neovim 新版本
augroup("NeovimUpdateCheck", { clear = true })
autocmd("VimEnter", {
  group = "NeovimUpdateCheck",
  once = true,
  callback = function()
    vim.defer_fn(check_neovim_update, 1500)
  end,
})

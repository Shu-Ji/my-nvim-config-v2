-- 启动页仪表盘
return {
  "goolord/alpha-nvim",
  event = "VimEnter",
  dependencies = { "nvim-tree/nvim-web-devicons" },
  config = function()
    local alpha = require("alpha")
    local dashboard = require("alpha.themes.dashboard")

    -- 设置 header
    dashboard.section.header.val = {
      "                                                     ",
      "  ███╗   ██╗███████╗ ██████╗ ██╗   ██╗██╗███╗   ███╗ ",
      "  ████╗  ██║██╔════╝██╔═══██╗██║   ██║██║████╗ ████║ ",
      "  ██╔██╗ ██║█████╗  ██║   ██║██║   ██║██║██╔████╔██║ ",
      "  ██║╚██╗██║██╔══╝  ██║   ██║╚██╗ ██╔╝██║██║╚██╔╝██║ ",
      "  ██║ ╚████║███████╗╚██████╔╝ ╚████╔╝ ██║██║ ╚═╝ ██║ ",
      "  ╚═╝  ╚═══╝╚══════╝ ╚═════╝   ╚═══╝  ╚═╝╚═╝     ╚═╝ ",
      "                                                     ",
    }

    -- 设置按钮
    dashboard.section.buttons.val = {
      dashboard.button(";n", "  新建文件", ":ene <CR>"),
      dashboard.button(";p", "  查找文件", ":Telescope find_files <CR>"),
      dashboard.button(";F", "  全局搜索", ":Telescope live_grep <CR>"),
      dashboard.button(";o", "  最近文件", ":Telescope oldfiles <CR>"),
      dashboard.button(";ee", "  编辑配置", ":e $MYVIMRC <CR>"),
      dashboard.button(";q", "  退出", ":qa <CR>"),
    }

    -- 发送配置到 alpha
    alpha.setup(dashboard.config)

    -- 禁用折叠
    vim.api.nvim_create_autocmd("FileType", {
      pattern = "alpha",
      callback = function()
        vim.opt_local.foldenable = false
        vim.opt_local.buflisted = false
      end,
    })
  end,
}
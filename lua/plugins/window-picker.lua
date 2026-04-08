-- 窗口选择
return {
  "s1n7ax/nvim-window-picker",
  event = "VeryLazy",
  opts = {
    picker_config = {
      statusline_winbar_picker = {
        use_winbar = "smart",
      },
    },
  },
  keys = {
    {
      ";ww",
      function()
        local window = require("window-picker").pick_window()
        if window then
          vim.api.nvim_set_current_win(window)
        end
      end,
      desc = "选择窗口",
    },
    {
      ";ws",
      function()
        local window = require("window-picker").pick_window()
        if window then
          local target_win = vim.api.nvim_get_current_win()
          local target_buf = vim.api.nvim_win_get_buf(target_win)
          vim.api.nvim_win_set_buf(window, target_buf)
          vim.api.nvim_win_set_buf(target_win, vim.api.nvim_create_buf(true, false))
          vim.api.nvim_set_current_win(window)
        end
      end,
      desc = "交换窗口",
    },
  },
}
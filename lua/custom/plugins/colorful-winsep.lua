local M = {
  'nvim-zh/colorful-winsep.nvim',
  opts = function(_, opts)
    local colors = require('tokyonight.colors').setup()
    opts.hi = {
      bg = colors.bg_dark,
      fg = colors.blue,
    }
    -- if not opts.events then
    --   opts.events = {}
    -- end
    -- vim.list_extend(opts.events, {
    --   'WinClosed',
    -- })
    opts.events = { 'WinEnter', 'WinResized', 'SessionLoadPost', 'WinClosed' }
    return opts
  end,
  event = { 'WinLeave' },
}

return M

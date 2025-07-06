M = {}

local state = {
  floating = {
    buf = -1,
    win = -1,
  },
}

local create_floating_window = function(opts)
  opts = opts or {}

  local width_ratio = 0.8
  local height_ratio = 0.8

  local columns = vim.o.columns
  local lines = vim.o.lines

  local width = math.floor(opts.width or (columns * width_ratio))
  local height = math.floor(opts.height or (lines * height_ratio))

  -- center the window
  local row = math.floor((lines - height) / 2 - 1)
  local col = math.floor((columns - width) / 2)

  -- create a buffer
  local buf = nil
  if vim.api.nvim_buf_is_valid(opts.buf) then
    buf = opts.buf
  else
    buf = vim.api.nvim_create_buf(false, true)
  end

  local title = opts.title or ' Floating Terminal '

  local win = vim.api.nvim_open_win(buf, true, {
    relative = 'editor',
    width = width,
    height = height,
    row = row,
    col = col,
    style = 'minimal',
    border = 'rounded',
    title = title,
    title_pos = 'center', -- "left", "center", or "right"
  })

  return { buf = buf, win = win }
end

M.toggle_terminal = function()
  if not vim.api.nvim_win_is_valid(state.floating.win) then
    state.floating = create_floating_window { buf = state.floating.buf }
    if vim.bo[state.floating.buf].buftype ~= 'terminal' then
      vim.cmd.terminal()
    end
  else
    vim.api.nvim_win_hide(state.floating.win)
  end
end

return M

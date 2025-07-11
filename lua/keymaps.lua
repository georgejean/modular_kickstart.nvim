-- [[ Basic Keymaps ]]
--  See `:help vim.keymap.set()`

-- Clear highlights on search when pressing <Esc> in normal mode
--  See `:help hlsearch`
vim.keymap.set('n', '<Esc>', '<cmd>nohlsearch<CR>')

-- Diagnostic keymaps
vim.keymap.set('n', '<leader>q', vim.diagnostic.setloclist, { desc = 'Open diagnostic [Q]uickfix list' })

-- Exit terminal mode in the builtin terminal with a shortcut that is a bit easier
-- for people to discover. Otherwise, you normally need to press <C-\><C-n>, which
-- is not what someone will guess without a bit more experience.
--
-- NOTE: This won't work in all terminal emulators/tmux/etc. Try your own mapping
-- or just use <C-\><C-n> to exit terminal mode
vim.keymap.set('t', '<Esc><Esc>', '<C-\\><C-n>', { desc = 'Exit terminal mode' })

-- TIP: Disable arrow keys in normal mode
-- vim.keymap.set('n', '<left>', '<cmd>echo "Use h to move!!"<CR>')
-- vim.keymap.set('n', '<right>', '<cmd>echo "Use l to move!!"<CR>')
-- vim.keymap.set('n', '<up>', '<cmd>echo "Use k to move!!"<CR>')
-- vim.keymap.set('n', '<down>', '<cmd>echo "Use j to move!!"<CR>')

-- Keybinds to make split navigation easier.
--  Use CTRL+<hjkl> to switch between windows
--
--  See `:help wincmd` for a list of all window commands
vim.keymap.set('n', '<C-h>', '<C-w><C-h>', { desc = 'Move focus to the left window' })
vim.keymap.set('n', '<C-l>', '<C-w><C-l>', { desc = 'Move focus to the right window' })
vim.keymap.set('n', '<C-j>', '<C-w><C-j>', { desc = 'Move focus to the lower window' })
vim.keymap.set('n', '<C-k>', '<C-w><C-k>', { desc = 'Move focus to the upper window' })

--resizing windows
vim.keymap.set('n', '<A-h>', '<C-w><', { desc = 'Decrease window width' })
vim.keymap.set('n', '<A-l>', '<C-w>>', { desc = 'Increase window width' })
vim.keymap.set('n', '<A-j>', '<C-w>-', { desc = 'Decrease window height' })
vim.keymap.set('n', '<A-k>', '<C-w>+', { desc = 'Increase window height' })
-- Set original behavior of Y (as yy)
vim.keymap.set('n', 'Y', 'yy', { noremap = true, desc = 'Yank entire line' })

-- NOTE: Some terminals have colliding keymaps or are not able to send distinct keycodes
-- vim.keymap.set('n', '<A-h>', '<C-w>H', { desc = 'Move window to the left' })
-- vim.keymap.set('n', '<A-l>', '<C-w>L', { desc = 'Move window to the right' })
-- vim.keymap.set('n', '<A-j>', '<C-w>J', { desc = 'Move window to the lower' })
-- vim.keymap.set('n', '<A-k>', '<C-w>K', { desc = 'Move window to the upper' })

-- set keymap to launch a function
-- vim.keymap.set({ 'n' }, '<localleader>W', function()
--   vim.print(require 'colorful-winsep.config')
-- end, { desc = 'print colorful-winsep info' })

vim.keymap.set({ 'n' }, '<C-s>', '<cmd>w!<cr>', { desc = 'Save current file' })

-- Expand 'cc' into 'CodeCompanion' in the command line
vim.cmd [[cab cc CodeCompanion]]
-- Expand 'ccm' into 'CodeCompanionCmd' in the command line
vim.cmd [[cab ccm CodeCompanionCmd]]

vim.keymap.set('n', '<leader>ts', ':ToggleShell<CR>', { desc = '[T]oggle [S]hell (between cmd and sh)' })

-- [[ Basic Autocommands ]]
--  See `:help lua-guide-autocommands`

-- Highlight when yanking (copying) text
--  Try it with `yap` in normal mode
--  See `:help vim.hl.on_yank()`
vim.api.nvim_create_autocmd('TextYankPost', {
  desc = 'Highlight when yanking (copying) text',
  group = vim.api.nvim_create_augroup('kickstart-highlight-yank', { clear = true }),
  callback = function()
    vim.hl.on_yank()
  end,
})

vim.api.nvim_create_user_command('Floaterminal', require('custom.floaterminal').toggle_terminal, {})
vim.keymap.set({ 'n', 't' }, '<leader>tt', '<cmd>Floaterminal<CR>', { desc = '[T]oggle [T]erminal' })
-- vim: ts=2 sts=2 sw=2 et

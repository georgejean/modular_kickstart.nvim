M = {}

-- NOTE: shell configuration

-- List of available shells
M.shell = { 'cmd.exe', (vim.fn.executable 'pwsh.exe' == 1) and 'pwsh.exe', (vim.fn.executable 'sh.exe' == 1) and 'sh.exe' }

-- Utility function to properly set the shell

function M.set_shell(shell)
  -- Setting shell quote options
  vim.o.shellquote = ''
  vim.o.shellxquote = ''
  if shell:match 'cmd' then --cmd config
    vim.o.shell = shell
    vim.o.shellcmdflag = '/c'
  elseif shell:match 'pwsh' then --pwsh config
    vim.o.shell = shell
    vim.o.shellcmdflag =
      "-NoLogo -NoProfile -ExecutionPolicy RemoteSigned -Command [Console]::InputEncoding=[Console]::OutputEncoding=[System.Text.UTF8Encoding]::new($false);$PSDefaultParameterValues['Out-File:Encoding']='utf8';"
    vim.o.shellredir = '2>&1 | %{ "$_" } | Out-File %s; exit $LastExitCode'
    vim.o.shellpipe = '2>&1 | %{ "$_" } | Tee-Object %s; exit $LastExitCode'
  elseif shell:match 'sh' then --sh.exe config
    vim.o.shell = shell
    vim.o.shellcmdflag = '-c'
    vim.o.shellslash = true
  end
end

function M.get_shell_config(shell)
  local config_body = '' -- Le corps de la configuration

  if shell:match 'cmd' then
    config_body = [[
vim.o.shell = 'cmd.exe'
vim.o.shellcmdflag = '/c'
vim.o.shellquote = ''
vim.o.shellxquote = ''
]]
  elseif shell:match 'pwsh' then
    config_body = [[
vim.o.shell = 'pwsh.exe'
vim.o.shellcmdflag = '-NoLogo -NoProfile...' -- version abrégée
vim.o.shellredir = '2>&1 | %{ "$_" } | Out-File...'
vim.o.shellpipe = '2>&1 | %{ "$_" } | Tee-Object...'
vim.o.shellquote = ''
vim.o.shellxquote = ''
]]
  elseif shell:match 'sh' then
    config_body = [[
vim.o.shell = 'sh.exe'
vim.o.shellcmdflag = '-c'
vim.o.shellslash = true
vim.o.shellquote = ''
vim.o.shellxquote = ''
]]
  end

  -- On assemble le titre et le corps, puis on découpe en lignes
  local final_string = '--- Configuration pour ' .. shell .. ' ---' .. config_body

  -- On convertit la chaîne multi-lignes en une table de lignes,
  -- exactement comme avant, mais de façon plus lisible.
  return vim.split(final_string, '\n', {})
end

return M

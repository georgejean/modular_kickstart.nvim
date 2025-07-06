M = {}

-- Custom picker config : choosing a shell config
local pickers = require 'telescope.pickers'
local finders = require 'telescope.finders'
local actions = require 'telescope.actions'
local action_state = require 'telescope.actions.state'
local previewers = require 'telescope.previewers'
local themes = require 'telescope.themes'
local sorters = require 'telescope.sorters'

-- function picker
function M.shell_picker()
  -- list of available shell
  local shells = require('custom').shell
  local shell_names = {}
  for _, v in ipairs(shells) do
    if v then
      table.insert(shell_names, v)
    end
  end

  local has_fzf, fzf = pcall(require('telescope').load_extension, 'fzf')

  -- options for shell_picker
  local opts = themes.get_dropdown {
    winblend = 25,
    layout_config = {
      vertical = {
        preview_height = 0.6,
      },
      mirror = true,
    },
    prompt_title = 'Choisissez un shell',
    sorter = (has_fzf and fzf.native_fzf_sorter()) or sorters.get_fuzzy_file(),
  }

  -- Définition du previewer personnalisé
  local custom_previewer = previewers.new_buffer_previewer {
    title = 'Aperçu de la configuration',
    define_preview = function(self, entry)
      -- Récupère le nom du shell sélectionné
      local shell_name = entry.value
      -- Appelle notre nouvelle fonction pour obtenir les lignes de configuration
      local config_lines = require('custom').get_shell_config(shell_name)
      -- Affiche ces lignes dans le buffer du previewer
      vim.api.nvim_buf_set_lines(self.state.bufnr, 0, -1, false, config_lines)
      -- Applique la coloration syntaxique Lua pour une meilleure lisibilité
      vim.bo[self.state.bufnr].filetype = 'lua'
    end,
  }

  -- picker definition
  pickers
    .new(opts, {
      finder = finders.new_table { results = shell_names },
      previewer = custom_previewer,
      attach_mappings = function(prompt_bufnr, map)
        actions.select_default:replace(function()
          actions.close(prompt_bufnr)
          local selection = action_state.get_selected_entry()
          require('custom').set_shell(selection.value)
          print('🔁 Shell switched to: ' .. selection.value)
        end)
        return true
      end,
    })
    :find()
end

return M

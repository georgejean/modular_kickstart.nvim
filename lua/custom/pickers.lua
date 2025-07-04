M = {}

-- Custom picker config : choosing a shell config
local pickers = require 'telescope.pickers'
local finders = require 'telescope.finders'
local actions = require 'telescope.actions'
local action_state = require 'telescope.actions.state'
local sorters = require 'telescope.sorters'
local previewers = require 'telescope.previewers'
local themes = require 'telescope.themes'

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

  -- options for shell_picker
  local opts = themes.get_dropdown {
    winblend = 25,
    -- previewer = false,
    -- preview_cutoff = 1, -- always show preview
    layout_config = {
      vertical = {
        -- prompt_position = 'top',
        preview_height = 0.6,
      },
      mirror = true,
    },
    prompt_title = 'Choisissez un shell',
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
      sorter = sorters.get_generic_fuzzy_sorter(),
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

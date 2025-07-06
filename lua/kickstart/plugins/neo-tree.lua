-- Neo-tree is a Neovim plugin to browse the file system
-- https://github.com/nvim-neo-tree/neo-tree.nvim

return {
  'nvim-neo-tree/neo-tree.nvim',
  version = '*',
  dependencies = {
    'nvim-lua/plenary.nvim',
    'nvim-tree/nvim-web-devicons', -- not strictly required, but recommended
    'MunifTanjim/nui.nvim',
  },
  lazy = false,
  keys = {
    {
      '<leader>e',
      function()
        -- Obtenir le chemin du fichier courant
        local file_path = vim.fn.expand '%:p'
        if vim.fn.filereadable(file_path) == 1 then
          -- Si le buffer est associé à un fichier, obtenir son répertoire parent
          vim.cmd 'Neotree dir=%:p:h'
        else
          -- Sinon, utiliser le répertoire courant
          vim.cmd 'Neotree reveal'
        end
      end,
      desc = 'NeoTree reveal in parent dir',
      silent = true,
    },
  },
  opts = {
    filesystem = {
      window = {
        mappings = {
          ['<leader>e'] = 'close_window',
        },
      },
    },
  },
}

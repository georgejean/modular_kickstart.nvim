return {
  'lervag/vimtex',
  -- branch = [[feat/view-general-windows]],
  -- commit = "da7870b69cc0468d4852aeabee0beef0b76ecdf4",
  init = function()
    -- Live compilation
    vim.g.vimtex_compiler_latexmk = {
      build_dir = '.out',
      options = {
        '-shell-escape',
        '-verbose',
        '-file-line-error',
        '-interaction=nonstopmode',
        '-synctex=1',
      },
    }
    vim.g.vimtex_view_general_viewer = 'SumatraPDF'
    vim.g.vimtex_view_general_options = [[-reuse-instance -forward-search @tex @line @pdf]]

    -- vim.g.vimtex_view_general_viewer = "okular"
    -- vim.g.vimtex_view_general_options = "--unique file:@pdf#src:@line@tex"
    vim.g.vimtex_fold_enabled = true
    -- vim.g.vimtex_syntax_conceal = {
    --   accents = 1,
    --   ligatures = 1,
    --   cites = 1,
    --   fancy = 1,
    --   spacing = 0, -- default: 1
    --   greek = 1,
    --   math_bounds = 1,
    --   math_delimiters = 1,
    --   math_fracs = 1,
    --   math_super_sub = 1,
    --   math_symbols = 1,
    --   sections = 0,
    --   styles = 1,
    -- }
  end,
  opts = { patterns = { '*.tex' } },
  config = function(_, opts)
    vim.api.nvim_create_autocmd({ 'BufRead', 'BufNewFile' }, {
      pattern = opts.patterns,
      callback = function()
        vim.cmd [[VimtexCompile]]
      end,
    })
  end,
}

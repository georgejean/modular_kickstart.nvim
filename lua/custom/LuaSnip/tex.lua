return {
  s(
    { trig = 'env', snippetType = 'autosnippet' },
    fmta(
      [[
      \begin{<>}
          <>
      \end{<>}
    ]],
      {
        i(1),
        i(0),
        rep(1), -- this node repeats insert node i(1)
      }
    )
  ),
}
-- see https://github.com/L3MON4D3/LuaSnip/blob/master/DOC.md#snip-env-diagnostics for explanation about the .luarc.json file.
-- see the content of def-file.lua in $LOCALAPPDATA/nvim-data/luasnip-snip_env

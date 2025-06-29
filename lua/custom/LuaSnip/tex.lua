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

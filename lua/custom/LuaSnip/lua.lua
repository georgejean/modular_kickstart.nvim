return {

  s(
    { trig = 'skeymp', dscr = 'set keymap' },
    fmta("vim.keymap.set({<>}, '<>', <>, {desc = '<>'})", {
      i(1),
      i(2),
      i(3),
      i(4),
    })
  ),
}

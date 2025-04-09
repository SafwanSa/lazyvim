return {
  'christoomey/vim-tmux-navigator',
  cmd = {
    'TmuxNavigateLeft',
    'TmuxNavigateDown',
    'TmuxNavigateUp',
    'TmuxNavigateRight',
    'TmuxNavigatePrevious',
    'TmuxNavigatorProcessList',
  },
  keys = {
    { '<c-w><c-h>', ':TmuxNavigateLeft<cr>' },
    { '<c-w><c-j>', ':TmuxNavigateDown<cr>' },
    { '<c-w><c-k>', ':TmuxNavigateUp<cr>' },
    { '<c-w><c-l>', ':TmuxNavigateRight<cr>' },
    { '<c-w><c-\\>', ':TmuxNavigatePrevious<cr>' },
  },
}

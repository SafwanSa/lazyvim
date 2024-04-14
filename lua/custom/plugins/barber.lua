return {
  {
    'romgrk/barbar.nvim',
    dependencies = {
      'lewis6991/gitsigns.nvim', -- OPTIONAL: for git status
      'nvim-tree/nvim-web-devicons', -- OPTIONAL: for file icons
    },
    init = function()
      vim.g.barbar_auto_setup = false
      local opts = { desc = '', noremap = true, silent = true }
      -- Move to previous/next
      vim.keymap.set('n', '<A-,>', '<Cmd>BufferPrevious<CR>', opts)
      vim.keymap.set('n', '<A-.>', '<Cmd>BufferNext<CR>', opts)
      -- Re-order to previous/next
      vim.keymap.set('n', '<A-<>', '<Cmd>BufferMovePrevious<CR>', opts)
      vim.keymap.set('n', '<A->>', '<Cmd>BufferMoveNext<CR>', opts)
      -- Goto buffer in position...
      vim.keymap.set('n', '<A-1>', '<Cmd>BufferGoto 1<CR>', opts)
      vim.keymap.set('n', '<A-2>', '<Cmd>BufferGoto 2<CR>', opts)
      vim.keymap.set('n', '<A-3>', '<Cmd>BufferGoto 3<CR>', opts)
      vim.keymap.set('n', '<A-4>', '<Cmd>BufferGoto 4<CR>', opts)
      vim.keymap.set('n', '<A-5>', '<Cmd>BufferGoto 5<CR>', opts)
      vim.keymap.set('n', '<A-6>', '<Cmd>BufferGoto 6<CR>', opts)
      vim.keymap.set('n', '<A-7>', '<Cmd>BufferGoto 7<CR>', opts)
      vim.keymap.set('n', '<A-8>', '<Cmd>BufferGoto 8<CR>', opts)
      vim.keymap.set('n', '<A-9>', '<Cmd>BufferGoto 9<CR>', opts)
      vim.keymap.set('n', '<A-0>', '<Cmd>BufferLast<CR>', opts)
      -- Pin/unpin buffer
      vim.keymap.set('n', '<A-p>', '<Cmd>BufferPin<CR>', opts)
      -- Close buffer
      vim.keymap.set('n', '<A-c>', '<Cmd>BufferClose<CR>', opts)
      -- Wipeout buffer
      --                 :BufferWipeout
      -- Close commands
      --                 :BufferCloseAllButCurrent
      --                 :BufferCloseAllButPinned
      --                 :BufferCloseAllButCurrentOrPinned
      --                 :BufferCloseBuffersLeft
      --                 :BufferCloseBuffersRight
      -- Magic buffer-picking mode
      -- vim.keymap.set('n', '<C-p>', '<Cmd>BufferPick<CR>', opts)
      -- Sort automatically by...
      vim.keymap.set('n', '<leader>bb', '<Cmd>BufferOrderByBufferNumber<CR>', { desc = 'Order [B]arber by [B]uffer number', noremap = true, silent = true })
      vim.keymap.set('n', '<leader>bd', '<Cmd>BufferOrderByDirectory<CR>', { desc = 'Order [B]arber by [D]irectory', noremap = true, silent = true })
      -- vim.keymap.set('n', '<leader>bl', '<Cmd>BufferOrderByLanguage<CR>', { desc="", noremap = true, silent = true })
      vim.keymap.set('n', '<leader>bw', '<Cmd>BufferOrderByWindowNumber<CR>', { desc = 'Order [B]arber by [W]indow number', noremap = true, silent = true })
    end,
    opts = {
      sidebar_filetypes = {
        -- Use the default values: {event = 'BufWinLeave', text = nil}
        NvimTree = true,
        -- Or, specify the text used for the offset:
        undotree = { text = 'undotree' },
        -- Or, specify the event which the sidebar executes when leaving:
        ['neo-tree'] = { event = 'BufWipeout' },
        -- Or, specify both
        Outline = { event = 'BufWinLeave', text = 'symbols-outline' },
      },
    },
    version = '^1.0.0', -- optional: only update when a new 1.x version is released
  },
}

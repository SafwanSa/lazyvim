return {
  {
    'akinsho/toggleterm.nvim',
    version = '*',
    config = function()
      local toggleterm = require 'toggleterm'

      toggleterm.setup {
        insert_mappings = true,
        terminal_mappings = true,
        auto_scroll = true, -- automatically scroll to the bottom on terminal output
        open_mapping = [[<A-j>]],
      }

      function _G.set_terminal_keymaps()
        local opts = { noremap = true }
        -- vim.keymap.set({ 'i', 't' }, '<esc>', '<c-\\><c-N>', opts)
        vim.keymap.set({ 'i', 't', 'n' }, '<C-h>', '<c-\\><c-N><c-w>h', opts)
        vim.keymap.set({ 'i', 't', 'n' }, '<C-j>', '<c-\\><c-N><c-w>j', opts)
        vim.keymap.set({ 'i', 't', 'n' }, '<C-k>', '<c-\\><c-N><c-w>k', opts)
        vim.keymap.set({ 'i', 't', 'n' }, '<C-l>', '<c-\\><c-N><c-w>l', opts)
      end
      -- vim.keymap.set('n', '<A-j>', vim.cmd.ToggleTerm)
      vim.cmd 'autocmd! TermOpen term://* lua set_terminal_keymaps()'
    end,
  },
}

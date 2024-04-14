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
      }

      vim.keymap.set('n', '<A-j>', vim.cmd.ToggleTerm)
    end,
  },
}

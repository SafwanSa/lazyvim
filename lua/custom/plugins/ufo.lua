return {
  {
    'kevinhwang91/nvim-ufo',
    dependencies = 'kevinhwang91/promise-async',
    config = function(_, opts)
      local ufo = require 'ufo'
      vim.o.foldcolumn = '1' -- '0' is not bad
      vim.o.foldlevel = 99 -- Using ufo provider need a large value, feel free to decrease the value
      vim.o.foldlevelstart = 99
      vim.o.foldenable = true
      -- Using ufo provider need remap `zR` and `zM`. If Neovim is 0.6.1, remap yourself
      vim.keymap.set('n', 'fr', ufo.openAllFolds, { desc = 'Open all folds' })
      vim.keymap.set('n', 'ff', ufo.closeAllFolds, { desc = 'Close all folds' })
      vim.keymap.set('n', 'fa', 'za', { desc = 'Toggle fold' })
      vim.keymap.set('n', 'fk', function()
        local winid = ufo.peekFoldedLinesUnderCursor()
        if not winid then
          vim.lsp.buf.hover()
        end
      end, { desc = 'Peek fold' })

      ufo.setup {
        provider_selector = function(bufnr, filetype, buftype)
          return { 'lsp', 'indent' }
        end,
      }
    end,
  },
}

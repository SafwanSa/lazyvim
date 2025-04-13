return {
  {
    'nvimtools/none-ls.nvim',
    event = 'VeryLazy',
    dependencies = { 'mason.nvim', 'davidmh/cspell.nvim' },
    opts = function(_, opts)
      local cspell = require 'cspell'

      require('null-ls').setup {
        sources = {
          cspell.diagnostics.with {
            filetypes = { 'lua', 'python', 'typescript', 'javascript', 'json', 'html', 'css', 'scss', 'go', 'typescriptreact' },
          },
          cspell.code_actions,
        },
      }
    end,
  },
}

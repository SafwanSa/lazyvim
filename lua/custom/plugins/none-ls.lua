return {
  {
    'nvimtools/none-ls.nvim',
    -- event = 'LazyFile',
    dependencies = { 'mason.nvim', 'davidmh/cspell.nvim' },
    opts = function(_, opts)
      local cspell = require 'cspell'

      require('null-ls').setup {
        sources = {
          cspell.diagnostics.with {
            filetypes = { 'python', 'typescript', 'javascript', 'json', 'html', 'css', 'scss', 'go' },
          },
          cspell.code_actions,
        },
      }
    end,
  },
}

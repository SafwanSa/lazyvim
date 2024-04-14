return {
  {
    'lukas-reineke/indent-blankline.nvim',
    main = 'ibl',
    config = function()
      local highlight = {
        'Gray',
      }
      local hooks = require 'ibl.hooks'
      -- create the highlight groups in the highlight setup hook, so they are reset
      -- every time the colorscheme changes
      hooks.register(hooks.type.HIGHLIGHT_SETUP, function()
        vim.api.nvim_set_hl(0, 'Gray', { fg = '#808080' })
      end)
      require('ibl').setup {
        indent = { char = '▏' },
        scope = {
          enabled = true,
          show_start = false,
          show_end = false,
          highlight = highlight,
        },
      }
    end,
  },
}

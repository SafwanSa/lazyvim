return {
  {
    'olimorris/onedarkpro.nvim',
    priority = 1000, -- Ensure it loads first
    init = function()
      require('onedarkpro').setup {
        highlights = {
          ['@odp.import_module.python'] = { fg = '${yellow}' },
          ['@field.python'] = { fg = '${red}' },
          ['@attribute.python'] = { fg = '${blue}' },
          ['@parameter.python'] = { italic = true },
          ['@constant.builtin.python'] = { fg = '${yellow}' },
          -- ["@function.builtin.python"] = { fg = "${blue}" },
          -- ["@comment.python"] = { italic = true },
        },
        options = {
          transparency = true,
        },
      }
      vim.cmd.colorscheme 'onedark_vivid'
      -- You can configure highlights by doing something like:
      vim.cmd.hi 'Comment gui=none'
    end,
  },
}

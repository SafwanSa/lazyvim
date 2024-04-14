return {
  { -- You can easily change to a different colorscheme.
    -- Change the name of the colorscheme plugin below, and then
    -- change the command in the config to whatever the name of that colorscheme is.
    --
    -- If you want to see what colorschemes are already installed, you can use `:Telescope colorscheme`.
    'folke/tokyonight.nvim',
    priority = 1000, -- Make sure to load this before all the other start plugins.
    opts = {
      transparent = true,
      terminal_colors = true, -- Configure the colors used when opening a `:terminal` in [Neovim](https://github.com/neovim/neovim)
      styles = {
        comments = { italic = true },
        keywords = { italic = true },
      },
    },
    init = function()
      -- Load the colorscheme here.
      -- Like many other themes, this one has different styles, and you could load
      -- any other, such as 'tokyonight-storm', 'tokyonight-moon', or 'tokyonight-day'.
      vim.cmd.colorscheme 'tokyonight-night'

      -- You can configure highlights by doing something like:
      vim.cmd.hi 'Comment gui=none'
      vim.api.nvim_set_hl(0, 'Normal', { bg = 'none' })
      vim.api.nvim_set_hl(0, 'NormalFloat', { bg = 'none' })

      vim.api.nvim_set_hl(0, 'NvimTreeNormal', { bg = 'none' })
      vim.api.nvim_set_hl(0, 'NvimTreeNormalNC', { bg = 'none' })
      vim.api.nvim_set_hl(0, 'NvimTreeNormalFloat', { bg = 'none' })
      vim.api.nvim_set_hl(0, 'NvimTreeEndOfBuffer', { bg = 'none' })
      vim.api.nvim_set_hl(0, 'NvimTreeWinSeparator', { bg = 'none', fg = '#3b4261' })
      vim.api.nvim_set_hl(0, 'VertSplit', { fg = '#3b4261' })

      vim.api.nvim_set_hl(0, 'WhichKeyFloat', { bg = 'none' })

      vim.api.nvim_set_hl(0, 'NotifyBackground', { bg = 'none' })
    end,
  },
}
-- vim: ts=2 sts=2 sw=2 et

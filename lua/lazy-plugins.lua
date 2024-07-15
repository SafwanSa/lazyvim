-- [[ Configure and install plugins ]]
--
--  To check the current status of your plugins, run
--    :Lazy
--
--  You can press `?` in this menu for help. Use `:q` to close the window
--
--  To update plugins you can run
--    :Lazy update
--
-- NOTE: Here is where you install your plugins.
require('lazy').setup {
  -- NOTE: Plugins can be added with a link (or for a github repo: 'owner/repo' link).
  'tpope/vim-sleuth', -- Detect tabstop and shiftwidth automatically

  -- NOTE: Plugins can also be added by using a table,
  -- with the first argument being the link and the following
  -- keys can be used to configure plugin behavior/loading/etc.
  --
  -- Use `opts = {}` to force a plugin to be loaded.
  --
  --  This is equivalent to:
  --    require('Comment').setup({})

  -- "gc" to comment visual regions/lines
  { 'numToStr/Comment.nvim', opts = {} },
  -- html autotag
  { 'windwp/nvim-ts-autotag', opts = {} },
  -- Open live server
  { 'barrett-ruth/live-server.nvim', opts = {} },
  -- modular approach: using `require 'path/name'` will
  -- include a plugin definition from file lua/path/name.lua
  --
  -- { 'ThePrimeagen/vim-be-good', opts = {} },

  require 'custom/plugins/gitsigns',

  require 'custom/plugins/which-key',

  require 'custom/plugins/telescope',

  require 'custom/plugins/lspconfig',

  require 'custom/plugins/conform',

  require 'custom/plugins/cmp',

  require 'custom/plugins/themes/tokyonight',
  -- require 'custom/plugins/themes/onedarkpro',
  -- require 'custom.plugins.themes.rose-pine',
  -- require 'custom/plugins/themes/catppuccin',

  require 'custom/plugins/todo-comments',

  require 'custom/plugins/mini',

  require 'custom/plugins/treesitter',

  require 'custom.plugins.rainbow-delimiters',

  require 'custom/plugins/lazygit',

  require 'custom/plugins/nvim-tree',

  -- require 'custom/plugins/barber',

  require 'custom.plugins.debug',

  require 'custom.plugins.indent-blankline',

  require 'custom.plugins.toggle-term',

  require 'custom.plugins.vim-doge',

  require 'custom.plugins.context',

  require 'custom.plugins.harpoon',

  require 'custom.plugins.ufo',

  -- require 'custom.plugins.noice',

  -- require 'custom.plugins.lint',
  require 'custom.plugins.none-ls', -- it handles linting with code actions

  -- Language specific
  require 'custom.plugins.venv-selector',
}

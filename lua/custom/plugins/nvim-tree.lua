return {
  {
    'nvim-tree/nvim-tree.lua',
    dependencies = {
      'nvim-tree/nvim-web-devicons', -- optional
    },
    lazy = false,
    config = function()
      require('nvim-tree').setup {
        hijack_directories = {
          enable = false, -- Prevent nvim-tree from opening when entering a directory
        },
        sort_by = 'case_sensitive',
        -- filters = {
        --   dotfiles = true,
        -- },
        trash = {
          cmd = 'trash',
        },
        prefer_startup_root = true,
        respect_buf_cwd = false,

        root_dirs = {},

        sync_root_with_cwd = true,

        view = {
          adaptive_size = false,
          centralize_selection = true,
          width = 30,
          side = 'left',
          preserve_window_proportions = false,
          number = false,
          relativenumber = false,
          signcolumn = 'yes',
          float = {
            enable = false,
            quit_on_focus_loss = true,
            open_win_config = {
              relative = 'editor',
              border = 'rounded',
              width = 30,
              height = 30,
              row = 1,
              col = 1,
            },
          },
        },
        renderer = {
          add_trailing = false,
          group_empty = true,
          highlight_git = true,
          full_name = false,
          highlight_opened_files = 'none',
          root_folder_label = ':t',
          indent_width = 2,
          indent_markers = {
            enable = false,
            inline_arrows = true,
            icons = {
              corner = '└',
              edge = '│',
              item = '│',
              none = ' ',
            },
          },
        },

        update_focused_file = {
          enable = true,
          debounce_delay = 15,
          update_root = true,
          ignore_list = {},
        },
        on_attach = function(bufnr)
          local api = require 'nvim-tree.api'

          local function opts(desc)
            return { desc = 'nvim-tree: ' .. desc, buffer = bufnr, noremap = true, silent = true, nowait = true }
          end

          -- default mappings
          api.config.mappings.default_on_attach(bufnr)

          -- custom mapping

          vim.keymap.set('n', '<C-b>', vim.cmd.NvimTreeToggle, { desc = 'Toggle nvim-tree' })
          vim.keymap.set('n', '<C-b>', api.tree.toggle, opts 'Toggle')
          vim.keymap.set('n', '?', api.tree.toggle_help, opts 'Help')
        end,
      }
    end,
  },
}

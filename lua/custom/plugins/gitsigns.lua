-- Here is a more advanced example where we pass configuration
-- options to `gitsigns.nvim`. This is equivalent to the following Lua:
--    require('gitsigns').setup({ ... })
--
-- See `:help gitsigns` to understand what the configuration keys do
return {
  { -- Adds git related signs to the gutter, as well as utilities for managing changes
    'lewis6991/gitsigns.nvim',
    opts = {
      -- signs = {
      --   add = { text = '+' },
      --   change = { text = '~' },
      --   delete = { text = '_' },
      --   topdelete = { text = '‾' },
      --   changedelete = { text = '~' },
      -- },
      attach_to_untracked = true,
      current_line_blame = true,
      current_line_blame_opts = {
        virt_text = true,
        virt_text_pos = 'eol', -- 'eol' | 'overlay' | 'right_align'
        delay = 1000,
        ignore_whitespace = false,
      },
      on_attach = function(bufnr)
        local gs = package.loaded.gitsigns

        local function map(mode, l, r, opts)
          opts = opts or {}
          opts.buffer = bufnr
          vim.keymap.set(mode, l, r, opts)
        end

        -- Navigation
        map('n', ']c', function()
          if vim.wo.diff then
            return ']c'
          end
          vim.schedule(function()
            gs.next_hunk()
          end)
          return '<Ignore>'
        end, { expr = true })

        map('n', '[c', function()
          if vim.wo.diff then
            return '[c'
          end
          vim.schedule(function()
            gs.prev_hunk()
          end)
          return '<Ignore>'
        end, { expr = true })

        -- Actions
        -- Stage
        map('n', '<leader>hS', gs.stage_buffer, { desc = '[S]tage buffer' })
        map('n', '<leader>hs', gs.stage_hunk, { desc = '[S]tage hunk' })
        map('v', '<leader>hs', function()
          gs.stage_hunk { vim.fn.line '.', vim.fn.line 'v' }
        end, { desc = '[S]tage selected hunk' })
        map('n', '<leader>hu', gs.undo_stage_hunk, { desc = '[U]ndo stage buffer' })

        -- Reset
        map('n', '<leader>hR', gs.reset_buffer, { desc = '[R]eset buffer' })
        map('n', '<leader>hr', gs.reset_hunk, { desc = '[R]eset hunk' })
        map('v', '<leader>hr', function()
          gs.reset_hunk { vim.fn.line '.', vim.fn.line 'v' }
        end, { desc = '[R]eset selected hunk' })

        map('n', '<leader>hp', gs.preview_hunk, { desc = '[P]review hunk' })
        map('n', '<leader>hb', function()
          gs.blame_line { full = true }
        end, { desc = '[B]lame line' })
        -- map('n', '<leader>tb', gs.toggle_current_line_blame)
        map('n', '<leader>hd', gs.diffthis, { desc = '[D]iff current buffer' })
        map('n', '<leader>hD', function()
          gs.diffthis '~'
        end)
        map('n', '<leader>td', gs.toggle_deleted, { desc = '[T]oggle [D]eleted lines' })

        -- Text object
        map({ 'o', 'x' }, 'ih', ':<C-U>Gitsigns select_hunk<CR>')
      end,
    },
  },
}
-- vim: ts=2 sts=2 sw=2 et

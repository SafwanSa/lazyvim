return {
  { -- Autoformat
    'stevearc/conform.nvim',
    lazy = false,
    keys = {
      {
        '<leader>f',
        function()
          require('conform').format { async = true, lsp_fallback = true }
        end,
        mode = '',
        desc = '[F]ormat buffer',
      },
    },
    opts = {
      notify_on_error = false,
      format_on_save = function(bufnr)
        -- Disable "format_on_save lsp_fallback" for languages that don't
        -- have a well standardized coding style. You can add additional
        -- languages here or re-enable it for the disabled ones.
        local disable_filetypes = { c = true, cpp = true }
        return {
          timeout_ms = 500,
          lsp_fallback = not disable_filetypes[vim.bo[bufnr].filetype],
        }
      end,
      formatters_by_ft = {
        lua = { 'stylua' },
        proto = { 'buf' },
        python = { 'autopep8' },
        go = { 'gofumpt', 'golines', 'goimports-reviser' },
        -- You can use a sub-list to tell conform to run *until* a formatter
        -- is found.
        -- javascript = { { "prettierd", "prettier" } },
        css = { 'prettier' },
        graphql = { 'prettier' },
        html = { 'prettier' },
        javascript = { 'prettier' },
        javascriptreact = { 'prettier' },
        json = { 'prettier' },
        less = { 'prettier' },
        markdown = { 'prettier' },
        scss = { 'prettier' },
        typescript = { 'prettier' },
        typescriptreact = { 'prettier' },
        yaml = { 'prettier' },
      },
      formatters = {
        prettier = {
          command = 'prettier',
          prepend_args = function(ctx)
            -- Check if .prettierrc exists in the root directory
            local root_dir = vim.fn.getcwd()
            local prettier_config = vim.fn.glob(root_dir .. '/.prettierrc*')

            if prettier_config ~= '' then
              -- Use Prettier with the found config
              return { '--config', prettier_config }
            else
              -- Use fallback Prettier options
              return {
                '--arrow-parens=always',
                '--bracket-spacing',
                '--end-of-line=lf',
                '--html-whitespace-sensitivity=css',
                '--insert-pragma=false',
                '--single-attribute-per-line=false',
                '--bracket-same-line=false',
                '--jsx-bracket-same-line=false',
                '--jsx-single-quote=false',
                '--print-width=80',
                '--prose-wrap=preserve',
                '--quote-props=as-needed',
                '--require-pragma=false',
                '--no-semi=false',
                '--single-quote=false',
                '--tab-width=2',
                '--trailing-comma=es5',
                '--use-tabs',
                '--embedded-language-formatting=auto',
                '--vue-indent-script-and-style=false',
              }
            end
          end,
        },
        autopep8 = {
          prepend_args = {
            '--max-line-length=120',
            '--experimental',
          },
        },
        golines = {
          prepend_args = {
            '--max-len=120',
          },
        },
      },
    },
  },
}
-- vim: ts=2 sts=2 sw=2 et

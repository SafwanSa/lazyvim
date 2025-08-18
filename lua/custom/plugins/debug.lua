local js_based_languages = {
  'typescript',
  'javascript',
  'typescriptreact',
  'javascriptreact',
  'vue',
}
return {
  'mfussenegger/nvim-dap',
  dependencies = {
    'rcarriga/nvim-dap-ui',
    'nvim-neotest/nvim-nio',
    'williamboman/mason.nvim',
    'jay-babu/mason-nvim-dap.nvim',
    'leoluz/nvim-dap-go',
    'mfussenegger/nvim-dap-python',
    'theHamsta/nvim-dap-virtual-text',
    'rcarriga/cmp-dap',
    {
      'microsoft/vscode-js-debug',
      -- After install, build it and rename the dist directory to out
      build = 'npm install --legacy-peer-deps --no-save && npx gulp vsDebugServerBundle && rm -rf out && mv dist out',
      version = '1.*',
    },
    {
      'mxsdev/nvim-dap-vscode-js',
      config = function()
        ---@diagnostic disable-next-line: missing-fields
        require('dap-vscode-js').setup {
          -- Path of node executable. Defaults to $NODE_PATH, and then "node"
          -- node_path = "node",

          -- Path to vscode-js-debug installation.
          debugger_path = vim.fn.resolve(vim.fn.stdpath 'data' .. '/lazy/vscode-js-debug'),

          -- Command to use to launch the debug server. Takes precedence over "node_path" and "debugger_path"
          -- debugger_cmd = { "js-debug-adapter" },

          -- which adapters to register in nvim-dap
          adapters = {
            'chrome',
            'pwa-node',
            'pwa-chrome',
            'pwa-msedge',
            'pwa-extensionHost',
            'node-terminal',
          },

          -- Path for file logging
          -- log_file_path = "(stdpath cache)/dap_vscode_js.log",

          -- Logging level for output to file. Set to false to disable logging.
          -- log_file_level = false,

          -- Logging level for output to console. Set to false to disable console output.
          -- log_console_level = vim.log.levels.ERROR,
        }
      end,
    },
    {
      'Joakker/lua-json5',
      build = './install.sh',
    },
  },
  config = function()
    local dap = require 'dap'
    local dapui = require 'dapui'
    local cmp = require 'cmp'
    local cmp_dap = require 'cmp_dap'
    local dap_text = require 'nvim-dap-virtual-text'
    local path = '~/.local/share/nvim/mason/packages/debugpy/venv/bin/python'

    -- Keymaps
    vim.keymap.set({ 'n', 'v' }, '<leader>du', dapui.toggle, { desc = '[d]ap [u]i' })
    vim.keymap.set({ 'n', 'v' }, '<leader>de', dapui.eval, { desc = '[d]ap [e]val' })
    vim.keymap.set('n', '<leader>db', dap.toggle_breakpoint, { desc = '[d]ap toggle [b]reakpoint' })
    vim.keymap.set('n', '<leader>dr', dap.repl.toggle, { desc = '[d]ap [r]epl' })
    vim.keymap.set('n', '<leader>dt', dap.terminate, { desc = '[d]ap [t]erminate' })
    vim.keymap.set('n', '<leader>di', dap.step_into, { desc = '[d]ap [i]nto' })
    vim.keymap.set('n', '<leader>do', dap.step_over, { desc = '[d]ap [o]ver' })
    vim.keymap.set('n', '<leader>dq', dap.step_out, { desc = '[d]ap [q]uit' })
    vim.keymap.set('n', '<leader>dh', dap.step_back, { desc = '[d]ap [h]istory' })
    vim.keymap.set('n', '<leader>dl', dap.run_last, { desc = '[d]ap [l]ast' })
    vim.keymap.set('n', '<leader>dC', dap.run_to_cursor, { desc = '[d]ap [c]ursor' })
    vim.keymap.set('n', '<leader>dg', dap.goto_, { desc = '[d]ap [g]oto' })
    vim.keymap.set('n', '<leader>dj', dap.down, { desc = '[d]ap down' })
    vim.keymap.set('n', '<leader>dk', dap.up, { desc = '[d]ap up' })
    vim.keymap.set('n', '<leader>dp', dap.pause, { desc = '[d]ap [p]ause' })
    vim.keymap.set('n', '<leader>ds', dap.session, { desc = '[d]ap [s]ession' })
    vim.keymap.set('n', '<leader>dH', function()
      local widgets = require 'dap.ui.widgets'
      widgets.centered_float(widgets.frames)
    end, { desc = '[d]ap [h]over' })
    vim.keymap.set('n', '<leader>dB', function()
      dap.set_breakpoint(vim.fn.input 'Breakpoint condition: ')
    end, { desc = '[dap] toggle condition [b]reakpoint' })
    vim.keymap.set('n', '<leader>dc', function()
      if vim.fn.filereadable '.vscode/launch.json' then
        local dap_vscode = require 'dap.ext.vscode'
        dap_vscode.load_launchjs(nil, {
          ['pwa-node'] = js_based_languages,
          ['chrome'] = js_based_languages,
          ['pwa-chrome'] = js_based_languages,
        })
      end
      dap.continue()
    end, { desc = '[d]ap [c]ontinue' })

    -- Show and hide gitsigns blame when dap is active
    dap_text.setup {
      -- virt_text_win_col = 120,
      -- clear_on_continue = true,
      -- commented = true,
    }
    local hide_info = function()
      vim.diagnostic.enable(false)
      vim.api.nvim_command ':Gitsigns toggle_current_line_blame'
    end

    local show_info = function()
      vim.diagnostic.enable()
      vim.api.nvim_command ':Gitsigns toggle_current_line_blame'
    end

    dap.listeners.after.event_initialized['dapui_config'] = function()
      hide_info()
      dapui.open {}
    end

    dap.listeners.before.event_terminated['dapui_config'] = function()
      show_info()
      dapui.close {}
    end

    dap.listeners.before.event_exited['dapui_config'] = function()
      show_info()
      dapui.close {}
    end

    -- Dap UI setup
    -- For more information, see |:help nvim-dap-ui|
    dapui.setup {
      force_buffers = true,
      icons = { expanded = '', collapsed = '', current_frame = '' },
      mappings = {
        -- Use a table to apply multiple mappings
        expand = { '<CR>', '<2-LeftMouse>' },
        open = 'o',
        remove = 'd',
        edit = 'e',
        repl = 'r',
        toggle = 't',
      },
      -- Use this to override mappings for specific elements
      element_mappings = {
        -- Example:
        -- stacks = {
        --   open = "<CR>",
        --   expand = "o",
        -- }
      },
      -- Expand lines larger than the window
      -- Requires >= 0.7
      expand_lines = vim.fn.has 'nvim-0.7' == 1,
      -- Layouts define sections of the screen to place windows.
      -- The position can be "left", "right", "top" or "bottom".
      -- The size specifies the height/width depending on position. It can be an Int
      -- or a Float. Integer specifies height/width directly (i.e. 20 lines/columns) while
      -- Float value specifies percentage (i.e. 0.3 - 30% of available lines/columns)
      -- Elements are the elements shown in the layout (in order).
      -- Layouts are opened in order so that earlier layouts take priority in window sizing.
      layouts = {
        {
          elements = {
            -- Elements can be strings or table with id and size keys.
            { id = 'scopes', size = 0.25 },
            'breakpoints',
            'stacks',
            'watches',
          },
          size = 20, -- 40 columns
          position = 'right',
        },
        {
          elements = {
            'repl',
            -- "console",
          },
          size = 0.2, -- 25% of total lines
          position = 'bottom',
        },
      },
      controls = {
        -- Requires Neovim nightly (or 0.8 when released)
        enabled = true,
        -- Display controls in this element
        element = 'repl',
        icons = {
          pause = '',
          play = '',
          step_into = '',
          step_over = '',
          step_out = '',
          step_back = '',
          run_last = '',
          terminate = '',
        },
      },
      floating = {
        max_height = nil, -- These can be integers or a float between 0 and 1.
        max_width = nil, -- Floats will be treated as percentage of your screen.
        border = 'double', -- Border style. Can be "single", "double" or "rounded"
        mappings = {
          close = { 'q', '<Esc>' },
        },
      },
      windows = { indent = 1 },
      render = {
        indent = 1,
        max_type_length = 100, -- Can be integer or nil.
        max_value_lines = 100, -- Can be integer or nil.
      },
    }
    dap.set_log_level 'TRACE'
    -- change Breakpoint icon
    vim.fn.sign_define('DapBreakpoint', {
      text = '🅑 ',
      texthl = '',
      linehl = '',
      numhl = '',
    })

    -- setup dap autocomplition
    cmp.setup {
      enabled = function()
        return vim.api.nvim_buf_get_option(0, 'buftype') ~= 'prompt' or cmp_dap.is_dap_buffer()
      end,
    }
    cmp.setup.filetype({ 'dap-repl', 'dapui_watches', 'dapui_hover' }, {
      sources = {
        { name = 'dap' },
      },
    })

    -- Setup dap for python
    require('dap-python').setup(path)
    -- Python debugger adapter
    -- dap.adapters.python = {
    --   type = 'executable',
    --   command = '~/.virtualenvs/debugpy/bin/python',
    --   args = { '-m', 'debugpy.adapter' },
    -- }
    -- Python debuggers
    dap.configurations.python = {
      {
        type = 'python',
        request = 'launch',
        name = 'Django',
        program = vim.fn.getcwd() .. '/manage.py', -- NOTE: Adapt path to manage.py as needed
        args = { 'runserver' },
        django = true,
        subProcess = true,
      },
      {
        type = 'python',
        request = 'attach',
        connect = {
          port = 5678,
          host = 'localhost',
        },
        mode = 'remote',
        name = 'Container Attach (with choose remote dir)',
        cwd = vim.fn.getcwd(),
        pathMappings = {
          {
            localRoot = vim.fn.getcwd(), -- Local project root
            remoteRoot = '/app', -- Path inside the container
          },
        },
        -- Add reconnection settings
        reconnect = true,
        -- Increase timeout to handle reconnection
        subProcess = true,
        autoReload = {
          enable = false,
        },
        -- timeout = 5000,
      },
      {
        type = 'python',
        request = 'attach',
        connect = {
          port = 5676,
          host = 'localhost',
        },
        mode = 'remote',
        name = 'CORE: Container Attach (with choose remote dir)',
        cwd = vim.fn.getcwd(),
        pathMappings = {
          {
            localRoot = vim.fn.getcwd(), -- Local project root
            remoteRoot = '/app', -- Path inside the container
          },
        },
        -- Add reconnection settings
        reconnect = true,
        -- Increase timeout to handle reconnection
        subProcess = true,
        autoReload = {
          enable = false,
        },
        -- timeout = 5000,
      },
      {
        type = 'python',
        request = 'attach',
        connect = {
          port = 5677,
          host = 'localhost',
        },
        mode = 'remote',
        name = 'Inventory: Container Attach (with choose remote dir)',
        cwd = vim.fn.getcwd(),
        pathMappings = {
          {
            localRoot = vim.fn.getcwd(), -- Local project root
            remoteRoot = '/app', -- Path inside the container
          },
        },
        -- Add reconnection settings
        reconnect = true,
        -- Increase timeout to handle reconnection
        subProcess = true,
        autoReload = {
          enable = false,
        },
        -- timeout = 5000,
      },
      {
        -- The first three options are required by nvim-dap
        type = 'python', -- the type here established the link to the adapter definition: `dap.adapters.python`
        request = 'launch',
        name = 'Lunch a file',
        -- Options below are for debugpy, see https://github.com/microsoft/debugpy/wiki/Debug-configuration-settings for supported options
        program = '${file}', -- This configuration will launch the current file if used.
        pythonPath = function()
          -- debugpy supports launching an application with a different interpreter then the one used to launch debugpy itself.
          -- The code below looks for a `venv` or `.venv` folder in the current directly and uses the python within.
          -- You could adapt this - to for example use the `VIRTUAL_ENV` environment variable.
          local cwd = vim.fn.getcwd()
          if vim.fn.executable(cwd .. '/../venv/bin/python') == 1 then
            return cwd .. '/../venv/bin/python'
          end
        end,
      },
    }

    -- setup golang specific config
    require('dap-go').setup()

    -- setup js/ts specific config
    for _, language in ipairs(js_based_languages) do
      dap.configurations[language] = {
        -- Debug single nodejs files
        {
          type = 'pwa-node',
          request = 'launch',
          name = 'Launch file',
          program = '${file}',
          cwd = vim.fn.getcwd(),
          sourceMaps = true,
        },
        -- Debug nodejs processes (make sure to add --inspect when you run the process)
        {
          type = 'pwa-node',
          request = 'attach',
          name = 'Attach',
          processId = require('dap.utils').pick_process,
          cwd = vim.fn.getcwd(),
          sourceMaps = true,
        },
        -- Debug web applications (client side)
        {
          type = 'pwa-chrome',
          request = 'launch',
          name = 'Launch & Debug Chrome',
          url = function()
            local co = coroutine.running()
            return coroutine.create(function()
              vim.ui.input({
                prompt = 'Enter URL: ',
                default = 'http://localhost:3000',
              }, function(url)
                if url == nil or url == '' then
                  return
                else
                  coroutine.resume(co, url)
                end
              end)
            end)
          end,
          webRoot = vim.fn.getcwd(),
          protocol = 'inspector',
          sourceMaps = true,
          userDataDir = false,
        },
        -- Divider for the launch.json derived configs
        {
          name = '----- ↓ launch.json configs ↓ -----',
          type = '',
          request = 'launch',
        },
      }
    end
  end,
}

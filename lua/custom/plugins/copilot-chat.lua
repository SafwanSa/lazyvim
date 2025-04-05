return {
  {
    -- Plugin configuration for CopilotChat.nvim
    'CopilotC-Nvim/CopilotChat.nvim',
    dependencies = {
      -- Required dependency for Copilot functionality
      { 'zbirenbaum/copilot.lua' },
      -- Utility functions provided by plenary.nvim
      { 'nvim-lua/plenary.nvim', branch = 'master' },
    },
    -- Build command for setting up the plugin (specific to MacOS or Linux)
    build = 'make tiktoken',
    opts = {
      question_header = '# Safwan ', -- Header to use for user questions
      mappings = {
        -- Uncomment and configure these mappings to customize prompt submission
        -- submit_prompt = {
        --   normal = '<Leader>s', -- Mapping for normal mode
        --   insert = '<C-s>',    -- Mapping for insert mode
        -- },
        show_diff = {
          -- Enable full diff view for changes
          full_diff = true,
        },
      },
      sticky = {
        -- Sticky options for CopilotChat
        -- Example: '@models Using Mistral-small'
        '#files',
      },
    },
    keys = {
      -- Key mappings for normal and visual modes
      { '<leader>cc', ':CopilotChatToggle<cr>', mode = { 'n', 'v' }, desc = '[C]opilot [C]hat' },
      { '<leader>cm', ':CopilotChatCommit<cr>', mode = { 'n', 'v' }, desc = '[C]opilot [C]ommit' },
      { '<leader>ce', ':CopilotChatExplain<cr>', mode = 'v', desc = '[C]opilot [E]xplain' },
      { '<leader>cr', ':CopilotChatReview<cr>', mode = 'v', desc = '[C]opilot [R]eview' },
      { '<leader>cf', ':CopilotChatFix<cr>', mode = 'v', desc = '[C]opilot [F]ix' },
      { '<leader>co', ':CopilotChatOptimize<cr>', mode = 'v', desc = '[C]opilot [O]ptimize' },
      { '<leader>cds', ':CopilotChatDocs<cr>', mode = 'v', desc = '[C]opilot [D]oc[S]' },
    },
  },
}

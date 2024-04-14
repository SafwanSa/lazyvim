return {
  {
    'kkoomen/vim-doge',
    opts = {},
    config = function(_, opts)
      vim.cmd ':call doge#install()'
    end,
  },
}

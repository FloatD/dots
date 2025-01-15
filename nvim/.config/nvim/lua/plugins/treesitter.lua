return {
  'nvim-treesitter/nvim-treesitter',
  run = function()
    require('nvim-treesitter.install').update({ with_sync = true })
  end,
  config = function()
    require('nvim-treesitter.configs').setup {
      ensure_installed = { "c", "cpp", "lua", "python", "javascript", "html", "css", "markdown", "robot" },
      highlight = {
        enable = true, -- false will disable the whole extension
      },
      autopairs = {
        enable = true,
      },
    }
  end,
}

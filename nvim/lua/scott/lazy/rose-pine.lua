function ColorScreen(color)
    color = color or 'rose-pine'
    vim.cmd.colorscheme(color)
end

return {
    {
      'rose-pine/neovim',
      lazy = false,
      name = 'rose-pine',
      config = function()
          vim.cmd('colorscheme rose-pine-moon')
          ColorScreen()
      end,
    },
}

return {
  {
    "kepano/flexoki-neovim",
    name = "flexoki",
    priority = 1000, -- load before other plugins
    config = function()
      vim.cmd.colorscheme("flexoki-dark")
    end,
  },
}

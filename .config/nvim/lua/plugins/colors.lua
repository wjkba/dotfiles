local function enable_transparency()
    vim.api.nvim_set_hl(0, "Normal", {bg = "none"})
end

return {
  {
    "nobbmaestro/nvim-andromeda",
    lazy = false,
    priority = 1000,
    dependencies = {
      "tjdevries/colorbuddy.nvim",
    },
    config = function()
      vim.cmd('colorscheme andromeda')
      enable_transparency()
    end,
  },
  {
    "nvim-lualine/lualine.nvim",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    opts = {
      theme = "auto",
    },
  },
}
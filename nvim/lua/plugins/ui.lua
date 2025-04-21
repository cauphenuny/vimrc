return {
  -- add gruvbox
  {
    "sainnhe/gruvbox-material",
    init = function()
      vim.o.background = "dark"
      vim.g.gruvbox_material_enable_italic = 1
      vim.g.gruvbox_material_enable_bold = 0
      if vim.g.neovide then
        vim.g.gruvbox_material_foreground = "material"
      else
        vim.g.gruvbox_material_foreground = "material"
        local columns = vim.o.columns
        local lines = vim.o.lines
        if columns < 120 and lines < 40 then
          vim.g.gruvbox_material_transparent_background = 2
        end
      end
      vim.g.gruvbox_material_diagnostic_text_highlight = 1
    end,
  },
  { "catppuccin/nvim" },
  { "shaunsingh/nord.nvim" },
  { "rebelot/kanagawa.nvim" },
  { "projekt0n/github-nvim-theme" },
  { "marko-cerovac/material.nvim" },
  { "neanias/everforest-nvim" },

  -- Configure LazyVim to load gruvbox
  {
    "LazyVim/LazyVim",
    opts = {
      colorscheme = "gruvbox-material",
      -- colorscheme = "kanagawa",
    },
    priority = 1000,
  },

  -- dashboard
  {
    "folke/snacks.nvim",
    ---@type snacks.Config
    opts = {
      dashboard = {
        preset = {
          header = [[
███╗   ██╗███████╗ ██████╗ ██╗   ██╗██╗███╗   ███╗
████╗  ██║██╔════╝██╔═══██╗██║   ██║██║████╗ ████║
██╔██╗ ██║█████╗  ██║   ██║██║   ██║██║██╔████╔██║
██║╚██╗██║██╔══╝  ██║   ██║╚██╗ ██╔╝██║██║╚██╔╝██║
██║ ╚████║███████╗╚██████╔╝ ╚████╔╝ ██║██║ ╚═╝ ██║
╚═╝  ╚═══╝╚══════╝ ╚═════╝   ╚═══╝  ╚═╝╚═╝     ╚═╝]],
        },
        -- sections = {
        --   { section = "header" },
        --   { icon = " ", title = "Keymaps", section = "keys", indent = 2, padding = 1 },
        --   { icon = " ", title = "Recent Files", section = "recent_files", indent = 2, padding = 1 },
        --   { icon = " ", title = "Projects", section = "projects", indent = 2, padding = 1 },
        --   { section = "startup" },
        -- },
        sections = {
          { section = "header" },
          { section = "keys", gap = 1, padding = { 3, 0 } },
          { icon = " ", title = "Recent Files", section = "recent_files", indent = 2, padding = 2 },
          { icon = " ", title = "Projects", section = "projects", indent = 2, padding = 2 },
          { section = "startup" },
        },
      },
    },
  },
}

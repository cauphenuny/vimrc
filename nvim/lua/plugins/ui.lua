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
  {
    "catppuccin/nvim",
    opts = {
      -- transparent_background = true,
    },
  },
  { "shaunsingh/nord.nvim" },
  {
    "rebelot/kanagawa.nvim",
    opts = {
      -- transparent = true,
      colors = {
        theme = {
          all = {
            ui = {
              bg_gutter = "none",
            },
          },
        },
      },
      overrides = function(colors)
        local theme = colors.theme
        return {
          Pmenu = { fg = theme.ui.shade0, bg = theme.ui.bg_p1 }, -- add `blend = vim.o.pumblend` to enable transparency
          PmenuSel = { fg = "NONE", bg = theme.ui.bg_p2 },
          PmenuSbar = { bg = theme.ui.bg_m1 },
          PmenuThumb = { bg = theme.ui.bg_p2 },
          NormalFloat = { bg = "none" },
          FloatBorder = { bg = "none" },
          FloatTitle = { bg = "none" },
          -- Save an hlgroup with dark background and dimmed foreground
          -- so that you can use it where your still want darker windows.
          -- E.g.: autocmd TermOpen * setlocal winhighlight=Normal:NormalDark
          NormalDark = { fg = theme.ui.fg_dim, bg = theme.ui.bg_m3 },
          -- Popular plugins that open floats will link to NormalFloat by default;
          -- set their background accordingly if you wish to keep them dark and borderless
          LazyNormal = { bg = theme.ui.bg_m3, fg = theme.ui.fg_dim },
          MasonNormal = { bg = theme.ui.bg_m3, fg = theme.ui.fg_dim },
        }
      end,
    },
  },
  { "thesimonho/kanagawa-paper.nvim" },
  { "projekt0n/github-nvim-theme" },
  { "marko-cerovac/material.nvim" },
  { "neanias/everforest-nvim" },

  -- Configure LazyVim to load gruvbox
  {
    "LazyVim/LazyVim",
    opts = {
      -- colorscheme = "catppuccin-macchiato",
      colorscheme = "kanagawa",
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

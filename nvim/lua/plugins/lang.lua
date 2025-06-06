local function open_chrome()
  if vim.fn.has("mac") == 1 then
    vim.fn.system([[
      osascript -e 'tell application "Google Chrome"
          activate
          make new window
          delay 1
      end tell'
    ]])
  end
end
return {
  {
    "nvim-treesitter",
    opts = {
      ensure_installed = { "verilog", "typst" },
      highlight = { enable = { "verilog" } },
    },
  },
  {
    "chomosuke/typst-preview.nvim",
    ft = "typst",
    version = "1.*",
    opts = {
      dependencies_bin = { ["tinymist"] = "tinymist" },
    },
    config = function(_, opts)
      require("typst-preview").setup(opts)
      local wk = require("which-key")
      wk.add({
        { "<localleader>t", group = "typst-preview" },
        { "<localleader>tc", open_chrome, desc = "Open Chrome Window" },
        { "<localleader>tp", "<cmd>TypstPreview<cr>", desc = "Open Typst Preview" },
      })
    end,
  },
  -- Tex
  {
    "vimtex",
    ft = { "tex" },
    init = function()
      vim.g.maplocalleader = "\\"
      vim.g.tex_flavor = "latex"
      vim.g.vimtex_compiler_latexmk_engines = {
        ["_"] = "-xelatex", -- default
        ["pdflatex"] = "-pdf",
        ["dvipdfex"] = "-pdfdvi",
        ["lualatex"] = "-lualatex",
        ["xelatex"] = "-xelatex",
        ["context (pdftex)"] = "-pdf -pdflatex=texexec",
        ["context (luatex)"] = "-pdf -pdflatex=context",
        ["context (xetex)"] = "-pdf -pdflatex='texexec --xtx'",
      }
      vim.g.vimtex_view_method = "skim"
    end,
  },
  {
    "jceb/vim-orgmode",
  },
  -- python
  {
    "linux-cultist/venv-selector.nvim",
    dependencies = { "neovim/nvim-lspconfig", "nvim-telescope/telescope.nvim", "mfussenegger/nvim-dap-python" },
    opts = {
      -- Your options go here
      -- name = "venv",
      -- auto_refresh = false
    },
    event = "VeryLazy", -- Optional: needed only if you want to type `:VenvSelect` without a keymapping
    keys = {
      -- Keymap to open VenvSelector to pick a venv.
      { "<leader>vs", "<cmd>VenvSelect<cr>" },
      -- Keymap to retrieve the venv from a cache (the one previously used for the same project directory).
      { "<leader>vc", "<cmd>VenvSelectCached<cr>" },
    },
  },
}
